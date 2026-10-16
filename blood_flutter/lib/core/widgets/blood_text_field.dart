import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/blood_colors.dart';

/// Customized Text Input Field with clean focus borders and status indications.
class BloodTextField extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool autofocus;

  const BloodTextField({
    super.key,
    this.label,
    required this.hintText,
    this.controller,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLength,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? BloodColors.textPrimaryDark : BloodColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          obscureText: obscureText,
          readOnly: readOnly,
          onChanged: onChanged,
          onTap: onTap,
          focusNode: focusNode,
          autofocus: autofocus,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? BloodColors.textPrimaryDark : BloodColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            prefixIcon: prefix,
            suffixIcon: suffix,
            counterText: '', // hide default character counter
          ),
        ),
      ],
    );
  }
}
