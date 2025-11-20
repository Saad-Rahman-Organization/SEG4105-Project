import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/mock_data.dart';
import '../../camera/providers/capture_providers.dart';
import '../../results/providers/analysis_draft_provider.dart';

class ProcessingScreen extends HookConsumerWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payload = ref.watch(capturePayloadProvider);
    final hints = [
      'Detecting ingredients...',
      'Estimating portion sizes...',
      'Balancing macros...',
      'Cross-checking allergens...',
    ];
    final hintIndex = useState(0);
    final uuid = useMemoized(Uuid.new);

    useEffect(() {
      Timer? timer;
      timer = Timer.periodic(const Duration(seconds: 2), (_) {
        hintIndex.value = (hintIndex.value + 1) % hints.length;
      });
      return () => timer?.cancel();
    }, []);

    useEffect(() {
      if (payload == null) return null;
      bool cancelled = false;
      Future<void> run() async {
        try {
          await Future<void>.delayed(const Duration(seconds: 3));
          if (cancelled) return;
          final template = MockData.sampleAnalyses.first;
          final analysis = template.copyWith(
            id: uuid.v4(),
            localId: payload.localId,
            timestamp: DateTime.now(),
          );
          ref.read(analysisDraftProvider.notifier).state = analysis;
          ref.read(capturePayloadProvider.notifier).state = null;
          if (context.mounted) {
            context.goNamed('results', pathParameters: {'id': analysis.id});
          }
        } catch (error) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Analysis failed. Please try again.')),
            );
            context.pop();
          }
        }
      }

      run();
      return () => cancelled = true;
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
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      hints[hintIndex.value],
                      key: ValueKey(hints[hintIndex.value]),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
