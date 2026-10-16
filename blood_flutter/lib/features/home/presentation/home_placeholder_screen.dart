import 'package:flutter/material.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../onboarding/presentation/onboarding_screen.dart';

/// Authenticated Home Screen placeholder showing successful auth session,
/// donor mode status (D-015, D-016), and navigation hooks.
class HomePlaceholderScreen extends StatelessWidget {
  const HomePlaceholderScreen({super.key});

  void _handleSignOut(BuildContext context) {
    AuthController.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      (route) => false,
    );
  }

  void _showComingSoonSnackBar(BuildContext context) {
    // D-012: Features not built yet show a "coming soon" snackbar
    final isBn = AppLanguage.instance.isBangla;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBn
              ? 'এই ফিচারটি পরবর্তী ধাপে (Phase P1) যুক্ত হবে!'
              : 'This feature is coming soon in Phase P1!',
        ),
        backgroundColor: BloodColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: Listenable.merge([
        AppLanguage.instance,
        AuthController.instance,
      ]),
      builder: (context, _) {
        final authState = AuthController.instance.state;
        final isBn = AppLanguage.instance.isBangla;

        final displayName = authState.displayName?.isNotEmpty == true
            ? authState.displayName!
            : (isBn ? 'স্বেচ্ছাসেবী ভাই/বোন' : 'Volunteer User');

        final bloodGroup = authState.bloodGroup ?? 'O+';
        final area = authState.area ?? 'Dhaka';

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BloodDropLogo(size: 24, animated: false, showGlow: false),
                const SizedBox(width: 8),
                Text(
                  'BloodX',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? BloodColors.textPrimaryDark
                        : BloodColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton.icon(
                onPressed: () => AppLanguage.instance.toggleLanguage(),
                icon: const Icon(
                  Icons.language_rounded,
                  size: 16,
                  color: BloodColors.primary,
                ),
                label: Text(
                  BloodStrings.languageToggleText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: BloodColors.primary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: BloodColors.error,
                ),
                tooltip: BloodStrings.signOut,
                onPressed: () => _handleSignOut(context),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: BloodColors.primaryGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: BloodColors.primary.withValues(alpha: 0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                isBn ? 'সফল লগইন' : 'Authenticated',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                bloodGroup,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: BloodColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isBn
                              ? 'স্বাগতম, $displayName'
                              : 'Welcome, $displayName',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone_rounded,
                              size: 14,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              authState.maskedPhone.isNotEmpty
                                  ? authState.maskedPhone
                                  : '+880 17••• •••89',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.location_on_rounded,
                              size: 14,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              area,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Volunteer Donor Status Card (D-015, D-016)
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark
                          ? BloodColors.surfaceMutedDark
                          : BloodColors.surfaceLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: authState.donorOptIn
                            ? const Color(0xFF10B981)
                            : (isDark
                                  ? Colors.grey[850]!
                                  : const Color(0xFFE5E7EB)),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              authState.donorOptIn
                                  ? Icons.volunteer_activism_rounded
                                  : Icons.nightlight_round,
                              color: authState.donorOptIn
                                  ? const Color(0xFF10B981)
                                  : Colors.grey,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                authState.donorOptIn
                                    ? (isBn
                                          ? 'স্বেচ্ছাসেবী রক্তদাতা মোড: সচল'
                                          : 'Volunteer Donor Mode: Active')
                                    : (isBn
                                          ? 'রক্তদাতা মোড: নিষ্ক্রিয়'
                                          : 'Donor Mode: Off'),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? BloodColors.textPrimaryDark
                                      : BloodColors.textPrimaryLight,
                                ),
                              ),
                            ),
                            Switch(
                              value: authState.donorOptIn,
                              activeThumbColor: const Color(0xFF10B981),
                              onChanged: (val) {
                                AuthController.instance.setDonorOptIn(val);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          authState.donorOptIn
                              ? (isBn
                                    ? 'জরুরি রক্তের আবেদন আসলে আপনার এলাকায় নোটিফিকেশন পাঠানো হবে (ডি-০১৬: নো প্রেশার, নো গিল্ট)।'
                                    : 'You will receive emergency alerts when someone needs blood in your area (D-016).')
                              : (isBn
                                    ? 'আপনি যেকোনো সময় রক্তদাতা হিসেবে নিবন্ধন চালু করতে পারেন। রক্তদান সম্পূর্ণ স্বেচ্ছাসেবী।'
                                    : 'You can opt-in as a volunteer donor anytime. Blood donation is 100% voluntary.'),
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? BloodColors.textSecondaryDark
                                : BloodColors.textSecondaryLight,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quick Action Cards
                  Text(
                    isBn ? 'জরুরি সেবা' : 'Emergency Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Request Blood Card (D-001, D-006)
                  GestureDetector(
                    onTap: () => _showComingSoonSnackBar(context),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark
                            ? BloodColors.surfaceMutedDark
                            : BloodColors.surfaceLight,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: BloodColors.primary.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: BloodColors.primary.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.bloodtype_rounded,
                              color: BloodColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isBn
                                      ? 'জরুরি রক্তের আবেদন'
                                      : 'Post Blood Request',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? BloodColors.textPrimaryDark
                                        : BloodColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isBn
                                      ? 'রোগীর তথ্য, ব্যাগ সংখ্যা ও হাসপাতালের অবস্থান দিন'
                                      : 'Enter patient info, bags needed & hospital',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark
                                        ? BloodColors.textSecondaryDark
                                        : BloodColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: BloodColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // View Active Requests Card
                  GestureDetector(
                    onTap: () => _showComingSoonSnackBar(context),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark
                            ? BloodColors.surfaceMutedDark
                            : BloodColors.surfaceLight,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey[850]!
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF3B82F6,
                              ).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.format_list_bulleted_rounded,
                              color: Color(0xFF3B82F6),
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isBn
                                      ? 'চলতি জরুরি রক্তের তালিকা'
                                      : 'Active Emergency Requests',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? BloodColors.textPrimaryDark
                                        : BloodColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isBn
                                      ? 'আপনার গ্রুপের রক্তের জরুরি রোগীদের তালিকা দেখুন'
                                      : 'View urgent requests matching your group',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark
                                        ? BloodColors.textSecondaryDark
                                        : BloodColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Sign Out Button
                  BloodButton(
                    text: BloodStrings.signOut,
                    style: BloodButtonStyle.outline,
                    icon: Icons.logout_rounded,
                    onPressed: () => _handleSignOut(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
