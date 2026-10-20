import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_drop_logo.dart';
import '../../../core/network/serverpod_client.dart';
import '../../../core/session/auth_session_revocation_outbox.dart';
import '../../../core/session/session_profile_guard.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../donor/presentation/donor_opt_in_dialog.dart';

/// Authenticated Home Screen placeholder showing successful auth session,
/// donor mode status (D-015, D-016), and navigation hooks.
class HomePlaceholderScreen extends StatefulWidget {
  const HomePlaceholderScreen({super.key});

  @override
  State<HomePlaceholderScreen> createState() => _HomePlaceholderScreenState();
}

class _HomePlaceholderScreenState extends State<HomePlaceholderScreen> {
  bool _donorPromptHandled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isSimulatedNewUser =
          !FlutterAuthSessionManagerExtension(client)
              .authSessionManager
              .isAuthenticated &&
          AuthController.instance.state.isNewUser;
      if (mounted && isSimulatedNewUser) {
        _donorPromptHandled = true;
        unawaited(_displayDonorPrompt());
      }
    });
  }

  Future<void> _showServerDonorPrompt() async {
    if (_donorPromptHandled) return;
    _donorPromptHandled = true;
    bool isDue;
    try {
      isDue = await client.donorPrompt.claimDonorPrompt();
    } on ServerpodClientException catch (error) {
      debugPrint('Could not check donor prompt status: ${error.statusCode}');
      return;
    } on SocketException {
      debugPrint('Could not check donor prompt status: network unavailable.');
      return;
    } on TimeoutException {
      debugPrint('Could not check donor prompt status: request timed out.');
      return;
    }
    if (isDue && mounted) await _displayDonorPrompt();
  }

  Future<void> _displayDonorPrompt() async {
    final optedIn = await DonorOptInDialog.show(
      context,
      initialValue: AuthController.instance.state.donorOptIn,
    );
    if (!mounted) return;

    AuthController.instance.markDonorPromptHandled();
    AuthController.instance.setDonorOptIn(optedIn);
    if (optedIn) {
      AppRoutes.replaceAll(context, AppRoutes.donorHealthDetails);
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    await AuthSessionRevocationOutbox.signOut(client);
    if (!context.mounted) return;
    AppRoutes.replaceAll(context, AppRoutes.login);
  }

  void _showComingSoonSnackBar(BuildContext context) {
    // D-012: Features not built yet show a "coming soon" snackbar
    final isBn = AppLanguage.instance.isBangla;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBn
              ? 'এই ফিচারটি পরবর্তী ধাপে (Phase P1) যুক্ত হবে!'
              : 'This feature is coming soon in Phase P1!',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return _DoubleBackToExit(
      child: SessionProfileGuard(
        onAuthenticated: _showServerDonorPrompt,
        child: ListenableBuilder(
          listenable: Listenable.merge([
            AppLanguage.instance,
            AuthController.instance,
            AppThemeController.instance,
          ]),
          builder: (context, _) {
            final authState = AuthController.instance.state;
            final isBn = AppLanguage.instance.isBangla;
            final themeController = AppThemeController.instance;

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BloodDropLogo(
                      size: 24,
                      animated: false,
                      showGlow: false,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'BloodX',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                  ],
                ),
                actions: [
                  // Theme Variant Toggle (Classic BloodTheme vs Modern AppTheme)
                  IconButton(
                    tooltip: themeController.isModern
                        ? BloodStrings.themePresetModern
                        : BloodStrings.themePresetClassic,
                    icon: Icon(
                      themeController.isModern
                          ? Icons.palette_rounded
                          : Icons.palette_outlined,
                      size: 20,
                      color: cs.primary,
                    ),
                    onPressed: () => themeController.togglePreset(),
                  ),

                  // Dark / Light Mode Toggle
                  IconButton(
                    tooltip: isDark ? 'Light Mode' : 'Dark Mode',
                    icon: Icon(
                      isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      size: 20,
                      color: cs.onSurface,
                    ),
                    onPressed: () => themeController.toggleThemeMode(),
                  ),

                  // Language Switcher Toggle
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

                  // Sign Out
                  IconButton(
                    icon: Icon(
                      Icons.logout_rounded,
                      color: cs.error,
                    ),
                    tooltip: BloodStrings.signOut,
                    onPressed: () => _handleSignOut(context),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Header Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [cs.primary, cs.primaryContainer],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: cs.primary.withValues(alpha: 0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    isBn ? 'সফল লগইন' : 'Authenticated',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isBn ? 'স্বাগতম' : 'Welcome',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            if (authState.maskedPhone.isNotEmpty)
                              Text(
                                authState.maskedPhone,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Volunteer Donor Status Card (D-015, D-016)
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: authState.donorOptIn
                                ? cs.primary
                                : cs.outlineVariant,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  authState.donorOptIn
                                      ? Icons.volunteer_activism_rounded
                                      : Icons.nightlight_round,
                                  color: authState.donorOptIn
                                      ? cs.primary
                                      : cs.onSurfaceVariant,
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    authState.donorOptIn
                                        ? (isBn
                                              ? 'স্বেচ্ছাসেবী রক্তদাতা মোড: সচল'
                                              : 'Volunteer Donor Mode: Active')
                                        : (isBn
                                              ? 'রক্তদাতা মোড: নিষ্ক্রিয়'
                                              : 'Donor Mode: Off'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: cs.onSurface,
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: authState.donorOptIn,
                                  activeThumbColor: cs.primary,
                                  onChanged: (val) {
                                    AuthController.instance.setDonorOptIn(val);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              authState.donorOptIn
                                  ? (isBn
                                        ? 'জরুরি রক্তের আবেদন আসলে আপনার এলাকায় নোটিফিকেশন পাঠানো হবে (ডি-০১৬: নো প্রেশার, নো গিল্ট)।'
                                        : 'You will receive emergency alerts when someone needs blood in your area (D-016).')
                                  : (isBn
                                        ? 'আপনি যেকোনো সময় রক্তদাতা হিসেবে নিবন্ধন চালু করতে পারেন। রক্তদান সম্পূর্ণ স্বেচ্ছাসেবী।'
                                        : 'You can opt-in as a volunteer donor anytime. Blood donation is 100% voluntary.'),
                              style: TextStyle(
                                fontSize: 13,
                                color: cs.onSurfaceVariant,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Quick Action Cards
                      Text(
                        isBn ? 'জরুরি সেবা' : 'Emergency Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Request Blood Card (D-001, D-006)
                      GestureDetector(
                        onTap: () => _showComingSoonSnackBar(context),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: cs.primary.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: cs.primary.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.bloodtype_rounded,
                                  color: cs.primary,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isBn
                                          ? 'জরুরি রক্তের আবেদন'
                                          : 'Post Blood Request',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: cs.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isBn
                                          ? 'রোগীর তথ্য, ব্যাগ সংখ্যা ও হাসপাতালের অবস্থান দিন'
                                          : 'Enter patient info, bags needed & hospital',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: cs.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // View Active Requests Card
                      GestureDetector(
                        onTap: () => _showComingSoonSnackBar(context),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: cs.outlineVariant,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: cs.secondary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.format_list_bulleted_rounded,
                                  color: cs.secondary,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isBn
                                          ? 'চলতি জরুরি রক্তের তালিকা'
                                          : 'Active Emergency Requests',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: cs.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isBn
                                          ? 'আপনার গ্রুপের রক্তের জরুরি রোগীদের তালিকা দেখুন'
                                          : 'View urgent requests matching your group',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: cs.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Sign Out Button
                      BloodButton(
                        text: BloodStrings.signOut,
                        style: BloodButtonStyle.outline,
                        icon: Icons.logout_rounded,
                        onPressed: () => _handleSignOut(context),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DoubleBackToExit extends StatefulWidget {
  const _DoubleBackToExit({required this.child});

  final Widget child;

  @override
  State<_DoubleBackToExit> createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<_DoubleBackToExit> {
  DateTime? _lastBackPress;

  void _onBackInvoked(bool didPop) {
    if (didPop) return;

    final now = DateTime.now();
    final lastBackPress = _lastBackPress;
    if (lastBackPress != null &&
        now.difference(lastBackPress) <= const Duration(seconds: 2)) {
      SystemNavigator.pop();
      return;
    }

    _lastBackPress = now;
    final isBangla = AppLanguage.instance.isBangla;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            isBangla ? 'বের হতে আবার ব্যাক চাপুন' : 'Press back again to exit',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onBackInvoked(didPop),
      child: widget.child,
    );
  }
}
