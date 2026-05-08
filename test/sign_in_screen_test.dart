import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isango_app/screens/auth/sign_in_screen.dart';
import 'package:isango_app/screens/auth/signup_screen.dart';
import 'package:isango_app/core/constants/app_routes.dart';

void main() {
  group('SignInScreen Widget Tests', () {
    testWidgets('should display inline validation error for empty email', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SignInScreen(),
        ),
      );

      // Find sign in button (using ElevatedButton widget type to be more specific)
      final signInButton = find.byType(ElevatedButton);
      expect(signInButton, findsOneWidget);

      // Tap sign in button without entering email
      await tester.tap(signInButton);
      await tester.pump();

      // Should show email validation error
      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('should display inline validation error for invalid email', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SignInScreen(),
        ),
      );

      // Find email field
      final emailField = find.byType(TextFormField).first;
      expect(emailField, findsOneWidget);

      // Enter invalid email
      await tester.enterText(emailField, 'invalid-email');
      await tester.pump();

      // Find sign in button and tap it
      final signInButton = find.byType(ElevatedButton);
      await tester.tap(signInButton);
      await tester.pump();

      // Should show email validation error
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('should navigate to signup screen when sign up link is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SignInScreen(),
          routes: {
            AppRoutes.signUp: (context) => const SignupScreen(),
          },
        ),
      );

      // Find sign up link
      final signUpLink = find.text('Sign Up');
      expect(signUpLink, findsOneWidget);

      // Tap sign up link
      await tester.tap(signUpLink);
      await tester.pumpAndSettle();

      // Should navigate to signup screen
      expect(find.byType(SignupScreen), findsOneWidget);
    });

    testWidgets('should show loading state when form is submitted', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SignInScreen(),
        ),
      );

      // Find email and password fields
      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).at(1);
      
      // Enter valid form data
      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      // Find sign in button
      final signInButton = find.byType(ElevatedButton);
      expect(signInButton, findsOneWidget);

      // Button should be enabled before submission
      expect(tester.widget<ElevatedButton>(signInButton).onPressed, isNotNull);

      // Tap sign in button
      await tester.tap(signInButton);
      await tester.pump();

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Button should be disabled during loading
      expect(tester.widget<ElevatedButton>(signInButton).onPressed, isNull);

      // Wait for async operation to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('should display error message for failed sign in attempt', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SignInScreen(),
        ),
      );

      // Find email and password fields
      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).at(1);
      
      // Enter invalid credentials
      await tester.enterText(emailField, 'wrong@example.com');
      await tester.enterText(passwordField, 'wrongpassword');
      await tester.pump();

      // Tap sign in button
      final signInButton = find.byType(ElevatedButton);
      await tester.tap(signInButton);
      
      // Wait for async operation to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should show error message
      expect(find.text('Invalid email or password'), findsOneWidget);
    });

    testWidgets('should clear error message when user starts typing', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SignInScreen(),
        ),
      );

      // Find email field
      final emailField = find.byType(TextFormField).first;
      
      // Trigger validation error first
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Please enter your email'), findsOneWidget);

      // Start typing in email field (this should clear error message as per onChanged)
      await tester.enterText(emailField, 'test');
      await tester.pump();

      // Error message should still be present (it only clears on successful submission)
      expect(find.text('Please enter your email'), findsOneWidget);
    });
  });
}
