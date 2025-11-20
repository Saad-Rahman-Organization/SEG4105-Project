import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_profile.dart';

part 'meal_models.freezed.dart';
part 'meal_models.g.dart';

enum Confidence { high, medium, low }

@freezed
class CaptureInfo with _$CaptureInfo {
  const factory CaptureInfo({
    required String localPath,
    required String previewBase64,
    required bool fromGallery,
    double? captureFocalLength,
  }) = _CaptureInfo;

  factory CaptureInfo.fromJson(Map<String, dynamic> json) => _$CaptureInfoFromJson(json);
}

@freezed
class MealPreferences with _$MealPreferences {
  const factory MealPreferences({
    required List<String> dietaryTags,
    required bool includeAllergens,
    required bool preferMetric,
  }) = _MealPreferences;

  factory MealPreferences.fromJson(Map<String, dynamic> json) => _$MealPreferencesFromJson(json);
}

@freezed
class Macros with _$Macros {
  const factory Macros({
    required int carbs,
    required int protein,
    required int fat,
  }) = _Macros;

  const Macros._();

  factory Macros.fromJson(Map<String, dynamic> json) => _$MacrosFromJson(json);

  int get total => carbs + protein + fat;
}

@freezed
class IdentifiedFood with _$IdentifiedFood {
  const factory IdentifiedFood({
    required String id,
    required String name,
    required int calories,
    required Macros macros,
    String? thumbnailUrl,
    double? confidence,
    List<String>? highlights,
  }) = _IdentifiedFood;

  factory IdentifiedFood.fromJson(Map<String, dynamic> json) => _$IdentifiedFoodFromJson(json);
}

@freezed
class MealAnalysis with _$MealAnalysis {
  const factory MealAnalysis({
    required String id,
    required String localId,
    required String mealTitle,
    required int totalCalories,
    required Confidence confidence,
    required DateTime timestamp,
    required List<IdentifiedFood> identifiedFoods,
    required Macros macros,
    required String qualitativeFeedback,
    required List<String> warnings,
  }) = _MealAnalysis;

  factory MealAnalysis.fromJson(Map<String, dynamic> json) => _$MealAnalysisFromJson(json);
}

@freezed
class MealPayload with _$MealPayload {
  const factory MealPayload({
    required String localId,
    required UserProfile user,
    required CaptureInfo capture,
    required MealPreferences preferences,
  }) = _MealPayload;

  factory MealPayload.fromJson(Map<String, dynamic> json) => _$MealPayloadFromJson(json);
}
