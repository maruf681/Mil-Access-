import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = false;
  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }

  Future<void> checkStatus(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final doc = await FirebaseFirestore.instance
          .collection('user')
          .doc(UserData.uid)
          .get();
      //print(doc.data());
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        UserData.name = data['name'];
        UserData.email = data['email'];
        UserData.role = data['role'];
        UserData.status = data['status'];
        UserData.uid = UserData.uid;
        if (!context.mounted) return;
        if (UserData.status == 'accepted') {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('${UserData.uid}_seen', true);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/appvd',
            (route) => false,
          );
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
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      context.showErrorSnackBar(message: e.toString());
    } catch (e) {
      if (!context.mounted) return;
      context.showErrorSnackBar(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E4D0), // Light green background
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/topography.png',
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(.8),
                colorBlendMode: BlendMode.dstATop,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              FirebaseAuth.instance.currentUser == null ||
                                  UserData.status == 'unauthenticated'
                              ? [
                                  const Text(
                                    'Welcome to MILACCESS',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color(
                                        0xFF1B5E20,
                                      ), // Replaced Colors.green[900] with a const Color
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Secure Access to Military Tasks, Docs & Directives',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(
                                        255,
                                        0,
                                        0,
                                        0,
                                      ), // Replaced Colors.green[900] with a const Color
                                    ),
                                  ),
                                  const SizedBox(height: 80),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(
                                        0xFF1B5E20,
                                      ), // Replaced Colors.green[900] with a const Color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 120,
                                        vertical: 15,
                                      ),
                                    ),
                                    child: const Text('Sign Up'),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1B5E20),
                                      foregroundColor: Colors
                                          .white, // Replaced Colors.green[900] with a const Color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 120,
                                        vertical: 15,
                                      ),
                                    ),
                                    child: const Text('Log In'),
                                  ),
                                ]
                              : [
                                  const Text(
                                    'Welcome to MILACCESS',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color(
                                        0xFF1B5E20,
                                      ), // Replaced Colors.green[900] with a const Color
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Secure Access to Military Tasks, Docs & Directives',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(
                                        255,
                                        0,
                                        0,
                                        0,
                                      ), // Replaced Colors.green[900] with a const Color
                                    ),
                                  ),
                                  const SizedBox(height: 80),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await checkStatus(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors
                                          .white, // Replaced Colors.green[900] with a const Color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 120,
                                        vertical: 15,
                                      ),
                                    ),
                                    child: const Text('Approval Check'),
                                  ),
                                ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
