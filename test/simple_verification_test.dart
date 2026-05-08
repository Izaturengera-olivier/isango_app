import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isango_app/screens/auth/email_verification_screen.dart';

void main() {
  testWidgets('simple verification test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EmailVerificationScreen(email: 'test@example.com'),
      ),
    );

    // Just check if button exists
    final verifyButton = find.text('Verify Email');
    expect(verifyButton, findsOneWidget, reason: 'Verify Email button should be found');
  });
}
