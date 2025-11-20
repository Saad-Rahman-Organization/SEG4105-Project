import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/history_repository.dart';
import '../../../core/models/meal_models.dart';
import '../../../core/widgets/nutri_gradient_button.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/data/profile_repository.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/services/correction_service.dart';
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
    final analysisValue = analysisAsync.asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        actions: [
          IconButton(
            tooltip: 'Edit',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              final current = analysisValue;
              if (current == null) return;
              await _openEditSheet(context, ref, current);
            },
          ),
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
    final profile = ref.watch(profileProvider);
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
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit analysis'),
                        onPressed: () => _openEditSheet(context, ref, analysis),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _NutritionBreakdownCard(
                      analysis: analysis,
                      profile: profile,
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
                    const SizedBox(height: 16),
                    _SectionCard(
                      title: 'Nutrient Highlights',
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _HighlightPill(
                            icon: Icons.eco_outlined,
                            label: 'Fiber',
                            value: NutriFormatters.grams(analysis.totalFiber),
                          ),
                          _HighlightPill(
                            icon: Icons.restaurant_outlined,
                            label: 'Items',
                            value: '${analysis.identifiedFoods.length} foods',
                          ),
                          _HighlightPill(
                            icon: Icons.local_fire_department_outlined,
                            label: 'Density',
                            value:
                                '${(analysis.totalCalories / (analysis.identifiedFoods.length.clamp(1, 99))).round()} kcal / item',
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
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(18),
                                  onTap: () => _showFoodDetails(context, food),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(color: theme.colorScheme.surfaceContainerHighest),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 44,
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color: theme.colorScheme.primary.withValues(alpha: 0.12),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.restaurant_menu, size: 22),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(food.name, style: theme.textTheme.titleMedium),
                                                const SizedBox(height: 4),
                                                Text(
                                                  _foodSubtitle(food),
                                                  style: theme.textTheme.bodyMedium?.copyWith(
                                                    color: theme.colorScheme.onSurfaceVariant,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(Icons.expand_more, color: theme.colorScheme.primary),
                                        ],
                                      ),
                                    ),
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
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.45,
          maxChildSize: 0.9,
          snap: true,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.restaurant, color: theme.colorScheme.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(food.name, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            Text(_foodSubtitle(food), style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Chip(label: Text('${food.calories} kcal')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (food.portionSize != null && food.portionSize!.isNotEmpty)
                        Chip(
                          avatar: const Icon(Icons.scale_outlined, size: 16),
                          label: Text(food.portionSize!),
                        ),
                      Chip(
                        avatar: const Icon(Icons.bolt_outlined, size: 16),
                        label: Text('Protein ${NutriFormatters.grams(food.macros.protein)}'),
                      ),
                      Chip(
                        avatar: const Icon(Icons.grass_outlined, size: 16),
                        label: Text('Carbs ${NutriFormatters.grams(food.macros.carbs)}'),
                      ),
                      Chip(
                        avatar: const Icon(Icons.oil_barrel_outlined, size: 16),
                        label: Text('Fat ${NutriFormatters.grams(food.macros.fat)}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  if (food.highlights != null && food.highlights!.isNotEmpty) ...[
                    Text('Highlights', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: food.highlights!
                          .map(
                            (highlight) => Chip(
                              label: Text(highlight),
                              backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.12),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Future<void> _openEditSheet(BuildContext context, WidgetRef ref, MealAnalysis analysis) async {
  final result = await showModalBottomSheet<_EditResult>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _EditAnalysisSheet(analysis: analysis),
  );

  if (result == null) return;
  final updated = result.analysis;

  // Update draft if this analysis is in-flight.
  final draft = ref.read(analysisDraftProvider);
  if (draft?.id == updated.id) {
    ref.read(analysisDraftProvider.notifier).state = updated;
  }

  await ref.read(historyControllerProvider.notifier).updateAnalysis(updated);
  ref.invalidate(mealAnalysisProvider(updated.id));

  if (result.reportChange) {
    await ref.read(correctionServiceProvider).sendCorrection(updated: updated);
  }

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analysis updated')),
    );
  }
}

class _EditAnalysisSheet extends HookWidget {
  const _EditAnalysisSheet({required this.analysis});

  final MealAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleController = useTextEditingController(text: analysis.mealTitle);
    final tagController = useTextEditingController(text: analysis.mealTag ?? '');
    final foods = useState<List<_FoodDraft>>(
      analysis.identifiedFoods
          .map(
            (f) => _FoodDraft(
              id: f.id,
              name: f.name,
              portion: f.portionSize ?? '',
              calories: f.calories.toString(),
              macros: f.macros,
            ),
          )
          .toList(),
    );
    final ingredients = useState<List<_IngredientDraft>>(
      analysis.ingredients
          .map(
            (i) => _IngredientDraft(
              name: i.name,
              portion: i.portionSize ?? '',
            ),
          )
          .toList(),
    );
    final reportChange = useState(false);

    void updateFood(int index, _FoodDraft updated) {
      final next = [...foods.value];
      next[index] = updated;
      foods.value = next;
    }

    void updateIngredient(int index, _IngredientDraft updated) {
      final next = [...ingredients.value];
      next[index] = updated;
      ingredients.value = next;
    }

    MealAnalysis buildUpdatedAnalysis() {
      final updatedFoods = <IdentifiedFood>[];
      double totalCarbs = 0;
      double totalProtein = 0;
      double totalFat = 0;
      int totalCalories = 0;

      for (var f in foods.value) {
        final calories = int.tryParse(f.calories) ?? 0;
        totalCalories += calories;
        totalCarbs += f.macros.carbs;
        totalProtein += f.macros.protein;
        totalFat += f.macros.fat;
        updatedFoods.add(
          IdentifiedFood(
            id: f.id,
            name: f.name.trim().isEmpty ? 'Food item' : f.name.trim(),
            calories: calories,
            macros: f.macros,
            portionSize: f.portion.trim().isEmpty ? null : f.portion.trim(),
            highlights: f.portion.trim().isEmpty ? null : ['Portion: ${f.portion}'],
          ),
        );
      }

      final updatedIngredients = ingredients.value
          .map(
            (i) => IngredientPortion(
              name: i.name.trim().isEmpty ? 'Ingredient' : i.name.trim(),
              portionSize: i.portion.trim().isEmpty ? null : i.portion.trim(),
            ),
          )
          .toList();

      return analysis.copyWith(
        mealTitle: titleController.text.trim().isEmpty ? analysis.mealTitle : titleController.text.trim(),
        mealTag: tagController.text.trim().isEmpty ? null : tagController.text.trim(),
        identifiedFoods: updatedFoods,
        ingredients: updatedIngredients,
        totalCalories: totalCalories,
        macros: Macros(carbs: totalCarbs, protein: totalProtein, fat: totalFat),
      );
    }

    return AnimatedPadding(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                Row(
                  children: [
                    const Icon(Icons.edit_note_outlined),
                    const SizedBox(width: 8),
                    Text('Edit analysis', style: theme.textTheme.titleLarge),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Meal name',
                    prefixIcon: Icon(Icons.restaurant),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: tagController,
                  decoration: const InputDecoration(
                    labelText: 'Meal tag (e.g., Dinner)',
                    prefixIcon: Icon(Icons.bookmark_outline),
                  ),
                ),
                const SizedBox(height: 18),
                Text('Identified foods', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                ...foods.value.indexed.map(
                  (entry) {
                    final idx = entry.$1;
                    final item = entry.$2;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: theme.colorScheme.surfaceContainerHighest),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                key: ValueKey('food-name-$idx'),
                                initialValue: item.name,
                                decoration: const InputDecoration(labelText: 'Name'),
                                onChanged: (value) => updateFood(idx, item.copyWith(name: value)),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      key: ValueKey('food-portion-$idx'),
                                      decoration: const InputDecoration(labelText: 'Portion (e.g., 100g)'),
                                      onChanged: (value) => updateFood(idx, item.copyWith(portion: value)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    width: 120,
                                    child: TextFormField(
                                      key: ValueKey('food-calories-$idx'),
                                      decoration: const InputDecoration(labelText: 'Calories'),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) => updateFood(idx, item.copyWith(calories: value)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text('Ingredients', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                if (ingredients.value.isEmpty)
                  Text('No ingredients returned — add names if needed.', style: theme.textTheme.bodySmall),
                ...ingredients.value.indexed.map(
                  (entry) {
                    final idx = entry.$1;
                    final item = entry.$2;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: ValueKey('ingredient-name-$idx'),
                              decoration: const InputDecoration(labelText: 'Ingredient name'),
                              onChanged: (value) => updateIngredient(idx, item.copyWith(name: value)),
                              initialValue: item.name,
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 140,
                            child: TextFormField(
                              key: ValueKey('ingredient-portion-$idx'),
                              decoration: const InputDecoration(labelText: 'Portion'),
                              onChanged: (value) => updateIngredient(idx, item.copyWith(portion: value)),
                              initialValue: item.portion,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  value: reportChange.value,
                  onChanged: (value) => reportChange.value = value,
                  title: const Text('Report this change'),
                  subtitle: const Text('Send a correction JSON for future model tuning'),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Save changes'),
                  onPressed: () {
                    final updated = buildUpdatedAnalysis();
                    Navigator.of(context).pop(_EditResult(updated, reportChange.value));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _EditResult {
  _EditResult(this.analysis, this.reportChange);
  final MealAnalysis analysis;
  final bool reportChange;
}

class _FoodDraft {
  const _FoodDraft({
    required this.id,
    required this.name,
    required this.portion,
    required this.calories,
    required this.macros,
  });

  final String id;
  final String name;
  final String portion;
  final String calories;
  final Macros macros;

  _FoodDraft copyWith({String? name, String? portion, String? calories}) {
    return _FoodDraft(
      id: id,
      name: name ?? this.name,
      portion: portion ?? this.portion,
      calories: calories ?? this.calories,
      macros: macros,
    );
  }
}

class _IngredientDraft {
  const _IngredientDraft({required this.name, required this.portion});

  final String name;
  final String portion;

  _IngredientDraft copyWith({String? name, String? portion}) {
    return _IngredientDraft(
      name: name ?? this.name,
      portion: portion ?? this.portion,
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

class _NutritionBreakdownCard extends StatelessWidget {
  const _NutritionBreakdownCard({required this.analysis, required this.profile});

  final MealAnalysis analysis;
  final UserProfile? profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dailyGoal = (profile?.dailyCalorieGoal ?? 2000).toDouble();
    final goalPct = (analysis.totalCalories / dailyGoal).clamp(0.0, 3.0);
    final bmi = profile?.bmi;
    final bmiLabel = bmi == null ? 'Add profile' : _bmiLabel(bmi.toDouble());

    final carbsCalories = analysis.macros.carbs * 4;
    final proteinCalories = analysis.macros.protein * 4;
    final fatCalories = analysis.macros.fat * 9;
    final totalMacroCalories = carbsCalories + proteinCalories + fatCalories;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your meal in context', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    label: 'Calorie load',
                    value: '${analysis.totalCalories} kcal',
                    helper: '≈ ${(goalPct * 100).clamp(0, 300).toStringAsFixed(0)}% of daily goal',
                    accentColor: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatTile(
                    label: 'BMI',
                    value: bmi == null ? '--' : bmi.toString(),
                    helper: bmiLabel,
                    accentColor: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: goalPct > 1 ? 1.0 : goalPct,
              minHeight: 10,
              backgroundColor: theme.colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daily goal: ${dailyGoal.toInt()} kcal', style: theme.textTheme.bodySmall),
                Text(
                  goalPct <= 1 ? '${(goalPct * 100).toStringAsFixed(0)}% used' : 'Goal exceeded',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _HighlightPill(
                  icon: Icons.bolt,
                  label: 'Protein share',
                  value: _percent(proteinCalories, totalMacroCalories),
                ),
                _HighlightPill(
                  icon: Icons.grass,
                  label: 'Carb share',
                  value: _percent(carbsCalories, totalMacroCalories),
                ),
                _HighlightPill(
                  icon: Icons.oil_barrel,
                  label: 'Fat share',
                  value: _percent(fatCalories, totalMacroCalories),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _percent(double value, double total) {
    if (total <= 0) return '--';
    return '${(value / total * 100).round()}%';
  }

  String _bmiLabel(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Healthy';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.helper,
    required this.accentColor,
  });

  final String label;
  final String value;
  final String helper;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(helper, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _HighlightPill extends StatelessWidget {
  const _HighlightPill({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
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
