import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_paths.dart';
import 'route_names.dart';
import '../observers/app_navigator_observer.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    observers: [AppNavigatorObserver()],
    routes: [
      GoRoute(path: RoutePaths.splash, name: RouteNames.splash,
        builder: (context, state) => const SplashPage()),
      GoRoute(path: RoutePaths.login, name: RouteNames.login,
        builder: (context, state) => const _PlaceholderPage(title: 'Login')),
      GoRoute(path: RoutePaths.register, name: RouteNames.register,
        builder: (context, state) => const _PlaceholderPage(title: 'Register')),
      ShellRoute(
        builder: (context, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(path: RoutePaths.home, name: RouteNames.home,
            pageBuilder: (context, state) => const NoTransitionPage(child: _PlaceholderPage(title: 'Home'))),
          GoRoute(path: RoutePaths.history, name: RouteNames.history,
            pageBuilder: (context, state) => const NoTransitionPage(child: _PlaceholderPage(title: 'History'))),
          GoRoute(path: RoutePaths.profile, name: RouteNames.profile,
            pageBuilder: (context, state) => const NoTransitionPage(child: _PlaceholderPage(title: 'Profile'))),
        ],
      ),
      GoRoute(path: RoutePaths.transfer, name: RouteNames.transfer,
        builder: (context, state) => const _PlaceholderPage(title: 'Transfer')),
    ],
    errorBuilder: (context, state) => _PlaceholderPage(title: '404 — Page Not Found'),
  );
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text(title, style: Theme.of(context).textTheme.headlineMedium)),
  );
}

class _MainShell extends StatefulWidget {
  final Widget child;
  const _MainShell({required this.child});
  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: widget.child,
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() => _currentIndex = index);
        final paths = [RoutePaths.home, RoutePaths.history, RoutePaths.profile];
        context.go(paths[index]);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
      ],
    ),
  );
}
