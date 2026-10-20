import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../../core/widgets/blood_text_field.dart';
import '../../../core/router/app_routes.dart';
import '../controllers/auth_controller.dart';

/// S6: Phone + PIN Login Screen per spec/auth.md.
/// Features Bangladesh phone input (+880 prefix), 5-digit PIN, 15-min lockout after 5 fails,
/// Forgot PIN navigation, and Sign Up navigation.
class LoginPinScreen extends StatefulWidget {
  final String? initialPhone;

  const LoginPinScreen({
    super.key,
    this.initialPhone,
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
      if (authState.donorOptIn && !authState.donorProfileComplete) {
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
    final cs = Theme.of(context).colorScheme;

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
                icon: Icon(
                  Icons.language_rounded,
                  size: 16,
                  color: cs.primary,
                ),
                label: Text(
                  BloodStrings.languageToggleText,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
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
                        color: cs.primary.withValues(alpha: 0.1),
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
                        color: cs.onSurface,
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
                      color: cs.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Lockout Warning if applicable
                  if (AuthController.instance.isLockedOut) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cs.error.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: cs.error.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_clock_rounded,
                            color: cs.error,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Locked for ${AuthController.instance.remainingLockoutMinutes}m due to 5 wrong PIN attempts.',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: cs.error,
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
                              color: cs.onSurface,
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
                        color: cs.onSurfaceVariant,
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
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: cs.primary,
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
                    onPressed: AuthController.instance.isLockedOut
                        ? null
                        : _handleLogin,
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
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        GestureDetector(
                          onTap: _handleGoToSignUp,
                          child: Text(
                            BloodStrings.signUpLink,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: cs.primary,
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
