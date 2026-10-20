import 'package:flutter/material.dart';

import '../../../core/localization/blood_strings.dart';

class DonorOptInDialog extends StatefulWidget {
  const DonorOptInDialog({super.key, this.initialValue = false});

  final bool initialValue;

  static Future<bool> show(
    BuildContext context, {
    bool initialValue = false,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => DonorOptInDialog(initialValue: initialValue),
        ) ??
        false;
  }

  @override
  State<DonorOptInDialog> createState() => _DonorOptInDialogState();
}

class _DonorOptInDialogState extends State<DonorOptInDialog> {
  late bool _optedIn = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(BloodStrings.donorPromptTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(BloodStrings.donorPromptBody),
          const SizedBox(height: 12),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(BloodStrings.donorOptInCheckbox),
            value: _optedIn,
            onChanged: (value) {
              setState(() {
                _optedIn = value ?? false;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(BloodStrings.notNow),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_optedIn),
          child: Text(BloodStrings.continueLabel),
        ),
      ],
    );
  }
}
