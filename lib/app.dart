import 'package:flutter/material.dart';
import 'package:isango_app/screens/auth/sign_in_screen.dart';
import 'package:isango_app/screens/auth/signup_screen.dart';
import 'package:isango_app/screens/auth/email_verification_screen.dart';
import 'package:isango_app/screens/home/home_screen.dart';
import 'package:isango_app/screens/saved/saved_screen.dart';
import 'package:isango_app/screens/settings/settings_screen.dart';
import 'package:isango_app/screens/submit/submit_screen.dart';

import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';

class IsangoApp extends StatelessWidget {
  const IsangoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isango',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const SignInScreen(),
        AppRoutes.signUp: (context) => const SignupScreen(),
        AppRoutes.verifyEmail: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
          final email = args?['email'] ?? 'user@example.com';
          return EmailVerificationScreen(email: email);
        },
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.saved:(context) => const SavedScreen(),
        AppRoutes.submitEvent:(context) => const SubmitScreen(),
        AppRoutes.settings:(context) => const SettingsScreen(),
      },
    );
  }
}
