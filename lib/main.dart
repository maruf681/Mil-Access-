import 'package:flutter/material.dart';
import 'sign1.dart';
import 'sign2_3_combined.dart';
import 'signappv.dart';
import 'appvd.dart';
import 'userlogin.dart';
import 'two_step.dart'; // Changed from 2step.dart
import 'retainpass.dart';
import 'passrecov.dart';
import 'welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WelcomeScreen(), // Start with the new welcome screen
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/sign2_3_combined': (context) => const Sign23CombinedScreen(),
        '/signappv': (context) => const ApprovalPage(),
        '/appvd': (context) => const ApprovedScreen(),
        '/userlogin': (context) => const UserLoginScreen(),
        '/two_step': (context) =>
            const TwoStepVerificationScreen(), // Changed from /2step
        '/retainpass': (context) => const RetainPasswordScreen(),
        '/passrecov': (context) => const PasswordRecoveryScreen(),
      },
    );
  }
}
