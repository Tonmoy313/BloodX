import 'package:flutter/material.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/router/app_routes.dart';

// import '../../../core/widgets/blood_button.dart';
import '../controllers/auth_controller.dart';

/// S5: PIN Setup Screen per spec/auth.md.
/// Two-phase setup: Create 5-digit PIN -> Confirm 5-digit PIN (verify_pin).
/// On success: stores secure hash and routes to S6 (Login).
class PinSetupScreen extends StatefulWidget {
  final bool isForgotPin;

  const PinSetupScreen({
    super.key,
    this.isForgotPin = false,
  });

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  String _firstPin = '';
  String _currentInput = '';
  bool _isConfirming = false;
  String? _errorMessage;

  void _onDigitPressed(String digit) {
    if (_currentInput.length >= 5) return;

    setState(() {
      _currentInput += digit;
      _errorMessage = null;
    });

    if (_currentInput.length == 5) {
      _processFiveDigits();
    }
  }

  void _onBackspacePressed() {
    if (_currentInput.isNotEmpty) {
      setState(() {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
        _errorMessage = null;
      });
    }
  }

  Future<void> _processFiveDigits() async {
    if (!_isConfirming) {
      // Step 1 completed -> Move to Step 2: Confirm
      setState(() {
        _firstPin = _currentInput;
        _currentInput = '';
        _isConfirming = true;
      });
    } else {
      // Step 2 completed -> Verify matching
      if (_currentInput != _firstPin) {
        setState(() {
          _errorMessage = BloodStrings.pinMismatchError;
          _currentInput = '';
          _firstPin = '';
          _isConfirming = false; // Reset to step 1
        });
        return;
      }

      // PIN matched -> Save PIN
      final success = await AuthController.instance.setupPin(_currentInput);
      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(BloodStrings.pinSetSuccess),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );

        if (widget.isForgotPin) {
          AppRoutes.replaceAll(
            context,
            AppRoutes.login,
            arguments: {
              'initialPhone': AuthController.instance.state.rawPhone,
            },
          );
        } else {
          AppRoutes.replaceAll(context, AppRoutes.profileSetup);
        }
      } else {
        setState(() {
          _errorMessage =
              AuthController.instance.state.errorMessage ??
              BloodStrings.pinInsecureError;
          _currentInput = '';
          _firstPin = '';
          _isConfirming = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: _isConfirming
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                onPressed: () {
                  setState(() {
                    _isConfirming = false;
                    _currentInput = '';
                    _firstPin = '';
                    _errorMessage = null;
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Step Indicator Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isConfirming
                    ? 'Step 2/2 · verify_pin'
                    : 'Step 1/2 · pin_setup',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: cs.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title & Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _isConfirming
                    ? BloodStrings.pinConfirmTitle
                    : BloodStrings.pinSetupTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _isConfirming
                    ? BloodStrings.pinConfirmSubtitle
                    : BloodStrings.pinSetupSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 5 PIN Dots Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final isFilled = index < _currentInput.length;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled ? cs.primary : Colors.transparent,
                    border: Border.all(
                      color: isFilled ? cs.primary : cs.outline,
                      width: 2,
                    ),
                  ),
                );
              }),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.error,
                ),
              ),
            ],

            const Spacer(),

            // Numeric Keypad (1–9, 0, Backspace)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              child: Column(
                children: [
                  _buildKeypadRow(['1', '2', '3']),
                  const SizedBox(height: 16),
                  _buildKeypadRow(['4', '5', '6']),
                  const SizedBox(height: 16),
                  _buildKeypadRow(['7', '8', '9']),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 68, height: 68), // Spacer
                      _buildKeypadButton('0'),
                      SizedBox(
                        width: 68,
                        height: 68,
                        child: IconButton(
                          icon: const Icon(
                            Icons.backspace_outlined,
                            size: 26,
                          ),
                          onPressed: _onBackspacePressed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((d) => _buildKeypadButton(d)).toList(),
    );
  }

  Widget _buildKeypadButton(String digit) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => _onDigitPressed(digit),
      borderRadius: BorderRadius.circular(34),
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cs.surfaceContainerHighest,
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Center(
          child: Text(
            digit,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
