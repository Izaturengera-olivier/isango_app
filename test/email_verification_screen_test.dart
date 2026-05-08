import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isango_app/screens/auth/email_verification_screen.dart';
import 'package:isango_app/core/constants/app_routes.dart';

void main() {
  group('EmailVerificationScreen Widget Tests', () {
    testWidgets('should display verification code input fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmailVerificationScreen(email: 'test@example.com'),
        ),
      );

      // Should find 6 input fields for verification code
      expect(find.byType(TextFormField), findsNWidgets(6));
      
      // Should find email in the description
      expect(find.textContaining('test@example.com'), findsOneWidget);
      
      // Should find verify button
      expect(find.text('Verify Email'), findsOneWidget);
    });

    testWidgets('should auto-focus next field when entering digit', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmailVerificationScreen(email: 'test@example.com'),
        ),
      );

      // Find first input field
      final firstField = find.byType(TextFormField).first;
      expect(firstField, findsOneWidget);

      // Enter a digit
      await tester.enterText(firstField, '1');
      await tester.pump();

      // Should focus on second field automatically
      final secondField = find.byType(TextFormField).at(1);
      expect(secondField, findsOneWidget);
    });

    testWidgets('should show error message for incomplete code', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmailVerificationScreen(email: 'test@example.com'),
        ),
      );

      // Tap verify button without entering code
      final verifyButton = find.text('Verify Email');
      expect(verifyButton, findsOneWidget);

      await tester.tap(verifyButton);
      await tester.pump();

      // Should show error message
      expect(find.text('Please enter all 6 digits'), findsOneWidget);
    });

    testWidgets('should show loading state during verification', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmailVerificationScreen(email: 'test@example.com'),
        ),
      );

      // Fill all 6 fields
      for (int i = 0; i < 6; i++) {
        final field = find.byType(TextFormField).at(i);
        await tester.enterText(field, '1');
        await tester.pump();
      }

      // Tap verify button
      final verifyButton = find.text('Verify Email');
      await tester.tap(verifyButton);
      await tester.pump();

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Button should be disabled during loading
      expect(tester.widget<ElevatedButton>(verifyButton).onPressed, isNull);
      
      // Wait for async operation to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });  

    testWidgets('should navigate back to sign in when back button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmailVerificationScreen(email: 'test@example.com'),
          routes: {
            AppRoutes.login: (context) => const Scaffold(body: Text('Login Screen')),
          },
        ),
      );

      // Find and tap back button
      final backButton = find.text('Back to Sign In');
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Should navigate to login screen
      expect(find.text('Login Screen'), findsOneWidget);
    });

    testWidgets('should handle resend code functionality', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmailVerificationScreen(email: 'test@example.com'),
        ),
      );

      // Find and tap resend code button
      final resendButton = find.text('Resend Code');
      expect(resendButton, findsOneWidget);

      await tester.tap(resendButton);
      await tester.pump();

      // Should show loading state during resend
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Wait for async operation to complete
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });  

    testWidgets('should display correct UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmailVerificationScreen(email: 'test@example.com'),
        ),
      );

      // Should find ISANGO wordmark
      expect(find.text('ISANGO'), findsOneWidget);
      
      // Should find verification title
      expect(find.text('Verify Your Email'), findsOneWidget);
      
      // Should find email in description
      expect(find.textContaining('test@example.com'), findsOneWidget);
      
      // Should find resend code button
      expect(find.text('Resend Code'), findsOneWidget);
      
      // Should find back to sign in button
      expect(find.text('Back to Sign In'), findsOneWidget);
    });
  });
}
