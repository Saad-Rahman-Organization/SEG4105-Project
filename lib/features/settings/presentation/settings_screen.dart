import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/history_repository.dart';
import '../../../core/data/preferences_repository.dart';
import '../../../core/data/profile_repository.dart';
import '../../../core/models/app_preferences.dart';
import '../../../core/models/user_profile.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final preferences = ref.watch(preferencesProvider);

    final nameController = useTextEditingController(text: profile?.name ?? '');
    final heightController = useTextEditingController(text: profile?.heightValue.toString() ?? '170');
    final weightController = useTextEditingController(text: profile?.weightValue.toString() ?? '68');
    final calorieController =
        useTextEditingController(text: (profile?.dailyCalorieGoal ?? 2100).toString());

    final heightUnit = useState(profile?.heightUnit ?? HeightUnit.centimeters);
    final weightUnit = useState(profile?.weightUnit ?? WeightUnit.kilograms);
    final activity = useState(profile?.activityLevel ?? ActivityLevel.moderatelyActive);

    Future<void> saveProfile() async {
      final base = profile ??
          UserProfile(
            id: 'local',
            name: null,
            heightValue: 0,
            heightUnit: HeightUnit.centimeters,
            weightValue: 0,
            weightUnit: WeightUnit.kilograms,
            activityLevel: ActivityLevel.sedentary,
            onboardingCompleted: true,
          );
      final updated = base.copyWith(
        name: nameController.text.trim().isEmpty ? null : nameController.text.trim(),
        heightValue: double.tryParse(heightController.text) ?? base.heightValue,
        heightUnit: heightUnit.value,
        weightValue: double.tryParse(weightController.text) ?? base.weightValue,
        weightUnit: weightUnit.value,
        activityLevel: activity.value,
        dailyCalorieGoal: int.tryParse(calorieController.text),
      );
      await ref.read(profileProvider.notifier).updateProfile(updated);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved')));
      }
    }

    Future<void> exportHistory() async {
      final export = await ref.read(historyRepositoryProvider).exportHistory();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('History exported (${export.length} chars)')),
        );
      }
    }

    Future<void> clearAllData() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Clear all data?'),
          content: const Text(
            'Are you sure? This will permanently delete all your data, including your scan history.',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Delete')),
          ],
        ),
      );
      if (confirmed ?? false) {
        await ref.read(historyControllerProvider.notifier).clearHistory();
        await ref.read(profileProvider.notifier).clear();
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Data cleared. Restart app to onboard again.')));
        }
      }
    }

    final bmi = profile?.bmi ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Text('Profile', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: heightController,
                          decoration: InputDecoration(
                            labelText: 'Height',
                            suffixText: heightUnit.value.label,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<HeightUnit>(
                        value: heightUnit.value,
                        onChanged: (value) => heightUnit.value = value ?? heightUnit.value,
                        items: HeightUnit.values
                            .map((unit) => DropdownMenuItem(value: unit, child: Text(unit.label)))
                            .toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: weightController,
                          decoration: InputDecoration(
                            labelText: 'Weight',
                            suffixText: weightUnit.value.label,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<WeightUnit>(
                        value: weightUnit.value,
                        onChanged: (value) => weightUnit.value = value ?? weightUnit.value,
                        items: WeightUnit.values
                            .map((unit) => DropdownMenuItem(value: unit, child: Text(unit.label)))
                            .toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<ActivityLevel>(
                    value: activity.value,
                    decoration: const InputDecoration(labelText: 'Activity Level'),
                    items: ActivityLevel.values
                        .map((level) => DropdownMenuItem(value: level, child: Text(level.label)))
                        .toList(),
                    onChanged: (value) => activity.value = value ?? activity.value,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: calorieController,
                    decoration: const InputDecoration(labelText: 'Daily Calorie Goal'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('BMI: $bmi', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: saveProfile,
                      child: const Text('Save Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Theme'),
                  const SizedBox(height: 12),
                  SegmentedButton<AppTheme>(
                    segments: AppTheme.values
                        .map((theme) => ButtonSegment(value: theme, label: Text(theme.label)))
                        .toList(),
                    selected: <AppTheme>{preferences.theme},
                    onSelectionChanged: (value) {
                      ref.read(preferencesProvider.notifier).setTheme(value.first);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Units'),
                  const SizedBox(height: 12),
                  SegmentedButton<UnitsPreference>(
                    segments: UnitsPreference.values
                        .map((unit) => ButtonSegment(value: unit, label: Text(unit.label)))
                        .toList(),
                    selected: <UnitsPreference>{preferences.units},
                    onSelectionChanged: (value) {
                      ref.read(preferencesProvider.notifier).setUnits(value.first);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Data Management', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Export History'),
                    subtitle: const Text('Generate a JSON export of your scans.'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: exportHistory,
                  ),
                  ListTile(
                    title: const Text('Clear All Data'),
                    subtitle: const Text('Delete profile, preferences, and scan history.'),
                    trailing: const Icon(Icons.warning_amber),
                    onTap: clearAllData,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('About', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: const [
                ListTile(
                  title: Text('Version'),
                  subtitle: Text('1.0.0'),
                ),
                ListTile(
                  title: Text('Privacy'),
                  trailing: Icon(Icons.open_in_new),
                ),
                ListTile(
                  title: Text('Terms'),
                  trailing: Icon(Icons.open_in_new),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
