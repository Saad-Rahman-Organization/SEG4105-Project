import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import '../core/data/history_repository.dart';
import '../core/data/local_storage.dart';
import '../core/data/preferences_repository.dart';
import '../core/data/profile_repository.dart';

final class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver();

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (!kDebugMode) return;
    final provider = context.provider;
    debugPrint('[provider] ${provider.name ?? provider.runtimeType} -> $newValue');
  }
}

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runZonedGuarded(
    () {
      runApp(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            profileRepositoryProvider.overrideWith((ref) => LocalProfileRepository(prefs)),
            preferencesRepositoryProvider.overrideWith((ref) => LocalPreferencesRepository(prefs)),
            historyRepositoryProvider.overrideWith((ref) => LocalHistoryRepository(prefs)),
          ],
          observers: const [AppProviderObserver()],
          child: const NutriSnapApp(),
        ),
      );
    },
    (error, stackTrace) {
      debugPrint('Uncaught NutriSnap error: $error\n$stackTrace');
    },
  );
}
