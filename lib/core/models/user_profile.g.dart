// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      heightValue: (json['heightValue'] as num).toDouble(),
      heightUnit: $enumDecode(_$HeightUnitEnumMap, json['heightUnit']),
      weightValue: (json['weightValue'] as num).toDouble(),
      weightUnit: $enumDecode(_$WeightUnitEnumMap, json['weightUnit']),
      activityLevel: $enumDecode(_$ActivityLevelEnumMap, json['activityLevel']),
      dailyCalorieGoal: (json['dailyCalorieGoal'] as num?)?.toInt(),
      onboardingCompleted: json['onboardingCompleted'] as bool,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'heightValue': instance.heightValue,
      'heightUnit': _$HeightUnitEnumMap[instance.heightUnit]!,
      'weightValue': instance.weightValue,
      'weightUnit': _$WeightUnitEnumMap[instance.weightUnit]!,
      'activityLevel': _$ActivityLevelEnumMap[instance.activityLevel]!,
      'dailyCalorieGoal': instance.dailyCalorieGoal,
      'onboardingCompleted': instance.onboardingCompleted,
    };

const _$HeightUnitEnumMap = {
  HeightUnit.centimeters: 'centimeters',
  HeightUnit.inches: 'inches',
};

const _$WeightUnitEnumMap = {
  WeightUnit.kilograms: 'kilograms',
  WeightUnit.pounds: 'pounds',
};

const _$ActivityLevelEnumMap = {
  ActivityLevel.sedentary: 'sedentary',
  ActivityLevel.lightlyActive: 'lightlyActive',
  ActivityLevel.moderatelyActive: 'moderatelyActive',
  ActivityLevel.veryActive: 'veryActive',
};
