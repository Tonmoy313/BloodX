import 'package:blood_flutter/core/localization/blood_strings.dart';
import 'package:blood_flutter/features/auth/presentation/login_screen.dart';
import 'package:blood_flutter/features/home/presentation/home_placeholder_screen.dart';
import 'package:blood_flutter/core/network/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    initializeClient('http://localhost:8080/');
  });

  testWidgets('login does not show the donor opt-in prompt', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPinScreen()));
    await tester.pumpAndSettle();

    expect(find.text(BloodStrings.donorPromptTitle), findsNothing);
  });

  testWidgets('unauthenticated users do not see the donor opt-in prompt', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomePlaceholderScreen()));
    await tester.pumpAndSettle();

    expect(find.text(BloodStrings.donorPromptTitle), findsNothing);
  });
}
