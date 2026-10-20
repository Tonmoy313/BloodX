import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../core/network/serverpod_client.dart';

class SignInScreen extends StatefulWidget {
  final Widget child;
  const SignInScreen({super.key, required this.child});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    FlutterAuthSessionManagerExtension(client)
        .authSessionManager
        .authInfoListenable
        .addListener(
      _updateSignedInState,
    );
    _isSignedIn = FlutterAuthSessionManagerExtension(client)
        .authSessionManager
        .isAuthenticated;
  }

  @override
  void dispose() {
    FlutterAuthSessionManagerExtension(client)
        .authSessionManager
        .authInfoListenable
        .removeListener(
      _updateSignedInState,
    );
    super.dispose();
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = FlutterAuthSessionManagerExtension(client)
          .authSessionManager
          .isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _isSignedIn
        ? widget.child
        : Center(
            child: SignInWidget(
              client: client,
              onAuthenticated: () {
                context.showSnackBar(
                  message: 'User authenticated.',
                  backgroundColor: colors.primaryContainer,
                  foregroundColor: colors.onPrimaryContainer,
                );
              },
              onError: (error) {
                context.showSnackBar(
                  message: 'Authentication failed: $error',
                  backgroundColor: colors.errorContainer,
                  foregroundColor: colors.onErrorContainer,
                );
              },
            ),
          );
  }
}

extension on BuildContext {
  void showSnackBar({
    required String message,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foregroundColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
