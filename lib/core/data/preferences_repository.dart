import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../models/app_preferences.dart';

abstract class PreferencesRepository {
  Future<AppPreferences> load();
  Future<void> save(AppPreferences preferences);
}

class InMemoryPreferencesRepository implements PreferencesRepository {
  AppPreferences _cache = const AppPreferences(
    theme: AppTheme.system,
    units: UnitsPreference.metric,
  );

  @override
  Future<AppPreferences> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _cache;
  }

  @override
  Future<void> save(AppPreferences preferences) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _cache = preferences;
  }
}

final preferencesRepositoryProvider = Provider<PreferencesRepository>(
  (ref) => InMemoryPreferencesRepository(),
);

class PreferencesController extends StateNotifier<AppPreferences> {
  PreferencesController(this._repository) : super(const AppPreferences(theme: AppTheme.system, units: UnitsPreference.metric)) {
    _hydrate();
  }

  final PreferencesRepository _repository;

  Future<void> _hydrate() async {
    final stored = await _repository.load();
    state = stored;
  }

  Future<void> setTheme(AppTheme theme) async {
    state = state.copyWith(theme: theme);
    await _repository.save(state);
  }

  Future<void> setUnits(UnitsPreference units) async {
    state = state.copyWith(units: units);
    await _repository.save(state);
  }
}

final preferencesProvider =
    StateNotifierProvider<PreferencesController, AppPreferences>((ref) {
  final repository = ref.watch(preferencesRepositoryProvider);
  return PreferencesController(repository);
});

final themeModeProvider = Provider<ThemeMode>((ref) {
  final preferences = ref.watch(preferencesProvider);
  switch (preferences.theme) {
    case AppTheme.system:
      return ThemeMode.system;
    case AppTheme.light:
      return ThemeMode.light;
    case AppTheme.dark:
      return ThemeMode.dark;
  }
});
