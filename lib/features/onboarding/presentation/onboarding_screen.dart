import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/data/profile_repository.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/services/haptics_service.dart';
import '../../../core/services/permission_service.dart';
import '../../../core/widgets/nutri_gradient_button.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final nameController = useTextEditingController();
    final heightController = useTextEditingController(text: '170');
    final weightController = useTextEditingController(text: '68');
    final calorieController = useTextEditingController(text: '2100');
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final heightUnit = useState(HeightUnit.centimeters);
    final weightUnit = useState(WeightUnit.kilograms);
    final activity = useState(ActivityLevel.moderatelyActive);

    void goTo(int page) {
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }

    Future<void> handlePermission() async {
      final permission = await ref.read(permissionServiceProvider).requestCamera();
      if (permission.isPermanentlyDenied) {
        await ref.read(permissionServiceProvider).openSettings();
      }
      if (permission.isGranted) {
        await ref.read(hapticsServiceProvider).selection();
        goTo(2);
      }
    }

    Future<void> handleComplete() async {
      if (!formKey.currentState!.validate()) return;
      await ref.read(profileProvider.notifier).completeOnboarding(
            name: nameController.text,
            heightValue: double.tryParse(heightController.text) ?? 0,
            heightUnit: heightUnit.value,
            weightValue: double.tryParse(weightController.text) ?? 0,
            weightUnit: weightUnit.value,
            activityLevel: activity.value,
            dailyCalorieGoal: int.tryParse(calorieController.text),
          );
      if (context.mounted) {
        context.goNamed('home');
      }
    }

    final theme = Theme.of(context);
    final gradient = LinearGradient(
      colors: theme.brightness == Brightness.dark
          ? [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.75),
            ]
          : [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.goNamed('home'),
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (_) {},
                  children: [
                    _OnboardingPage(
                      title: 'Welcome to NutriSnap',
                      subtitle: 'Snap a photo, get instant nutrition insights powered by friendly AI.',
                      assetName: 'assets/illustrations/onboarding_1.svg',
                      body: NutriGradientButton(
                        label: 'Get Started',
                        onPressed: () => goTo(1),
                        icon: Icons.arrow_forward,
                      ),
                    ),
                    _OnboardingPage(
                      title: 'Camera Access',
                      subtitle:
                          'NutriSnap needs camera access to scan your meals. You can import from gallery too.',
                      assetName: 'assets/illustrations/onboarding_2.svg',
                      body: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NutriGradientButton(
                            label: 'Grant Access',
                            onPressed: handlePermission,
                            icon: Icons.camera_alt,
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () => goTo(2),
                            child: const Text('Skip for now'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
                            Text(
                              'Let\'s personalize',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Provide a few basics so NutriSnap can tailor its feedback.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: nameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(labelText: 'Name (optional)'),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: heightController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Height',
                                      suffixText: heightUnit.value.label,
                                    ),
                                    validator: (value) => (double.tryParse(value ?? '') ?? 0) <= 0
                                        ? 'Enter height'
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<HeightUnit>(
                                    value: heightUnit.value,
                                    items: HeightUnit.values
                                        .map((unit) => DropdownMenuItem(
                                              value: unit,
                                              child: Text(unit.label),
                                            ))
                                        .toList(),
                                    onChanged: (value) => heightUnit.value = value ?? HeightUnit.centimeters,
                                    decoration: const InputDecoration(labelText: 'Units'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: weightController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Weight',
                                      suffixText: weightUnit.value.label,
                                    ),
                                    validator: (value) => (double.tryParse(value ?? '') ?? 0) <= 0
                                        ? 'Enter weight'
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<WeightUnit>(
                                    value: weightUnit.value,
                                    items: WeightUnit.values
                                        .map((unit) => DropdownMenuItem(
                                              value: unit,
                                              child: Text(unit.label),
                                            ))
                                        .toList(),
                                    onChanged: (value) => weightUnit.value = value ?? WeightUnit.kilograms,
                                    decoration: const InputDecoration(labelText: 'Units'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<ActivityLevel>(
                              value: activity.value,
                              decoration: const InputDecoration(labelText: 'Activity Level'),
                              items: ActivityLevel.values
                                  .map(
                                    (level) => DropdownMenuItem(
                                      value: level,
                                      child: Text(level.label),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => activity.value = value ?? ActivityLevel.moderatelyActive,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: calorieController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'Daily Calorie Goal'),
                            ),
                            const SizedBox(height: 24),
                            NutriGradientButton(
                              label: 'Complete Setup',
                              icon: Icons.check,
                              onPressed: handleComplete,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.assetName,
    required this.body,
  });

  final String title;
  final String subtitle;
  final String assetName;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themedAsset = isDark ? assetName.replaceFirst('.svg', '_dark.svg') : assetName;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.asset(
            themedAsset,
            height: 220,
            fit: BoxFit.contain,
            placeholderBuilder: (_) => Icon(Icons.bubble_chart, size: 96, color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const Spacer(),
          body,
          const Spacer(),
        ],
      ),
    );
  }
}
