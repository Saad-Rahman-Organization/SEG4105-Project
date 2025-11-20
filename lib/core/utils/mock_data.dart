import 'package:uuid/uuid.dart';

import '../models/meal_models.dart';
import '../models/user_profile.dart';

class MockData {
  static final Uuid _uuid = const Uuid();

  static List<MealAnalysis> get sampleAnalyses {
    return [
      MealAnalysis(
        id: _uuid.v4(),
        localId: _uuid.v4(),
        mealTitle: 'Vibrant Buddha Bowl',
        totalCalories: 520,
        confidence: Confidence.high,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        identifiedFoods: [
          IdentifiedFood(
            id: _uuid.v4(),
            name: 'Roasted Chickpeas',
            calories: 160,
            macros: const Macros(carbs: 18, protein: 8, fat: 6),
            thumbnailUrl: 'https://images.unsplash.com/photo-1528712306091-ed0763094c98',
            confidence: 0.94,
            highlights: const ['High in fiber', 'Plant protein'],
          ),
          IdentifiedFood(
            id: _uuid.v4(),
            name: 'Quinoa Base',
            calories: 210,
            macros: const Macros(carbs: 32, protein: 8, fat: 4),
            thumbnailUrl: 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543',
          ),
        ],
        macros: const Macros(carbs: 60, protein: 24, fat: 18),
        qualitativeFeedback:
            'Great balance of complex carbs and plant proteins. Add leafy greens for extra iron.',
        warnings: const ['Sodium slightly above goal', 'Low hydration signal'],
      ),
      MealAnalysis(
        id: _uuid.v4(),
        localId: _uuid.v4(),
        mealTitle: 'Avocado Toast Stack',
        totalCalories: 430,
        confidence: Confidence.medium,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
        identifiedFoods: [
          IdentifiedFood(
            id: _uuid.v4(),
            name: 'Sourdough Toast',
            calories: 230,
            macros: const Macros(carbs: 34, protein: 8, fat: 6),
          ),
          IdentifiedFood(
            id: _uuid.v4(),
            name: 'Avocado Mash',
            calories: 200,
            macros: const Macros(carbs: 12, protein: 6, fat: 15),
            highlights: const ['Heart healthy fats'],
          ),
        ],
        macros: const Macros(carbs: 46, protein: 14, fat: 21),
        qualitativeFeedback:
            'Consider pairing with leafy greens for more micronutrients.',
        warnings: const ['Watch saturated fat from spreads'],
      ),
    ];
  }

  static MealPreferences defaultPreferences({bool metric = true}) {
    return MealPreferences(
      dietaryTags: const ['balanced', 'whole-food'],
      includeAllergens: true,
      preferMetric: metric,
    );
  }

  static UserProfile demoProfile() => UserProfile(
        id: _uuid.v4(),
        name: 'Skyler',
        heightValue: 170,
        heightUnit: HeightUnit.centimeters,
        weightValue: 68,
        weightUnit: WeightUnit.kilograms,
        activityLevel: ActivityLevel.moderatelyActive,
        dailyCalorieGoal: 2100,
        onboardingCompleted: true,
      );
}
