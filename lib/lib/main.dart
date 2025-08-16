import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authPages/appvd.dart';
import 'package:flutter_application_1/authPages/check_email.dart';
import 'package:flutter_application_1/authPages/login_page.dart';
import 'package:flutter_application_1/authPages/rejected.dart';
import 'package:flutter_application_1/authPages/retainpass.dart';
import 'package:flutter_application_1/authPages/signappv.dart';
import 'package:flutter_application_1/authPages/signup1.dart';
import 'package:flutter_application_1/authPages/splash_page.dart';
import 'package:flutter_application_1/authPages/welcome.dart';
import 'package:flutter_application_1/routeControllers/adminRoutes.dart';
import 'package:flutter_application_1/routeControllers/ahqRoutes.dart';
import 'package:flutter_application_1/routeControllers/userRoutes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupScreen(),
        '/signappv': (context) => const ApprovalPage(),
        '/appvd': (context) => const ApprovedScreen(),
        '/rejected': (context) => const RejectedScreen(),
        '/retainPass': (context) => const RetainPasswordScreen(),
        // '/passrecov1': (context) => const VerifyCodeScreen(),
        // '/passrecov2': (context) => const PasswordRecoveryScreen(),
        '/checkEmail': (context) => const CheckEmailScreen(),
        '/ahqroutes': (context) => const Ahqroutes(),
        '/adminroutes': (context) => const Adminroutes(),
        '/userroutes': (context) => const Userroutes(),
      },
      theme: ThemeData.light(),
    );
  }
}
