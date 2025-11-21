import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/meal_analysis_service.dart';
import '../../camera/providers/capture_providers.dart';
import '../../results/providers/analysis_draft_provider.dart';

typedef ProcessingPhase = ({String title, String subtitle, IconData icon});

class ProcessingScreen extends HookConsumerWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payload = ref.watch(capturePayloadProvider);
    final retryToken = useState(0);
    final hasActiveJob = useState(false);
    final phaseIndex = useState(0);
    final progress = useState(0.08);
    final elapsed = useState(const Duration());
    final errorMessage = useState<String?>(null);
    final discoveredSummary = useState<String?>(null);
    final percent = useState(8);
    final percentTimer = useRef<Timer?>(null);
    final phases = useMemoized<List<ProcessingPhase>>(
      () => const [
        (title: 'Uploading image', subtitle: 'Securing your snap before analysis.', icon: Icons.cloud_upload_outlined),
        (title: 'Analyzing plate', subtitle: 'Spotting foods and estimating portions.', icon: Icons.restaurant_outlined),
        (title: 'Crunching nutrition', subtitle: 'Balancing macros, fiber, and calories.', icon: Icons.timeline_outlined),
        (title: 'Drafting insights', subtitle: 'Writing tips tailored to your meal.', icon: Icons.edit_note_outlined),
      ],
    );

    useEffect(() {
      if (payload == null) return null;
      bool cancelled = false;
      final stopwatch = Stopwatch()..start();
      Timer? ticker;
      Timer? stepper;
      ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        elapsed.value = stopwatch.elapsed;
      });
      void updateProgress(double value, {bool forceTarget100 = false}) {
        final clamped = value.clamp(0.0, 1.0);
        progress.value = clamped;
        final current = percent.value;
        final random = Random();
        final upperTarget = forceTarget100 ? 100 : min(99, (clamped * 100).ceil());
        if (upperTarget <= current) return;
        final minStep = forceTarget100 ? current + 1 : current + 5;
        final targetFloor = min(upperTarget, minStep);
        final target = targetFloor >= upperTarget
            ? upperTarget
            : targetFloor + random.nextInt(upperTarget - targetFloor + 1);

        percentTimer.value?.cancel();
        percentTimer.value = Timer.periodic(const Duration(milliseconds: 28), (timer) {
          if (percent.value >= target) {
            timer.cancel();
            return;
          }
          percent.value = percent.value + 1;
        });
      }
      void startStepper() {
        stepper?.cancel();
        stepper = Timer.periodic(const Duration(milliseconds: 1200), (_) {
          if (phaseIndex.value < phases.length - 1) {
            phaseIndex.value = phaseIndex.value + 1;
            updateProgress(((phaseIndex.value + 1) / (phases.length + 1)).clamp(0.0, 0.92));
          }
        });
      }
      startStepper();

      Future<void> run() async {
        try {
          hasActiveJob.value = true;
          errorMessage.value = null;
          updateProgress(0.12);
          final service = ref.read(mealAnalysisServiceProvider);
          final analysisFuture = service.analyzeMeal(payload: payload);
          final minDisplay = Future.delayed(const Duration(seconds: 3));
          final analysis = await analysisFuture;
          await minDisplay;
          if (cancelled) return;
          discoveredSummary.value =
              'Found ${analysis.identifiedFoods.length} items · ${analysis.totalCalories} kcal total';
          updateProgress(1.0, forceTarget100: true);
          phaseIndex.value = phases.length - 1;
          ref.read(analysisDraftProvider.notifier).state = analysis;
          ref.read(capturePayloadProvider.notifier).state = null;
          if (context.mounted) {
            await Future.delayed(const Duration(milliseconds: 700));
            context.goNamed('results', pathParameters: {'id': analysis.id});
          }
        } on MealAnalysisException catch (error) {
          errorMessage.value = error.message;
        } catch (error) {
          errorMessage.value = 'Analysis failed. Please try again.';
        } finally {
          stopwatch.stop();
          ticker?.cancel();
          stepper?.cancel();
        }
      }

      run();
      return () {
        cancelled = true;
        stopwatch.stop();
        ticker?.cancel();
        stepper?.cancel();
        percentTimer.value?.cancel();
      };
    }, [payload, retryToken.value]);

    return Scaffold(
      body: (payload == null && !hasActiveJob.value)
          ? _EmptyProcessingState(onNavigate: () => context.goNamed('camera'))
          : _ProcessingBody(
              phases: phases,
              phaseIndex: phaseIndex.value,
              progress: progress.value,
              elapsed: elapsed.value,
              discoveredSummary: discoveredSummary.value,
              errorMessage: errorMessage.value,
              percent: percent.value.clamp(0, 100),
              onRetry: () => retryToken.value++,
            ),
    );
  }
}

class _ProcessingBody extends StatelessWidget {
  const _ProcessingBody({
    required this.phases,
    required this.phaseIndex,
    required this.progress,
    required this.elapsed,
    required this.discoveredSummary,
    required this.errorMessage,
    required this.percent,
    required this.onRetry,
  });

  final List<ProcessingPhase> phases;
  final int phaseIndex;
  final double progress;
  final Duration elapsed;
  final String? discoveredSummary;
  final String? errorMessage;
  final int percent;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clampedIndex = phaseIndex.clamp(0, phases.length - 1).toInt();
    final phase = phases[clampedIndex];
    final showError = errorMessage != null;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ProgressCircle(
              progress: showError ? 0 : progress,
              percent: percent,
            ),
            const SizedBox(height: 16),
            Text(
              showError ? 'Something went wrong' : 'Hang tight while we process your meal',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              showError ? 'We couldn’t finish your analysis.' : 'Elapsed ${elapsed.inSeconds}s',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (showError)
              _StatusCard(
                icon: Icons.error_outline,
                title: 'Analysis failed',
                subtitle: errorMessage!,
                color: theme.colorScheme.error,
                onPrimary: theme.colorScheme.onError,
              )
            else
              AnimatedSwitcher(
                duration: 350.ms,
                transitionBuilder: (child, anim) => SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
                    CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
                  ),
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: _StatusCard(
                  key: ValueKey(phase.title),
                  icon: phase.icon,
                  title: discoveredSummary ?? phase.title,
                  subtitle: discoveredSummary ?? phase.subtitle,
                  color: theme.colorScheme.surfaceContainerHighest,
                  onPrimary: theme.colorScheme.onSurface,
                ),
              ),
            if (showError) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Back'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onPrimary,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color onPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: onPrimary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: onPrimary, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCircle extends StatelessWidget {
  const _ProgressCircle({
    required this.progress,
    required this.percent,
  });

  final double progress;
  final int percent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = progress.clamp(0.0, 1.0);
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
           size: const Size(240, 240),
            painter: _ArcPainter(
              progress: 1,
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
              strokeWidth: 22,
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: foreground),
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return CustomPaint(
                size: const Size(240, 240),
                painter: _ArcPainter(
                  progress: value,
                  color: theme.colorScheme.primary,
                  strokeWidth: 22,
                ),
              );
            },
          ),
          Text(
            '$percent%',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  const _ArcPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress.clamp(0.0, 1.0);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect.deflate(strokeWidth / 2 + 2), startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}

class _EmptyProcessingState extends StatelessWidget {
  const _EmptyProcessingState({required this.onNavigate});

  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.no_photography, size: 64),
          const SizedBox(height: 12),
          Text('No capture to process.', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: onNavigate,
            child: const Text('Capture a Meal'),
          ),
        ],
      ),
    );
  }
}
