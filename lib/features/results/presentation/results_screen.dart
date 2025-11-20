import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/history_repository.dart';
import '../../../core/models/meal_models.dart';
import '../../../core/widgets/nutri_gradient_button.dart';
import '../../../core/utils/formatters.dart';
import '../providers/analysis_draft_provider.dart';
import '../widgets/macro_donut_chart.dart';

final mealAnalysisProvider = FutureProvider.family<MealAnalysis?, String>((ref, id) async {
  final draft = ref.watch(analysisDraftProvider);
  if (draft?.id == id) return draft;
  final state = ref.watch(historyControllerProvider);
  final cached = state.entries.where((element) => element.id == id).firstOrNull;
  if (cached != null) return cached;
  return ref.read(historyRepositoryProvider).getScan(id);
});

class ResultsScreen extends HookConsumerWidget {
  const ResultsScreen({super.key, required this.mealId});

  final String mealId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(mealAnalysisProvider(mealId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: analysisAsync.when(
        data: (analysis) {
          if (analysis == null) {
            return const Center(child: Text('No analysis found.'));
          }
          return _ResultsBody(analysis: analysis);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error loading results: $error')),
      ),
    );
  }
}

class _ResultsBody extends HookConsumerWidget {
  const _ResultsBody({required this.analysis});

  final MealAnalysis analysis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDraft = ref.watch(analysisDraftProvider)?.id == analysis.id;
    final saved = useState(!isDraft);

    useEffect(() {
      saved.value = !isDraft;
      return null;
    }, [isDraft]);

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.surface,
                  theme.colorScheme.surfaceContainerHighest,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _HeroCard(analysis: analysis),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        _InfoChip(
                          icon: Icons.shield_moon_outlined,
                          label: '${analysis.confidence.name[0].toUpperCase()}${analysis.confidence.name.substring(1)} confidence',
                        ),
                        _InfoChip(
                          icon: Icons.schedule,
                          label:
                              '${NutriFormatters.shortDay(analysis.timestamp)} ${NutriFormatters.time(analysis.timestamp)}',
                        ),
                        if (analysis.mealTag != null && analysis.mealTag!.isNotEmpty)
                          _InfoChip(
                            icon: Icons.restaurant_menu,
                            label: analysis.mealTag!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
                      title: 'Macro Balance',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MacroDonutChart(macros: analysis.macros),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _MacroStat(label: 'Protein', value: NutriFormatters.grams(analysis.macros.protein)),
                              _MacroStat(label: 'Carbs', value: NutriFormatters.grams(analysis.macros.carbs)),
                              _MacroStat(label: 'Fat', value: NutriFormatters.grams(analysis.macros.fat)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (analysis.ingredients.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _SectionCard(
                        title: 'Ingredients',
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: analysis.ingredients
                              .map(
                                (ingredient) => Chip(
                                  label: Text(
                                    ingredient.portionSize == null
                                        ? ingredient.name
                                        : '${ingredient.name} (${ingredient.portionSize})',
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    _SectionCard(
                      title: 'Identified Foods',
                      child: Column(
                        children: analysis.identifiedFoods
                            .map(
                              (food) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Material(
                                  color: theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    title: Text(food.name, style: theme.textTheme.titleMedium),
                                    subtitle: Text(
                                      _foodSubtitle(food),
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    trailing:
                                        Icon(Icons.chevron_right, color: theme.colorScheme.primary, size: 20),
                                    onTap: () => _showFoodDetails(context, food),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
                      title: 'Notes',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            analysis.qualitativeFeedback,
                            style: theme.textTheme.bodyLarge,
                          ),
                          if (analysis.warnings.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            ...analysis.warnings.map(
                              (warning) => Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded, size: 18, color: theme.colorScheme.error),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(warning)),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    NutriGradientButton(
                      label: 'Scan Another Meal',
                      icon: Icons.camera_alt_outlined,
                      onPressed: () => context.pushNamed('camera'),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.home_outlined),
                            label: const Text('Back to Home'),
                            onPressed: () => context.goNamed('home'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            icon: const Icon(Icons.bookmark_added_outlined),
                            label: Text(saved.value ? 'Saved' : 'Save to History'),
                            onPressed: saved.value
                                ? null
                                : () async {
                                    await ref.read(historyControllerProvider.notifier).addAnalysis(analysis);
                                    ref.read(analysisDraftProvider.notifier).state = null;
                                    saved.value = true;
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Saved to history')),
                                      );
                                    }
                                  },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _foodSubtitle(IdentifiedFood food) {
    final parts = <String>[];
    if (food.portionSize != null && food.portionSize!.isNotEmpty) {
      parts.add(food.portionSize!.trim());
    }
    parts.add('${food.calories} kcal');
    parts.add(
      'P ${NutriFormatters.gramsShort(food.macros.protein)} / C ${NutriFormatters.gramsShort(food.macros.carbs)} / F ${NutriFormatters.gramsShort(food.macros.fat)}',
    );
    return parts.join(' | ');
  }

  void _showFoodDetails(BuildContext context, IdentifiedFood food) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(food.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('${food.calories} kcal'),
              if (food.portionSize != null) ...[
                const SizedBox(height: 4),
                Text('Portion: ${food.portionSize}'),
              ],
              const SizedBox(height: 12),
              Text('Macros', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('Protein: ${NutriFormatters.grams(food.macros.protein)}'),
              Text('Carbs: ${NutriFormatters.grams(food.macros.carbs)}'),
              Text('Fat: ${NutriFormatters.grams(food.macros.fat)}'),
              const SizedBox(height: 12),
              if (food.highlights != null)
                Wrap(
                  spacing: 8,
                  children: food.highlights!
                      .map((highlight) => Chip(label: Text(highlight)))
                      .toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
      label: Text(label),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}

class _MacroStat extends StatelessWidget {
  const _MacroStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.analysis});

  final MealAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.08),
            theme.colorScheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.restaurant_outlined, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(analysis.mealTitle, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(
                      'Captured ${NutriFormatters.shortDay(analysis.timestamp)} ${NutriFormatters.time(analysis.timestamp)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Chip(
                label: Text('${analysis.totalCalories} kcal'),
                avatar: const Icon(Icons.local_fire_department_outlined, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _HeroMetric(label: 'Protein', value: NutriFormatters.grams(analysis.macros.protein)),
              _HeroMetric(label: 'Carbs', value: NutriFormatters.grams(analysis.macros.carbs)),
              _HeroMetric(label: 'Fat', value: NutriFormatters.grams(analysis.macros.fat)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 6),
        Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
