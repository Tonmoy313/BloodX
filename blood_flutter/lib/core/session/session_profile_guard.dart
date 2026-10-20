import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

import '../localization/app_language.dart';
import '../network/serverpod_client.dart';
import '../router/app_routes.dart';
import '../../features/auth/controllers/auth_controller.dart';
import 'app_session_startup.dart';
import 'auth_session_revocation_outbox.dart';
import 'session_profile_validator.dart';

class SessionProfileGuard extends StatefulWidget {
  const SessionProfileGuard({
    required this.child,
    this.onAuthenticated,
    super.key,
  });

  final Widget child;
  final Future<void> Function()? onAuthenticated;

  @override
  State<SessionProfileGuard> createState() => _SessionProfileGuardState();
}

class _SessionProfileGuardState extends State<SessionProfileGuard> {
  late final SessionProfileValidator _validator = SessionProfileValidator(
    getProfile: _getProfile,
    discardSession: _discardExpiredSession,
  );
  bool _accountBlocked = false;

  @override
  void initState() {
    super.initState();
    if (FlutterAuthSessionManagerExtension(client)
        .authSessionManager
        .isAuthenticated) {
      unawaited(_validateProfile());
    }
  }

  Future<SessionProfileSnapshot> _getProfile() async {
    final profile = await client.profile.getMyProfile();
    final snapshot = SessionProfileSnapshot(
      userId: profile.id.toString(),
      isBlocked: profile.blocked,
      isDonor: profile.scopeNames.contains('donor'),
    );
    if (!snapshot.isBlocked) {
      try {
        await AppSessionStartup.cacheProfile(
          userId: snapshot.userId,
          donorOptIn: snapshot.isDonor,
        );
        AuthController.instance.updateCachedProfile(
          authUserId: snapshot.userId,
          donorOptIn: snapshot.isDonor,
        );
      } on PlatformException catch (error) {
        debugPrint('Could not cache the profile: ${error.code}');
      }
    }
    return snapshot;
  }

  Future<void> _validateProfile() async {
    final result = await _validator.validate();
    if (!mounted) return;
    if (result == SessionValidationResult.blocked) {
      setState(() => _accountBlocked = true);
    } else if (result == SessionValidationResult.unavailable) {
      debugPrint('Profile refresh failed; keeping the current session.');
    } else if (result == SessionValidationResult.authenticated) {
      await widget.onAuthenticated?.call();
    }
  }

  Future<void> _discardExpiredSession() async {
    final authSessionManager =
        FlutterAuthSessionManagerExtension(client).authSessionManager;
    await authSessionManager.storage.set(null);
    await authSessionManager.restore();
    await AuthController.instance.signOut();
    await AppSessionStartup.clearProfileCache();
    if (mounted) {
      AppRoutes.replaceAll(context, AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_accountBlocked) return widget.child;

    final isBangla = AppLanguage.instance.isBangla;
    final colors = Theme.of(context).colorScheme;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 48,
                    color: colors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isBangla
                        ? 'অ্যাকাউন্ট সাময়িকভাবে বন্ধ'
                        : 'Account suspended',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isBangla
                        ? 'সহায়তার জন্য BloodX টিমের সঙ্গে যোগাযোগ করুন।'
                        : 'Contact the BloodX team for help with your account.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () =>
                        AuthSessionRevocationOutbox.signOut(client),
                    child: Text(isBangla ? 'লগ আউট' : 'Log out'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
