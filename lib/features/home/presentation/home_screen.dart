import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/history_repository.dart';
import '../../../core/data/profile_repository.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/services/haptics_service.dart';
import '../../../core/widgets/history_entry_card.dart';
import '../../../core/widgets/nutri_gradient_button.dart';
import '../../../core/widgets/nutri_pill.dart';
import '../../history/presentation/history_sheet.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final historyState = ref.watch(historyControllerProvider);
    final isOffline = ref.watch(connectivityProvider);
    final ctaPressed = useState(false);
    final theme = Theme.of(context);

    final latest = historyState.entries.isNotEmpty ? historyState.entries.first : null;

    Future<void> handleScan() async {
      await ref.read(hapticsServiceProvider).lightImpact();
      ctaPressed.value = true;
      await Future<void>.delayed(const Duration(milliseconds: 180));
      ctaPressed.value = false;
      if (context.mounted) {
        context.pushNamed('camera');
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.surface,
                  theme.colorScheme.primary.withValues(alpha: 0.08),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                              child: Icon(Icons.eco, color: theme.colorScheme.primary),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => context.goNamed('settings'),
                              icon: const Icon(Icons.settings_outlined),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (isOffline)
                          NutriPill(
                            label: 'Offline Mode',
                            icon: Icons.wifi_off,
                            background: theme.colorScheme.secondary.withValues(alpha: 0.25),
                          ).animate().fadeIn(duration: 400.ms),
                        const SizedBox(height: 24),
                        Text(
                          'Hi ${profile?.name ?? 'friend'},',
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Builder(builder: (context) {
                          final now = DateTime.now();
                          // If location-based sunrise/sunset is unavailable, fall back to general daytime anchors.
                          const noonHour = 12;
                          const sunsetHour = 18;
                          const sunriseHour = 6; // allow breakfast window to start a bit before midday anchor
                          final hour = now.hour;
                          String prompt;
                          if (hour < noonHour && hour >= sunriseHour) {
                            prompt = 'Breakfast is the most important meal! \\(^_^)/';
                          } else if (hour >= noonHour && hour < sunsetHour) {
                            prompt = 'Perfect time for lunch~ (o^_^o)';
                          } else {
                            prompt = 'Seems like it\'s dinner time (¬‿¬)';
                          }
                          return Text(
                            prompt,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          );
                        }),
                        const SizedBox(height: 24),
                        Center(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1, end: ctaPressed.value ? 0.95 : 1),
                            duration: const Duration(milliseconds: 200),
                            builder: (context, value, child) {
                              return Transform.scale(scale: value, child: child);
                            },
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 520, minWidth: 480),
                              child: NutriGradientButton(
                                label: 'Scan a Meal',
                                icon: Icons.bolt,
                                onPressed: handleScan,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (latest != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Latest scan',
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 12),
                              HistoryEntryCard(
                                analysis: latest,
                                onTap: () => context.pushNamed('results', pathParameters: {'id': latest.id}),
                              ),
                            ],
                          )
                        else
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('No scans yet', style: theme.textTheme.titleMedium),
                                const SizedBox(height: 8),
                                Text(
                                  'Your history will appear here after your first scan.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 380),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const HomeHistorySheet(),
        ],
      ),
    );
  }
}
