import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../home/presentation/home_placeholder_screen.dart';

/// Animated Splash Screen with BloodX branding and auto-navigation.
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

    // Auto navigate after 2.2 seconds
    Timer(const Duration(milliseconds: 2200), _checkNavigation);
  }

  void _checkNavigation() {
    if (!mounted) return;
    final authState = AuthController.instance.state;
    final nextScreen = authState.isAuthenticated
        ? const HomePlaceholderScreen()
        : const OnboardingScreen();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? BloodColors.backgroundDark : BloodColors.backgroundLight,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color(0xFF1E0E12),
                    BloodColors.backgroundDark,
                    BloodColors.backgroundDark,
                  ]
                : [
                    const Color(0xFFFFF1F1),
                    BloodColors.backgroundLight,
                    BloodColors.backgroundLight,
                  ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),

                // Animated Emblem
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
                        color: isDark
                            ? BloodColors.textPrimaryDark
                            : BloodColors.textPrimaryLight,
                      ),
                    ),
                    Text(
                      'X',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: BloodColors.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Bengali Tagline (P-002)
                Text(
                  BloodStrings.tagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? BloodColors.textSecondaryDark
                        : BloodColors.textSecondaryLight,
                    letterSpacing: 0.1,
                  ),
                ),

                const Spacer(flex: 2),

                // Loading Pulse Indicator
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      BloodColors.primary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  BloodStrings.splashSubtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? BloodColors.textMutedDark
                        : BloodColors.textMutedLight,
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
