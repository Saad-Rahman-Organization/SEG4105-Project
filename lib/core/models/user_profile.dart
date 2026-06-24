import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum HeightUnit { centimeters, inches }

extension HeightUnitX on HeightUnit {
  String get label => this == HeightUnit.centimeters ? 'cm' : 'in';

  double toCentimeters(double value) =>
      this == HeightUnit.centimeters ? value : value * 2.54;

  double fromCentimeters(double centimeters) =>
      this == HeightUnit.centimeters ? centimeters : centimeters / 2.54;
}

enum WeightUnit { kilograms, pounds }

extension WeightUnitX on WeightUnit {
  String get label => this == WeightUnit.kilograms ? 'kg' : 'lb';

  double toKilograms(double value) =>
      this == WeightUnit.kilograms ? value : value / 2.20462;

  double fromKilograms(double kilograms) =>
      this == WeightUnit.kilograms ? kilograms : kilograms * 2.20462;
}

enum ActivityLevel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
}

extension ActivityLevelX on ActivityLevel {
  String get label {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Sedentary';
      case ActivityLevel.lightlyActive:
        return 'Lightly Active';
      case ActivityLevel.moderatelyActive:
        return 'Moderately Active';
      case ActivityLevel.veryActive:
        return 'Very Active';
    }
  }

  String get description {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Desk job or little movement';
      case ActivityLevel.lightlyActive:
        return '1-3 workouts per week';
      case ActivityLevel.moderatelyActive:
        return '3-5 workouts per week';
      case ActivityLevel.veryActive:
        return 'Daily exercise or physical job';
    }
  }
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    String? name,
    required double heightValue,
    required HeightUnit heightUnit,
    required double weightValue,
    required WeightUnit weightUnit,
    required ActivityLevel activityLevel,
    int? dailyCalorieGoal,
    required bool onboardingCompleted,
  }) = _UserProfile;

  const UserProfile._();

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  double get heightInMeters => heightUnit.toCentimeters(heightValue) / 100;

  double get weightInKilograms => weightUnit.toKilograms(weightValue);

  int get bmi => (weightInKilograms / (heightInMeters * heightInMeters)).round();
}
