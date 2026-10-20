import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/widgets/blood_button.dart';
import '../controllers/auth_controller.dart';
import '../../../core/router/app_routes.dart';

/// OTP Verification Screen per spec/auth.md.
/// 6-digit code entry, masked phone, resend countdown, passwordless security card.
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _pinControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Auto-focus first digit field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (final c in _pinControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _enteredCode => _pinControllers.map((c) => c.text.trim()).join();

  void _onDigitChanged(int index, String value) {
    if (_errorMessage != null) {
      setState(() {
        _errorMessage = null;
      });
    }

    if (value.isNotEmpty) {
      // If user pasted a full 6-digit code
      if (value.length > 1) {
        final digits = value.replaceAll(RegExp(r'\D'), '');
        for (int i = 0; i < 6 && i < digits.length; i++) {
          _pinControllers[i].text = digits[i];
        }
        if (digits.length >= 6) {
          _focusNodes[5].requestFocus();
          _handleVerify();
          return;
        }
      }

      // Move focus forward
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        if (_enteredCode.length == 6) {
          _handleVerify();
        }
      }
    }
  }

  Future<void> _handleVerify() async {
    final code = _enteredCode;
    if (code.length != 6) {
      setState(() {
        _errorMessage = BloodStrings.enterOtpHint;
      });
      return;
    }

    final success = await AuthController.instance.verifyOtp(code);
    if (!mounted) return;

    if (success) {
      final authState = AuthController.instance.state;
      if (authState.isForgotPin) {
        AppRoutes.replaceAll(
          context,
          AppRoutes.pinSetup,
          arguments: const {'isForgotPin': true},
        );
      } else if (authState.isNewUser) {
        AppRoutes.replaceAll(context, AppRoutes.pinSetup);
      } else {
        AppRoutes.replaceAll(context, AppRoutes.home);
      }
    } else {
      setState(() {
        _errorMessage =
            AuthController.instance.state.errorMessage ??
            BloodStrings.invalidOtpError;
      });
    }
  }

  Future<void> _handleResend() async {
    final success = await AuthController.instance.resendOtp();
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(BloodStrings.resendCodeNow),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Title & Subtitle
                  Text(
                    BloodStrings.otpScreenTitle,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        '${BloodStrings.otpScreenSubtitle} ',
                        style: TextStyle(
                          fontSize: 14,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        authState.maskedPhone.isNotEmpty
                            ? authState.maskedPhone
                            : '+880 17••• •••89',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 16,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 6 Digit PIN Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 48,
                        height: 56,
                        child: KeyboardListener(
                          focusNode: FocusNode(),
                          onKeyEvent: (event) {
                            if (event is KeyDownEvent &&
                                event.logicalKey ==
                                    LogicalKeyboardKey.backspace &&
                                _pinControllers[index].text.isEmpty &&
                                index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                          child: TextField(
                            controller: _pinControllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: cs.onSurface,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.zero,
                              fillColor: cs.surfaceContainerHighest,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: cs.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (val) => _onDigitChanged(index, val),
                          ),
                        ),
                      );
                    }),
                  ),

                  // Error Message
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _errorMessage!,
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Resend Timer & Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (authState.resendCountdown > 0) ...[
                        Icon(
                          Icons.timer_outlined,
                          size: 16,
                          color: cs.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${BloodStrings.resendCodeIn}00:${authState.resendCountdown.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ] else ...[
                        TextButton(
                          onPressed: _handleResend,
                          child: Text(
                            BloodStrings.resendCodeNow,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: cs.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Verify CTA Button
                  BloodButton(
                    text: BloodStrings.verifyButton,
                    icon: Icons.check_circle_outline_rounded,
                    isLoading: authState.isLoading,
                    onPressed: _handleVerify,
                  ),
                  const SizedBox(height: 24),

                  // Passwordless Security Info Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: cs.outlineVariant,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_rounded,
                          size: 20,
                          color: cs.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                BloodStrings.passwordlessNoteTitle,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: cs.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                BloodStrings.passwordlessNoteDesc,
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.4,
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            ],
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
