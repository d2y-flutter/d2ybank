import 'package:d2ybank/app/di/injection_container.dart';
import 'package:d2ybank/core/services/face_detection_service.dart';
import 'package:d2ybank/features/auth/presentation/pages/biometric_setup_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/kyc_form_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/login_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/register_account_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/registration_success_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/setup_password_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/setup_pin_page.dart';
import 'package:d2ybank/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:d2ybank/features/dashboard/presentation/widgets/dashboard_bottom_nav_bar.dart';
import 'package:d2ybank/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/identity_verification_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/ktp_camera_page.dart';
import 'package:d2ybank/features/auth/presentation/pages/face_liveness_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import 'route_paths.dart';
import '../observers/app_navigator_observer.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    observers: [AppNavigatorObserver()],
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => RegisterAccountPage(
          onSendOtp: (phoneNumber) {
            debugPrint('Send OTP to: $phoneNumber');

            // lanjut panggil cubit/bloc/usecase register kamu di sini
          },
        ),
      ),
      GoRoute(
        path: RoutePaths.otp,
        name: RouteNames.otp,
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return OtpVerificationPage(phoneNumber: phoneNumber);
        },
      ),
       // Identity Verification Flow
      GoRoute(
        path: RoutePaths.identityVerification,
        name: RouteNames.identityVerification,
        builder: (context, state) => const IdentityVerificationPage(),
        routes: [
          GoRoute(
            path: RoutePaths.identityKtp,
            name: RouteNames.identityKtp,
            builder: (context, state) => const KtpCameraPage(),
          ),
          GoRoute(
            path: RoutePaths.identityFace,
            name: RouteNames.identityFace,
            builder: (context, state) {
              return FaceLivenessPage(
                faceDetectionService: sl<FaceDetectionService>(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.kycForm,
        name: RouteNames.kycForm,
        builder: (context, state) => const KycFormPage(),
      ),
      GoRoute(
        path: RoutePaths.setupPassword,
        name: RouteNames.setupPassword,
        builder: (context, state) => const SetupPasswordPage(),
      ),
      GoRoute(
        path: RoutePaths.biometricSetup,
        name: RouteNames.biometricSetup,
        builder: (context, state) => const BiometricSetupPage(),
      ),
      GoRoute(
        path: RoutePaths.setupPin,
        name: RouteNames.setupPin,
        builder: (context, state) => const SetupPinPage(),
      ),
      GoRoute(
        path: RoutePaths.registrationSuccess,
        name: RouteNames.registrationSuccess,
        builder: (context, state) => const RegistrationSuccessPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return _MainShell(
            location: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RoutePaths.home,
            name: RouteNames.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardPage(),
            ),
          ),
          GoRoute(
            path: RoutePaths.wealth,
            name: RouteNames.wealth,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: _PlaceholderPage(title: 'Wealth'),
            ),
          ),
          GoRoute(
            path: RoutePaths.inbox,
            name: RouteNames.inbox,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: _PlaceholderPage(title: 'Inbox'),
            ),
          ),
          GoRoute(
            path: RoutePaths.menu,
            name: RouteNames.menu,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: _PlaceholderPage(title: 'Menu'),
            ),
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.qris,
        name: RouteNames.qris,
        builder: (context, state) => const _PlaceholderPage(title: 'QRIS'),
      ),
      GoRoute(
        path: RoutePaths.transfer,
        name: RouteNames.transfer,
        builder: (context, state) => const _PlaceholderPage(title: 'Transfer'),
      ),
    ],
    errorBuilder: (context, state) => const _PlaceholderPage(
      title: '404 — Page Not Found',
    ),
  );
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class _MainShell extends StatelessWidget {
  const _MainShell({
    required this.child,
    required this.location,
  });

  final Widget child;
  final String location;

  static const List<String> _tabPaths = [
    RoutePaths.home,
    RoutePaths.wealth,
    RoutePaths.inbox,
    RoutePaths.menu,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: DashboardBottomNavBar(
        currentIndex: _currentIndexFromLocation(location),
        onTap: (index) => _onTabSelected(context, index),
        onQrisTap: () => context.go(RoutePaths.qris),
      ),
    );
  }

  int _currentIndexFromLocation(String location) {
    final normalizedLocation = location.endsWith('/') && location.length > 1
        ? location.substring(0, location.length - 1)
        : location;

    final index = _tabPaths.indexWhere(
      (path) => normalizedLocation == path || normalizedLocation.startsWith('$path/'),
    );

    return index == -1 ? 0 : index;
  }

  void _onTabSelected(BuildContext context, int index) {
    if (index < 0 || index >= _tabPaths.length) return;

    final targetPath = _tabPaths[index];
    final currentPath = GoRouterState.of(context).uri.path;

    if (currentPath == targetPath) return;
    context.go(targetPath);
  }
}
