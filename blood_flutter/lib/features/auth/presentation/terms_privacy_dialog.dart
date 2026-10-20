import 'package:flutter/material.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/widgets/blood_button.dart';

/// S7: Terms and Conditions & Privacy Policy scrollable modal dialog.
/// Displays BloodX non-profit status (D-001), voluntary donor principles (D-016),
/// and contact reveal rules (P-011).
class TermsPrivacyDialog extends StatelessWidget {
  const TermsPrivacyDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const TermsPrivacyDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: scheme.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.security_rounded,
                    color: scheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    BloodStrings.termsDialogTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Scrollable Terms Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        BloodStrings.termsIntro,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: scheme.primary,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPoint(
                      title: BloodStrings.termsPoint1Title,
                      desc: BloodStrings.termsPoint1Desc,
                      scheme: scheme,
                    ),
                    const SizedBox(height: 14),
                    _buildPoint(
                      title: BloodStrings.termsPoint2Title,
                      desc: BloodStrings.termsPoint2Desc,
                      scheme: scheme,
                    ),
                    const SizedBox(height: 14),
                    _buildPoint(
                      title: BloodStrings.termsPoint3Title,
                      desc: BloodStrings.termsPoint3Desc,
                      scheme: scheme,
                    ),
                    const SizedBox(height: 14),
                    _buildPoint(
                      title: BloodStrings.termsPoint4Title,
                      desc: BloodStrings.termsPoint4Desc,
                      scheme: scheme,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Understand & Agree Button
            BloodButton(
              text: BloodStrings.understandAndAgree,
              icon: Icons.check_circle_outline_rounded,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoint({
    required String title,
    required String desc,
    required ColorScheme scheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: scheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
