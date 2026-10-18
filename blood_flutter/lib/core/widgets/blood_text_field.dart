import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextCapitalization textCapitalization;

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
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
              color: cs.onSurface,
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
          textCapitalization: textCapitalization,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: cs.onSurface,
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
