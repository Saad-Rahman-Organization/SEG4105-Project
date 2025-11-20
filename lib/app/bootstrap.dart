import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import 'app.dart';

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

void bootstrap() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        ProviderScope(
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
