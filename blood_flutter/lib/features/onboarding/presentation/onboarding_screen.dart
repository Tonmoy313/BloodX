import 'package:flutter/material.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../auth/presentation/phone_input_screen.dart';

/// S01 Welcome / Onboarding Screen per spec/auth.md.
/// Features bilingual toggle (bn/en), trust highlights, and clear disclaimer.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _navigateToPhoneAuth() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const PhoneInputScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final slides = [
      _OnboardingData(
        icon: Icons.emergency_rounded,
        title: BloodStrings.onb1Title,
        description: BloodStrings.onb1Desc,
        badgeText: 'Dhaka Emergency Waves',
        badgeColor: const Color(0xFFE53935),
      ),
      _OnboardingData(
        icon: Icons.favorite_rounded,
        title: BloodStrings.onb2Title,
        description: BloodStrings.onb2Desc,
        badgeText: 'Nonprofit · Zero Fees',
        badgeColor: const Color(0xFF10B981),
      ),
      _OnboardingData(
        icon: Icons.shield_rounded,
        title: BloodStrings.onb3Title,
        description: BloodStrings.onb3Desc,
        badgeText: 'Consent-Protected',
        badgeColor: const Color(0xFF3B82F6),
      ),
    ];

    return ListenableBuilder(
      listenable: AppLanguage.instance,
      builder: (context, _) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Top Action Bar with Logo and Language Toggle
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Mini Logo
                      Row(
                        children: [
                          const BloodDropLogo(
                            size: 28,
                            animated: false,
                            showGlow: false,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'BloodX',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? BloodColors.textPrimaryDark
                                  : BloodColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),

                      // Language Switcher Toggle (P-002: Bangla-first with English toggle)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            AppLanguage.instance.toggleLanguage();
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? BloodColors.surfaceMutedDark
                                  : BloodColors.surfaceMutedLight,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: BloodColors.primary.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.language_rounded,
                                  size: 16,
                                  color: BloodColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  BloodStrings.languageToggleText,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: BloodColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Slide Carousel
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      final item = slides[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Feature Visual Card
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    item.badgeColor.withValues(alpha: 0.25),
                                    item.badgeColor.withValues(alpha: 0.05),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.4, 0.75, 1.0],
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: item.badgeColor.withValues(alpha: 0.15),
                                    border: Border.all(
                                      color: item.badgeColor.withValues(alpha: 0.4),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    item.icon,
                                    size: 40,
                                    color: item.badgeColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: item.badgeColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                item.badgeText,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: item.badgeColor,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Title
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? BloodColors.textPrimaryDark
                                    : BloodColors.textPrimaryLight,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Description
                            Text(
                              item.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: isDark
                                    ? BloodColors.textSecondaryDark
                                    : BloodColors.textSecondaryLight,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? BloodColors.primary
                            : (isDark ? Colors.grey[700] : Colors.grey[300]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // CTA Action Button & Terms
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      BloodButton(
                        text: BloodStrings.getStarted,
                        icon: Icons.arrow_forward_rounded,
                        onPressed: _navigateToPhoneAuth,
                      ),
                      const SizedBox(height: 16),

                      // Terms and Privacy Note
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text.rich(
                          TextSpan(
                            text: BloodStrings.termsPrefix,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? BloodColors.textMutedDark
                                  : BloodColors.textMutedLight,
                            ),
                            children: [
                              TextSpan(
                                text: BloodStrings.termsOfService,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: BloodColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: BloodStrings.and),
                              TextSpan(
                                text: BloodStrings.privacyPolicy,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: BloodColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: BloodStrings.agreed),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final String title;
  final String description;
  final String badgeText;
  final Color badgeColor;

  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.badgeColor,
  });
}
