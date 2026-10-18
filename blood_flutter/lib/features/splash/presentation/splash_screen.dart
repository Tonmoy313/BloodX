import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../auth/controllers/auth_controller.dart';

/// S1: Animated Splash Screen — routes restored sessions immediately.
///
/// Decision tree (spec/auth.md):
///   1. Version unsupported → S22 UpdateRequired (blocked)
///   2. Authenticated session  → Home
///   3. Returning user (phone known, no session) → S6 Login
///   4. First-time / no data → S1 Onboarding
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();

    final delay = AuthController.instance.state.isAuthenticated
        ? Duration.zero
        : const Duration(milliseconds: 2200);
    Timer(delay, _checkNavigation);
  }

  void _checkNavigation() {
    if (!mounted) return;
    final authState = AuthController.instance.state;

    // S22: Version gate
    if (!authState.appVersionSupported) {
      AppRoutes.replaceAll(context, AppRoutes.updateRequired);
      return;
    }

    // Authenticated → Home
    if (authState.isAuthenticated) {
      AppRoutes.replaceAll(context, AppRoutes.home);
      return;
    }

    // Returning user (phone stored but no session) → Login
    if (authState.rawPhone.isNotEmpty) {
      AppRoutes.replaceAll(context, AppRoutes.login);
      return;
    }

    // First-time user → Onboarding
    AppRoutes.replaceAll(context, AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [cs.surface, cs.surfaceContainerHighest]
                : [cs.primaryContainer.withValues(alpha: 0.25), cs.surface],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),

                // Animated BloodX Emblem
                const BloodDropLogo(size: 96, animated: true, showGlow: true),
                const SizedBox(height: 28),

                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Blood',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      'X',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: cs.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Tagline (bilingual)
                Text(
                  BloodStrings.tagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.1,
                  ),
                ),

                const Spacer(flex: 2),

                // Loading indicator
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      cs.primary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  BloodStrings.splashSubtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
