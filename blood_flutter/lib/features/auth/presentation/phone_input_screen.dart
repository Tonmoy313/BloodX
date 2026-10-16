import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../../core/widgets/blood_text_field.dart';
import '../controllers/auth_controller.dart';
import 'forgot_password_sheet.dart';
import 'otp_verification_screen.dart';

/// S02 Phone Input Screen per spec/auth.md.
/// Features Bangladesh E.164 phone validation, unchecked donor opt-in box (D-015),
/// and fast OTP trigger.
class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  String? _errorMessage;
  bool _donorOptIn = false; // D-015: Default UNCHECKED

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

    setState(() {
      _errorMessage = null;
    });

    // Save donor opt-in preference to controller
    AuthController.instance.setDonorOptIn(_donorOptIn);

    final success = await AuthController.instance.requestOtp(text);
    if (!mounted) return;

    if (success) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OtpVerificationScreen(),
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
    } else {
      setState(() {
        _errorMessage = AuthController.instance.state.errorMessage ??
            BloodStrings.phoneErrorInvalid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: Listenable.merge([AppLanguage.instance, AuthController.instance]),
      builder: (context, _) {
        final authState = AuthController.instance.state;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

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
                  const SizedBox(height: 24),

                  // Title & Subtitle
                  Text(
                    BloodStrings.phoneScreenTitle,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    BloodStrings.phoneScreenSubtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? BloodColors.textSecondaryDark
                          : BloodColors.textSecondaryLight,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

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

                  // D-015: Donor Mode Opt-In Checkbox (UNCHECKED by default)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? BloodColors.surfaceMutedDark
                          : BloodColors.surfaceMutedLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _donorOptIn
                            ? BloodColors.primary.withValues(alpha: 0.5)
                            : (isDark ? Colors.grey[800]! : const Color(0xFFE5E7EB)),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _donorOptIn,
                            activeColor: BloodColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _donorOptIn = val ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _donorOptIn = !_donorOptIn;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  BloodStrings.donorOptInCheckbox,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? BloodColors.textPrimaryDark
                                        : BloodColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  BloodStrings.donorOptInNote,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: isDark
                                        ? BloodColors.textMutedDark
                                        : BloodColors.textMutedLight,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Send OTP Button
                  BloodButton(
                    text: BloodStrings.sendOtpButton,
                    icon: Icons.mark_email_read_rounded,
                    isLoading: authState.isLoading,
                    onPressed: _handleSendOtp,
                  ),
                  const SizedBox(height: 24),

                  // Help & Passwordless note / Forgot Password
                  Center(
                    child: TextButton(
                      onPressed: () => ForgotPasswordSheet.show(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.help_outline_rounded,
                            size: 16,
                            color: BloodColors.textSecondaryLight,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            BloodStrings.loginHelp,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? BloodColors.textSecondaryDark
                                  : BloodColors.textSecondaryLight,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
