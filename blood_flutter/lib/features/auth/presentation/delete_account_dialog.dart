import 'package:flutter/material.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_text_field.dart';
import '../controllers/auth_controller.dart';

/// D4: Delete Account confirmation dialog per spec/auth.md.
/// Requires the user to explicitly type the word "DELETE" to activate deletion.
class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const DeleteAccountDialog(),
    );
  }

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final TextEditingController _inputController = TextEditingController();
  bool _canDelete = false;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      final isValid = _inputController.text.trim() == 'DELETE';
      if (isValid != _canDelete) {
        setState(() {
          _canDelete = isValid;
        });
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _handleDelete() async {
    if (!_canDelete || _isDeleting) return;

    setState(() {
      _isDeleting = true;
    });

    final success = await AuthController.instance.deleteAccount(
      _inputController.text,
    );
    if (!mounted) return;

    if (success) {
      Navigator.of(context).pop(); // Close dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(BloodStrings.deleteSuccessMsg),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigate back to S6 (Login) per flow: app -> s6
      AppRoutes.replaceAll(context, AppRoutes.login);
    } else {
      setState(() {
        _isDeleting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: cs.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning Icon & Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.error.withValues(alpha: 0.12),
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: cs.error,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    BloodStrings.deleteAccountTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              BloodStrings.deleteAccountDesc,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: cs.onSurfaceVariant,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),

            // Prompt to type "DELETE"
            Text(
              BloodStrings.deleteAccountTypePrompt,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: cs.error,
              ),
            ),
            const SizedBox(height: 8),

            BloodTextField(
              controller: _inputController,
              hintText: 'DELETE',
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 24),

            // Action Buttons
            BloodButton(
              text: BloodStrings.deleteAccountConfirmButton,
              backgroundColor: cs.error,
              icon: Icons.delete_forever_rounded,
              isLoading: _isDeleting,
              onPressed: _canDelete ? _handleDelete : null,
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  BloodStrings.cancel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
