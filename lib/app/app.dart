import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../core/data/preferences_repository.dart';
import '../routing/app_router.dart';
import 'theme.dart';

class NutriSnapApp extends HookConsumerWidget {
  const NutriSnapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: NutriTheme.systemChromeFor(themeMode),
      child: MaterialApp.router(
        title: 'NutriSnap',
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: NutriTheme.light,
        darkTheme: NutriTheme.dark,
        routerConfig: router,
        builder: (context, child) {
          return ResponsiveBreakpoints.builder(
            child: child ?? const SizedBox.shrink(),
            breakpoints: const [
              Breakpoint(start: 0, end: 450, name: MOBILE),
              Breakpoint(start: 451, end: 800, name: TABLET),
              Breakpoint(start: 801, end: 1920, name: DESKTOP),
              Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
        },
      ),
    );
  }
}
