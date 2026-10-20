import 'package:blood_flutter/core/localization/blood_strings.dart';
import 'package:blood_flutter/core/widgets/permission_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('retry returns true from the fallback rationale', (tester) async {
    bool? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await LocationPermissionFallbackDialog.show(context);
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text(BloodStrings.locationFallbackHeadline), findsOneWidget);
    expect(find.text(BloodStrings.locationFallbackBody), findsOneWidget);
    await tester.tap(find.text(BloodStrings.tryAgain));
    await tester.pumpAndSettle();

    expect(result, isTrue);
  });
}
