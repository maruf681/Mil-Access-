import 'package:flutter/material.dart';
import 'sign1.dart';
import 'sign2_3_combined.dart';
import 'signappv.dart';
import 'appvd.dart';
import 'userlogin.dart';
import '2step.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(), // Start with the new welcome screen
      routes: {
        '/signup': (context) => SignupScreen(),
        '/sign2_3_combined': (context) => Sign23CombinedScreen(),
        '/signappv': (context) => ApprovalPage(),
        '/appvd': (context) => ApprovedScreen(),
        '/userlogin': (context) => UserLoginScreen(),
        '/2step': (context) => TwoStepVerificationScreen(),
        '/retainpass': (context) => RetainPasswordScreen(),
        '/passrecov': (context) => PasswordRecoveryScreen(),
      },
    );
  }
}


