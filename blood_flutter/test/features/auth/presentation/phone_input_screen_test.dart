import 'package:blood_flutter/core/localization/blood_strings.dart';
import 'package:blood_flutter/features/auth/presentation/phone_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('agreeing in terms dialog checks the agreement checkbox', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: PhoneInputScreen()),
    );

    final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.value, isFalse);

    expect(
      tester
          .state<ScrollableState>(
            find
                .descendant(
                  of: find.byType(SingleChildScrollView),
                  matching: find.byType(Scrollable),
                )
                .first,
          )
          .position
          .maxScrollExtent,
      0,
    );

    await tester.tap(find.text(BloodStrings.termsOfService).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text(BloodStrings.understandAndAgree));
    await tester.pumpAndSettle();

    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
  });
}
