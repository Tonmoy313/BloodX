import 'package:flutter/material.dart';
import '../localization/blood_strings.dart';
import 'blood_button.dart';

/// D1: Location Access Permission Dialog per spec/auth.md.
class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const LocationPermissionDialog(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _BasePermissionDialog(
      icon: Icons.location_on_rounded,
      iconColor: cs.secondary,
      title: BloodStrings.permLocationTitle,
      description: BloodStrings.permLocationDesc,
      positiveLabel: BloodStrings.allowAccess,
      negativeLabel: BloodStrings.notNow,
      onConfirm: () => Navigator.of(context).pop(true),
      onCancel: () => Navigator.of(context).pop(false),
    );
  }
}

/// D2: Notification Access Permission Dialog per spec/auth.md.
class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const NotificationPermissionDialog(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _BasePermissionDialog(
      icon: Icons.notifications_active_rounded,
      iconColor: cs.primary,
      title: BloodStrings.permNotifTitle,
      description: BloodStrings.permNotifDesc,
      positiveLabel: BloodStrings.enableNotifications,
      negativeLabel: BloodStrings.notNow,
      onConfirm: () => Navigator.of(context).pop(true),
      onCancel: () => Navigator.of(context).pop(false),
    );
  }
}

/// D3: Storage Access Permission Dialog per spec/auth.md.
class StoragePermissionDialog extends StatelessWidget {
  const StoragePermissionDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const StoragePermissionDialog(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _BasePermissionDialog(
      icon: Icons.folder_shared_rounded,
      iconColor: cs.tertiary,
      title: BloodStrings.permStorageTitle,
      description: BloodStrings.permStorageDesc,
      positiveLabel: BloodStrings.allowAccess,
      negativeLabel: BloodStrings.cancel,
      onConfirm: () => Navigator.of(context).pop(true),
      onCancel: () => Navigator.of(context).pop(false),
    );
  }
}

class _BasePermissionDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String positiveLabel;
  final String negativeLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _BasePermissionDialog({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.positiveLabel,
    required this.negativeLabel,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: cs.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withValues(alpha: 0.12),
              ),
              child: Icon(icon, color: iconColor, size: 32),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: cs.onSurfaceVariant,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),
            BloodButton(
              text: positiveLabel,
              onPressed: onConfirm,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: onCancel,
              child: Text(
                negativeLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
