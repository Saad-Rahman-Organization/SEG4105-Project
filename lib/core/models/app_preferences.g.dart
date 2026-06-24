// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppPreferencesImpl _$$AppPreferencesImplFromJson(Map<String, dynamic> json) =>
    _$AppPreferencesImpl(
      theme: $enumDecode(_$AppThemeEnumMap, json['theme']),
      units: $enumDecode(_$UnitsPreferenceEnumMap, json['units']),
    );

Map<String, dynamic> _$$AppPreferencesImplToJson(
        _$AppPreferencesImpl instance) =>
    <String, dynamic>{
      'theme': _$AppThemeEnumMap[instance.theme]!,
      'units': _$UnitsPreferenceEnumMap[instance.units]!,
    };

const _$AppThemeEnumMap = {
  AppTheme.light: 'light',
  AppTheme.dark: 'dark',
  AppTheme.system: 'system',
};

const _$UnitsPreferenceEnumMap = {
  UnitsPreference.metric: 'metric',
  UnitsPreference.imperial: 'imperial',
};
