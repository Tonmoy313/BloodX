import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../../core/widgets/blood_text_field.dart';
import '../../../core/router/app_routes.dart';
import '../controllers/auth_controller.dart';
import 'donor_opt_in_dialog.dart';

/// S6: Phone + PIN Login Screen per spec/auth.md.
/// Features Bangladesh phone input (+880 prefix), 5-digit PIN, 15-min lockout after 5 fails,
/// Forgot PIN navigation, and Sign Up navigation.
class LoginPinScreen extends StatefulWidget {
  final String? initialPhone;
  final bool donorOptInPending;

  const LoginPinScreen({
    super.key,
    this.initialPhone,
    this.donorOptInPending = false,
  });

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  late final TextEditingController _phoneController;
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocus = FocusNode();
  String? _errorMessage;
  bool _obscurePin = true;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(
      text: widget.initialPhone ?? AuthController.instance.state.rawPhone,
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    _pinFocus.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final phoneText = _phoneController.text.trim();
    final pinText = _pinController.text.trim();

    if (phoneText.isEmpty) {
      setState(() {
        _errorMessage = BloodStrings.phoneErrorInvalid;
      });
      return;
    }

    if (pinText.length != 5) {
      setState(() {
        _errorMessage = BloodStrings.pinFieldLabel;
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    final success = await AuthController.instance.loginWithPin(
      phoneText,
      pinText,
    );
    if (!mounted) return;

    if (success) {
      final authState = AuthController.instance.state;
      final shouldPromptNewUser =
          authState.isNewUser && !authState.donorProfileComplete;
      var shouldGoToHealthDetails =
          widget.donorOptInPending ||
          (authState.donorOptIn && !authState.donorProfileComplete);

      if (shouldPromptNewUser) {
        shouldGoToHealthDetails = await DonorOptInDialog.show(
          context,
          initialValue: shouldGoToHealthDetails,
        );
        if (!mounted) return;
        AuthController.instance.setDonorOptIn(shouldGoToHealthDetails);
      }

      if (shouldGoToHealthDetails) {
        AppRoutes.replaceAll(context, AppRoutes.donorHealthDetails);
      } else {
        AppRoutes.replaceAll(context, AppRoutes.home);
      }
    } else {
      setState(() {
        _errorMessage =
            AuthController.instance.state.errorMessage ??
            BloodStrings.loginInvalidCredentials;
      });
    }
  }

  void _handleForgotPin() {
    AppRoutes.pushNamed(
      context,
      AppRoutes.phoneInput,
      arguments: const {'isForgotPin': true},
    );
  }

  void _handleGoToSignUp() {
    AppRoutes.replaceNamed(context, AppRoutes.phoneInput);
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
            automaticallyImplyLeading: false,
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
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Brand Emblem
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

                  // Header
                  Center(
                    child: Text(
                    BloodStrings.loginTitle,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                      letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ),
                  
                  const SizedBox(height: 8),
                  Text(
                    BloodStrings.loginSubtitle,
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

                  // Lockout Warning if applicable
                  if (authState.isLockedOut) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: BloodColors.error.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: BloodColors.error.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lock_clock_rounded,
                            color: BloodColors.error,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Locked for ${authState.remainingLockoutMinutes}m due to 5 wrong PIN attempts.',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: BloodColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Phone Input
                  BloodTextField(
                    label: BloodStrings.phoneFieldLabel,
                    hintText: BloodStrings.phoneFieldHint,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    prefix: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      margin: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF006A4E),
                            ),
                            child: Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF42A41),
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 5-Digit PIN Input
                  BloodTextField(
                    label: BloodStrings.pinFieldLabel,
                    hintText: BloodStrings.pinFieldHint,
                    controller: _pinController,
                    focusNode: _pinFocus,
                    obscureText: _obscurePin,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                    ],
                    errorText: _errorMessage,
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePin
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        size: 20,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePin = !_obscurePin;
                        });
                      },
                    ),
                  ),

                  // Forgot PIN link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _handleForgotPin,
                      child: Text(
                        BloodStrings.forgotPin,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: BloodColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  BloodButton(
                    text: BloodStrings.loginButton,
                    icon: Icons.login_rounded,
                    isLoading: authState.isLoading,
                    onPressed: authState.isLockedOut ? null : _handleLogin,
                  ),
                  const SizedBox(height: 32),

                  // Navigation to Sign Up (S3)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          BloodStrings.dontHaveAccount,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? BloodColors.textSecondaryDark
                                : BloodColors.textSecondaryLight,
                          ),
                        ),
                        GestureDetector(
                          onTap: _handleGoToSignUp,
                          child: Text(
                            BloodStrings.signUpLink,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: BloodColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
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
