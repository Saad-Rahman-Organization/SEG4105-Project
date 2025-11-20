// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IngredientPortionImpl _$$IngredientPortionImplFromJson(
        Map<String, dynamic> json) =>
    _$IngredientPortionImpl(
      name: json['name'] as String,
      portionSize: json['portionSize'] as String?,
    );

Map<String, dynamic> _$$IngredientPortionImplToJson(
        _$IngredientPortionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'portionSize': instance.portionSize,
    };

_$CaptureInfoImpl _$$CaptureInfoImplFromJson(Map<String, dynamic> json) =>
    _$CaptureInfoImpl(
      localPath: json['localPath'] as String,
      previewBase64: json['previewBase64'] as String,
      fromGallery: json['fromGallery'] as bool,
      captureFocalLength: (json['captureFocalLength'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$CaptureInfoImplToJson(_$CaptureInfoImpl instance) =>
    <String, dynamic>{
      'localPath': instance.localPath,
      'previewBase64': instance.previewBase64,
      'fromGallery': instance.fromGallery,
      'captureFocalLength': instance.captureFocalLength,
    };

_$MealPreferencesImpl _$$MealPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$MealPreferencesImpl(
      dietaryTags: (json['dietaryTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      includeAllergens: json['includeAllergens'] as bool,
      preferMetric: json['preferMetric'] as bool,
    );

Map<String, dynamic> _$$MealPreferencesImplToJson(
        _$MealPreferencesImpl instance) =>
    <String, dynamic>{
      'dietaryTags': instance.dietaryTags,
      'includeAllergens': instance.includeAllergens,
      'preferMetric': instance.preferMetric,
    };

_$MacrosImpl _$$MacrosImplFromJson(Map<String, dynamic> json) => _$MacrosImpl(
      carbs: (json['carbs'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
    );

Map<String, dynamic> _$$MacrosImplToJson(_$MacrosImpl instance) =>
    <String, dynamic>{
      'carbs': instance.carbs,
      'protein': instance.protein,
      'fat': instance.fat,
    };

_$IdentifiedFoodImpl _$$IdentifiedFoodImplFromJson(Map<String, dynamic> json) =>
    _$IdentifiedFoodImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      calories: (json['calories'] as num).toInt(),
      macros: Macros.fromJson(json['macros'] as Map<String, dynamic>),
      portionSize: json['portionSize'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      highlights: (json['highlights'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$IdentifiedFoodImplToJson(
        _$IdentifiedFoodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'calories': instance.calories,
      'macros': instance.macros,
      'portionSize': instance.portionSize,
      'thumbnailUrl': instance.thumbnailUrl,
      'confidence': instance.confidence,
      'highlights': instance.highlights,
    };

_$MealAnalysisImpl _$$MealAnalysisImplFromJson(Map<String, dynamic> json) =>
    _$MealAnalysisImpl(
      id: json['id'] as String,
      localId: json['localId'] as String,
      mealTitle: json['mealTitle'] as String,
      totalCalories: (json['totalCalories'] as num).toInt(),
      confidence: $enumDecode(_$ConfidenceEnumMap, json['confidence']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      identifiedFoods: (json['identifiedFoods'] as List<dynamic>)
          .map((e) => IdentifiedFood.fromJson(e as Map<String, dynamic>))
          .toList(),
      macros: Macros.fromJson(json['macros'] as Map<String, dynamic>),
      qualitativeFeedback: json['qualitativeFeedback'] as String,
      warnings:
          (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
      mealTag: json['mealTag'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map(
                  (e) => IngredientPortion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MealAnalysisImplToJson(_$MealAnalysisImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'localId': instance.localId,
      'mealTitle': instance.mealTitle,
      'totalCalories': instance.totalCalories,
      'confidence': _$ConfidenceEnumMap[instance.confidence]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'identifiedFoods': instance.identifiedFoods,
      'macros': instance.macros,
      'qualitativeFeedback': instance.qualitativeFeedback,
      'warnings': instance.warnings,
      'mealTag': instance.mealTag,
      'ingredients': instance.ingredients,
    };

const _$ConfidenceEnumMap = {
  Confidence.high: 'high',
  Confidence.medium: 'medium',
  Confidence.low: 'low',
};

_$MealPayloadImpl _$$MealPayloadImplFromJson(Map<String, dynamic> json) =>
    _$MealPayloadImpl(
      localId: json['localId'] as String,
      user: UserProfile.fromJson(json['user'] as Map<String, dynamic>),
      capture: CaptureInfo.fromJson(json['capture'] as Map<String, dynamic>),
      preferences:
          MealPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MealPayloadImplToJson(_$MealPayloadImpl instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'user': instance.user,
      'capture': instance.capture,
      'preferences': instance.preferences,
    };
