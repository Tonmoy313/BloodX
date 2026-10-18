// import 'package:blood_flutter/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/phone_input_screen.dart';
import '../../features/auth/presentation/otp_verification_screen.dart';
import '../../features/auth/presentation/pin_setup_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/donor_health_details_screen.dart';
import '../../features/auth/presentation/location_picker_screen.dart';
import '../../features/splash/presentation/update_required_screen.dart';
import '../../features/home/presentation/home_placeholder_screen.dart';

class AppRoutes {
  AppRoutes._();

  // ── Route names ────────────────────────────────────────────────────────────
  // static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String phoneInput = '/phone-input';
  static const String otpVerification = '/otp-verification';
  static const String pinSetup = '/pin-setup';
  static const String donorHealthDetails = '/donor-health-details';
  static const String locationPicker = '/location-picker';
  static const String updateRequired = '/update-required';
  static const String home = '/home';

  // ── Route table ────────────────────────────────────────────────────────────
  static Map<String, WidgetBuilder> get routes => {
    // splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    login: (context) {
      final arguments = _arguments(context);
      return LoginPinScreen(
        initialPhone: arguments['initialPhone'] as String?,
        donorOptInPending: arguments['donorOptInPending'] == true,
      );
    },
    phoneInput: (context) => PhoneInputScreen(
      isForgotPin: _arguments(context)['isForgotPin'] == true,
    ),
    otpVerification: (_) => const OtpVerificationScreen(),
    pinSetup: (context) {
      final arguments = _arguments(context);
      return PinSetupScreen(
        isForgotPin: arguments['isForgotPin'] == true,
        donorOptIn: arguments['donorOptIn'] == true,
      );
    },
    donorHealthDetails: (_) => const DonorHealthDetailsScreen(),
    locationPicker: (context) => LocationPickerScreen(
      initialArea: _arguments(context)['initialArea'] as String?,
    ),
    updateRequired: (_) => const UpdateRequiredScreen(),
    home: (_) => const HomePlaceholderScreen(),
  };

  // ── Slide-from-right transition ─────────────────────────────────────────
  static Route<T> slideRight<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(1.0, 0.0);
        const curve = Curves.easeInOutCubic;
        final tween = Tween(
          begin: begin,
          end: Offset.zero,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  /// Fade transition — used for Splash → next screen.
  static Route<T> fade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, _, _) => page,
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  /// Push a named route with args.
  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) => Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);

  /// Replace the current route with a named route.
  static Future<T?> replaceNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) => Navigator.of(
    context,
  ).pushReplacementNamed<T, Object?>(routeName, arguments: arguments);

  /// Replace entire stack — used after login / splash decision.
  static Future<T?> replaceAll<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) =>
      Navigator.of(context).pushNamedAndRemoveUntil<T>(
        routeName,
        (route) => false,
        arguments: arguments,
      );

  static Map<String, Object?> _arguments(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return arguments is Map<String, Object?> ? arguments : const {};
  }
}
