import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/meal_analysis_service.dart';
import '../../camera/providers/capture_providers.dart';
import '../../results/providers/analysis_draft_provider.dart';

class ProcessingScreen extends HookConsumerWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payload = ref.watch(capturePayloadProvider);
    final status = useState('Preparing your photo...');
    final elapsed = useState(const Duration());

    useEffect(() {
      if (payload == null) return null;
      bool cancelled = false;
      final stopwatch = Stopwatch()..start();
      Timer? ticker;
      ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        elapsed.value = stopwatch.elapsed;
      });

      Future<void> run() async {
        try {
          status.value = 'Uploading photo...';
          final service = ref.read(mealAnalysisServiceProvider);
          final analysis = await service.analyzeMeal(payload: payload);
          if (cancelled) return;
          ref.read(analysisDraftProvider.notifier).state = analysis;
          ref.read(capturePayloadProvider.notifier).state = null;
          if (context.mounted) {
            context.goNamed('results', pathParameters: {'id': analysis.id});
          }
        } on MealAnalysisException catch (error) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.message)),
            );
            context.pop();
          }
        } catch (error) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Analysis failed. Please try again.')),
            );
            context.pop();
          }
        } finally {
          stopwatch.stop();
          ticker?.cancel();
        }
      }

      run();
      return () {
        cancelled = true;
        stopwatch.stop();
        ticker?.cancel();
      };
    }, [payload]);

    return Scaffold(
      body: Center(
        child: payload == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.no_photography, size: 64),
                  const SizedBox(height: 12),
                  const Text('No capture to process.'),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => context.goNamed('camera'),
                    child: const Text('Capture a Meal'),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ).animate().rotate(duration: 1.4.seconds),
                  const SizedBox(height: 24),
                  Text(
                    'Analyzing your meal...',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    status.value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Elapsed: ${elapsed.value.inSeconds}s',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
