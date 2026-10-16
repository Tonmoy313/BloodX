import 'package:flutter/material.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';

/// Passwordless recovery & Help bottom sheet.
/// Aligns with BloodX core spec: BloodX uses passwordless Phone OTP.
/// Explains account access, SIM replacement, and hotline recovery.
class ForgotPasswordSheet extends StatelessWidget {
  const ForgotPasswordSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ForgotPasswordSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 28,
      ),
      decoration: BoxDecoration(
        color: isDark ? BloodColors.surfaceDark : BloodColors.surfaceLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: BloodColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  color: BloodColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  BloodStrings.loginHelp,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? BloodColors.textPrimaryDark
                        : BloodColors.textPrimaryLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Passwordless Explanation Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? BloodColors.surfaceMutedDark
                  : const Color(0xFFFBF2F2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: BloodColors.primary.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.key_off_rounded,
                  color: BloodColors.primary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        BloodStrings.passwordlessNoteTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: BloodColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        BloodStrings.loginHelpDesc,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: isDark
                              ? BloodColors.textSecondaryDark
                              : BloodColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Lost SIM / Changed Number Section
          Text(
            BloodStrings.simLostTitle,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? BloodColors.textPrimaryDark
                  : BloodColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            BloodStrings.simLostDesc,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: isDark
                  ? BloodColors.textSecondaryDark
                  : BloodColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 18),

          // Helpline Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? BloodColors.surfaceMutedDark
                  : BloodColors.surfaceMutedLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.headset_mic_rounded,
                  color: BloodColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    BloodStrings.supportHelpline,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Close Button
          BloodButton(
            text: BloodStrings.close,
            style: BloodButtonStyle.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
