import 'package:blood_flutter/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../../core/widgets/blood_text_field.dart';
import '../controllers/auth_controller.dart';
import 'terms_privacy_dialog.dart';

/// S02 Phone Input Screen per spec/auth.md.
/// Features Bangladesh E.164 phone validation, unchecked donor opt-in box (D-015),
/// and fast OTP trigger.
class PhoneInputScreen extends StatefulWidget {
  final bool isForgotPin;

  const PhoneInputScreen({super.key, this.isForgotPin = false});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  String? _errorMessage;
  final bool _donorOptIn = false; // D-015: Default UNCHECKED
  bool _termsAgreed = false; // Terms checkbox state

  @override
  void initState() {
    super.initState();
    // Pre-populate if controller already has a phone
    final currentPhone = AuthController.instance.state.rawPhone;
    if (currentPhone.isNotEmpty) {
      _phoneController.text = currentPhone;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  Future<bool?> _showTermsAgreementDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDark
            ? BloodColors.surfaceDark
            : BloodColors.surfaceLight,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BloodColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.security_rounded,
                color: BloodColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                BloodStrings.termsDialogTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? BloodColors.textPrimaryDark
                      : BloodColors.textPrimaryLight,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              BloodStrings.termsConfirmPrompt,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? BloodColors.textSecondaryDark
                    : BloodColors.textSecondaryLight,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                Navigator.of(ctx).pop();
                await _showTermsPrivacyDialog();
              },
              child: Text(
                '${BloodStrings.termsOfService} ${BloodStrings.and} ${BloodStrings.privacyPolicy}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: BloodColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              BloodStrings.cancel,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDark
                    ? BloodColors.textMutedDark
                    : BloodColors.textMutedLight,
              ),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: BloodColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              BloodStrings.agree,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showTermsPrivacyDialog() async {
    final agreed = await TermsPrivacyDialog.show(context);
    if (agreed != true || !mounted) return;

    setState(() {
      _termsAgreed = true;
    });
  }

  Future<void> _handleSendOtp() async {
    final text = _phoneController.text.trim();
    if (text.isEmpty) {
      setState(() {
        _errorMessage = BloodStrings.phoneErrorInvalid;
      });
      return;
    }

    final normalized = AuthController.normalizeBangladeshPhone(text);
    if (normalized == null) {
      setState(() {
        _errorMessage = BloodStrings.phoneErrorInvalid;
      });
      return;
    }

    // If terms checkbox is not checked, show dialogue prompt
    if (!widget.isForgotPin && !_termsAgreed) {
      final agreed = await _showTermsAgreementDialog();
      if (agreed == true) {
        if (!mounted) return;
        setState(() {
          _termsAgreed = true;
        });
      } else {
        return;
      }
    }

    setState(() {
      _errorMessage = null;
    });

    // Save donor opt-in preference to controller
    if (!widget.isForgotPin) {
      AuthController.instance.setDonorOptIn(_donorOptIn);
    }

    final success = await AuthController.instance.requestOtp(
      text,
      isForgotPin: widget.isForgotPin,
    );
    if (!mounted) return;

    if (success) {
      AppRoutes.pushNamed(context, AppRoutes.otpVerification);
    } else {
      setState(() {
        _errorMessage =
            AuthController.instance.state.errorMessage ??
            BloodStrings.phoneErrorInvalid;
      });
    }
  }

  void _navigateToLogin() {
    AppRoutes.replaceAll(context, AppRoutes.login);
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

        return Scaffold(
          appBar: AppBar(
            leading: widget.isForgotPin
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : null,
            actions: [
              // Language Switcher Toggle
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
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  // Header icon & branding
                  Center(
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BloodColors.primary.withValues(alpha: 0.1),
                      ),
                      child: const Center(
                        child: BloodDropLogo(
                          size: 38,
                          animated: false,
                          showGlow: false,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  //header + sub header
                  Center(
                    child: Text(
                      BloodStrings.phoneScreenTitle,
                      textAlign: TextAlign.center, // 👈 add
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? BloodColors.textPrimaryDark
                            : BloodColors.textPrimaryLight,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle — centered
                  Center(
                    // 👈 wrap
                    child: Text(
                      BloodStrings.phoneScreenSubtitle,
                      textAlign: TextAlign.center, // 👈 add
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? BloodColors.textSecondaryDark
                            : BloodColors.textSecondaryLight,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Phone Input Field with Bangladesh badge
                  BloodTextField(
                    label: BloodStrings.phoneFieldLabel,
                    hintText: BloodStrings.phoneFieldHint,
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    errorText: _errorMessage,
                    onChanged: (val) {
                      if (_errorMessage != null) {
                        setState(() {
                          _errorMessage = null;
                        });
                      }
                    },
                    prefix: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      margin: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // BD Flag circle
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF006A4E), // BD bottle green
                            ),
                            child: Center(
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF42A41), // BD red circle
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '+880',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? BloodColors.textPrimaryDark
                                  : BloodColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            height: 22,
                            width: 1,
                            color: isDark
                                ? Colors.grey[700]
                                : const Color(0xFFD1D5DB),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Send OTP Button
                  BloodButton(
                    text: BloodStrings.sendOtpButton,
                    icon: Icons.mark_email_read_rounded,
                    isLoading: authState.isLoading,
                    onPressed: _handleSendOtp,
                  ),
                  const SizedBox(height: 16),

                  // Already have an account? Log In
                  if (!widget.isForgotPin) ...[
                    //OR divider
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? BloodColors.textSecondaryDark
                                  : BloodColors.textSecondaryLight,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Secondary: Already have account? Login
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _navigateToLogin,
                        icon: const Icon(Icons.login_rounded, size: 18),
                        label: Text(
                          BloodStrings.loginButton,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Terms & Privacy Agreement Checkbox
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? BloodColors.surfaceMutedDark.withValues(
                                alpha: 0.5,
                              )
                            : BloodColors.surfaceMutedLight.withValues(
                                alpha: 0.5,
                              ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _termsAgreed
                              ? BloodColors.primary.withValues(alpha: 0.5)
                              : (isDark
                                    ? Colors.grey[800]!
                                    : const Color(0xFFE5E7EB)),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _termsAgreed,
                              activeColor: BloodColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _termsAgreed = val ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _termsAgreed = !_termsAgreed;
                                });
                              },
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    BloodStrings.termsPrefix,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? BloodColors.textSecondaryDark
                                          : BloodColors.textSecondaryLight,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _showTermsPrivacyDialog,
                                    child: Text(
                                      BloodStrings.termsOfService,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: BloodColors.primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    BloodStrings.and,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? BloodColors.textSecondaryDark
                                          : BloodColors.textSecondaryLight,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _showTermsPrivacyDialog,
                                    child: Text(
                                      BloodStrings.privacyPolicy,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: BloodColors.primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    BloodStrings.agreed,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? BloodColors.textSecondaryDark
                                          : BloodColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
