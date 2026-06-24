import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_preferences.dart';

abstract class PreferencesRepository {
  Future<AppPreferences> load();
  Future<void> save(AppPreferences preferences);
}

class LocalPreferencesRepository implements PreferencesRepository {
  LocalPreferencesRepository(this._prefs);

  static const _prefsKey = 'app_preferences_v1';
  final SharedPreferences _prefs;

  @override
  Future<AppPreferences> load() async {
    final stored = _prefs.getString(_prefsKey);
    if (stored == null) {
      return const AppPreferences(theme: AppTheme.system, units: UnitsPreference.metric);
    }
    try {
      return AppPreferences.fromJson(jsonDecode(stored) as Map<String, dynamic>);
    } catch (_) {
      await _prefs.remove(_prefsKey);
      return const AppPreferences(theme: AppTheme.system, units: UnitsPreference.metric);
    }
  }

  @override
  Future<void> save(AppPreferences preferences) async {
    await _prefs.setString(_prefsKey, jsonEncode(preferences.toJson()));
  }
}

final preferencesRepositoryProvider = Provider<PreferencesRepository>(
  (ref) => throw UnimplementedError('PreferencesRepository provider not initialized'),
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
