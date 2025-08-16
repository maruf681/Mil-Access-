import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // static Route<void> route() {
  //   return MaterialPageRoute(builder: (context) => const LoginPage());
  // }

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> fetchUserData(String uid) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get();
    if (userDoc.exists) {
      final data = userDoc.data() as Map<String, dynamic>;
      UserData.name = data['name'];
      UserData.email = data['email'];
      UserData.role = data['role'];
      UserData.status = data['status'];
      UserData.uid = uid;
      return;
    }
    throw Exception('Unexpected error occured!');
  }

  Future<void> onTapLogin(BuildContext context) async {
    final email = _emailController.text.trim();
    final pswd = _passwordController.text.trim();
    if (email.isEmpty || pswd.isEmpty) {
      context.showErrorSnackBar(message: 'All fields must be filled!');
    }
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pswd);
      User? user = userCred.user;
      if (user != null) {
        await fetchUserData(user.uid);
        if (UserData.status == "accepted") {
          final prefs = await SharedPreferences.getInstance();
          bool seen = prefs.getBool('${UserData.uid}_seen') ?? false;
          prefs.setBool('${user.uid}_seen', true);
          if (!seen) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/appvd',
              (route) => false,
            );
          } else {
            if (!context.mounted) return;
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
            } else {
              setState(() {
                isLoading = false;
              });
              context.showErrorSnackBar(message: 'Unknown error occured!');
            }
          }
        } else {
          await FirebaseAuth.instance.signOut();
          UserData.reset();
          setState(() {
            isLoading = false;
          });
          if (!context.mounted) return;
          context.showErrorSnackBar(message: 'Unknown error occured!');
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!context.mounted) return;
      context.showErrorSnackBar(message: e.toString());
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!context.mounted) return;
      context.showErrorSnackBar(message: e.toString());
    }
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD9E6D9), // Light green background
                image: DecorationImage(
                  image: const AssetImage(
                    'assets/topography.png',
                  ), // Add a pattern asset if needed
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.6),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Removed Icon(Icons.menu, color: Colors.green[700]),
                              const SizedBox(height: 40),
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                ),
                              ),
                              const SizedBox(height: 40),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Enter email',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Enter Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () => onTapLogin(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[900],
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 150,
                                      vertical: 15,
                                    ),
                                  ),
                                  child: const Text('Login'),
                                ),
                              ),
                              const SizedBox(height: 40),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/retainPass'),
                                child: const Text(
                                  'Forget password?',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            isLoading
                ? Positioned(
                    top: 40,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
