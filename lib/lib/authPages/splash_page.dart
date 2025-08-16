import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/widgets/preloder.dart';
import 'package:flutter_application_1/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:my_chat_app/pages/chat_page.dart';
// import 'package:my_chat_app/pages/register_page.dart';
//import 'package:my_chat_app/utils/constants.dart';

/// Page to redirect users to the appropriate page depending on the initial auth state
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _redirect();
    });
  }

  Future<void> _redirect() async {
    // await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/welcome', (route) => false);
    } else {
      final doc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();

      print(doc.data());
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        UserData.name = data['name'];
        UserData.email = data['email'];
        UserData.role = data['role'];
        UserData.status = data['status'];
        UserData.uid = user.uid;
        if (!context.mounted) return;
        if (UserData.status == 'accepted') {
          final prefs = await SharedPreferences.getInstance();
          bool seen = prefs.getBool('${user.uid}_seen') ?? false;
          prefs.setBool('${user.uid}_seen', true);
          if (!seen) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/appvd',
              (route) => false,
            );
          } else {
            if (UserData.role == "AHQ") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/ahqroutes',
                (route) => false,
              );
            } else if (UserData.role == "Unit Admin") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/adminroutes',
                (route) => false,
              );
            } else if (UserData.role == "User") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/userroutes',
                (route) => false,
              );
            }
          }
        } else if (UserData.status == 'pending') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/signappv',
            (route) => false,
          );
        } else if (UserData.status == 'rejected') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/rejected',
            (route) => false,
          );
        } else {
          context.showErrorSnackBar(message: 'Unknown error occured!');
        }
      } else {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/welcome', (route) => false);
        context.showErrorSnackBar(message: 'Unknown error occured!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
}
