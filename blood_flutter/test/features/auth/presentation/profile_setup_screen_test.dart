import 'package:blood_flutter/core/localization/blood_strings.dart';
import 'package:blood_flutter/features/auth/presentation/profile_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('requires name, sex, and date of birth but not a photo', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: ProfileSetupScreen()),
    );

    final continueButton = find.text(BloodStrings.continueToLogin);
    await tester.ensureVisible(continueButton);
    await tester.tap(continueButton);
    await tester.pump();
    expect(find.text(BloodStrings.profileNameRequired), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Amina Rahman');
    await tester.ensureVisible(continueButton);
    await tester.tap(continueButton);
    await tester.pump();
    expect(find.text(BloodStrings.profileSexRequired), findsOneWidget);

    await tester.tap(find.text(BloodStrings.femaleLabel));
    await tester.ensureVisible(continueButton);
    await tester.tap(continueButton);
    await tester.pump();
    expect(find.text(BloodStrings.profileDateOfBirthRequired), findsOneWidget);
    expect(find.text(BloodStrings.profilePhotoLabel), findsOneWidget);
  });
}
