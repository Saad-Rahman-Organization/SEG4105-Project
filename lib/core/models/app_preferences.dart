import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_preferences.freezed.dart';
part 'app_preferences.g.dart';

enum AppTheme { light, dark, system }

extension AppThemeX on AppTheme {
  String get label {
    switch (this) {
      case AppTheme.light:
        return 'Light';
      case AppTheme.dark:
        return 'Dark';
      case AppTheme.system:
        return 'System';
    }
  }
}

enum UnitsPreference { metric, imperial }

extension UnitsPreferenceX on UnitsPreference {
  String get label => this == UnitsPreference.metric ? 'Metric' : 'Imperial';
}

@freezed
class AppPreferences with _$AppPreferences {
  const factory AppPreferences({
    required AppTheme theme,
    required UnitsPreference units,
  }) = _AppPreferences;

  const AppPreferences._();

  factory AppPreferences.fromJson(Map<String, dynamic> json) => _$AppPreferencesFromJson(json);
}
