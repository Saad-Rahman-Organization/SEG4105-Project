import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/data/profile_repository.dart';
import '../core/models/user_profile.dart';
import '../features/camera/presentation/camera_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/processing/presentation/processing_screen.dart';
import '../features/results/presentation/results_screen.dart';
import '../features/settings/presentation/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  final router = GoRouter(
    initialLocation: '/home',
    refreshListenable: notifier,
    debugLogDiagnostics: false,
    redirect: notifier.handleRedirect,
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/scan',
        name: 'camera',
        builder: (context, state) => const CameraScreen(),
      ),
      GoRoute(
        path: '/processing',
        name: 'processing',
        builder: (context, state) => const ProcessingScreen(),
      ),
      GoRoute(
        path: '/results/:id',
        name: 'results',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ResultsScreen(mealId: id);
        },
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<UserProfile?>(
      profileProvider,
      (_, __) => notifyListeners(),
    );
  }

  final Ref _ref;

  String? handleRedirect(BuildContext context, GoRouterState state) {
    final profile = _ref.read(profileProvider);
    final hasCompletedOnboarding = profile?.onboardingCompleted ?? false;
    final isOnboardingRoute = state.matchedLocation == '/onboarding';

    if (!hasCompletedOnboarding && !isOnboardingRoute) {
      return '/onboarding';
    }

    if (hasCompletedOnboarding && isOnboardingRoute) {
      return '/home';
    }

    return null;
  }
}

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
        onDestinationSelected: (index) {
          shell.goBranch(index, initialLocation: index == shell.currentIndex);
        },
      ),
    );
  }
}
