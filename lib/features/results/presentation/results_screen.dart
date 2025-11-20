import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/history_repository.dart';
import '../../../core/models/meal_models.dart';
import '../../../core/widgets/nutri_gradient_button.dart';
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
    final isDraft = ref.watch(analysisDraftProvider)?.id == analysis.id;
    final saved = useState(!isDraft);

    useEffect(() {
      saved.value = !isDraft;
      return null;
    }, [isDraft]);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                _HeroCard(analysis: analysis),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Macros', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        MacroDonutChart(macros: analysis.macros),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Identified Foods', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        ...analysis.identifiedFoods.map(
                          (food) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(food.name),
                            subtitle: Text('${food.calories} kcal | ${food.macros.protein}g protein'),
                            trailing: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.primary),
                            onTap: () => _showFoodDetails(context, food),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Feedback', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        Text(
                          analysis.qualitativeFeedback,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 12),
                        ...analysis.warnings.map(
                          (warning) => Row(
                            children: [
                              const Icon(Icons.warning_amber_rounded, size: 18),
                              const SizedBox(width: 8),
                              Expanded(child: Text(warning)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                NutriGradientButton(
                  label: 'Scan New Meal',
                  icon: Icons.camera_alt_outlined,
                  onPressed: () => context.pushNamed('camera'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
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
                  child: Text(saved.value ? 'Saved!' : 'Save to History'),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
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
              const SizedBox(height: 12),
              Text('Macros', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('Protein: ${food.macros.protein}g'),
              Text('Carbs: ${food.macros.carbs}g'),
              Text('Fat: ${food.macros.fat}g'),
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

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.analysis});

  final MealAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(analysis.mealTitle, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${analysis.totalCalories} kcal',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 12),
                Chip(
                  label: Text('${analysis.confidence.name} confidence'),
                  avatar: const Icon(Icons.shield_moon_outlined, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Captured at ${analysis.timestamp.hour.toString().padLeft(2, '0')}:${analysis.timestamp.minute.toString().padLeft(2, '0')}',
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

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
