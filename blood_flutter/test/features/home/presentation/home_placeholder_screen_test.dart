import 'package:blood_flutter/core/localization/blood_strings.dart';
import 'package:blood_flutter/features/auth/controllers/auth_controller.dart';
import 'package:blood_flutter/features/auth/presentation/login_screen.dart';
import 'package:blood_flutter/features/home/presentation/home_placeholder_screen.dart';
import 'package:blood_flutter/core/network/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final authController = AuthController.instance;

  setUpAll(() {
    initializeClient('http://localhost:8080/');
  });

  setUp(() async {
    await authController.signOut();
  });

  tearDown(() async {
    await authController.signOut();
  });

  testWidgets('login does not show the donor opt-in prompt', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPinScreen()));
    await tester.pumpAndSettle();

    expect(find.text(BloodStrings.donorPromptTitle), findsNothing);
  });

  testWidgets('new users see the donor opt-in prompt on Home', (tester) async {
    await tester.runAsync(() async {
      await authController.requestOtp('01712345678');
      await authController.verifyOtp('123456');
    });

    await tester.pumpWidget(const MaterialApp(home: HomePlaceholderScreen()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(BloodStrings.donorPromptTitle), findsOneWidget);
    await tester.tap(find.text(BloodStrings.notNow));
    await tester.pump(const Duration(milliseconds: 300));
  });
}
