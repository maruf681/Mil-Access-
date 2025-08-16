import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/snackbar.dart';

class RetainPasswordScreen extends StatefulWidget {
  const RetainPasswordScreen({Key? key}) : super(key: key);

  @override
  _RetainPasswordScreenState createState() => _RetainPasswordScreenState();
}

class _RetainPasswordScreenState extends State<RetainPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  Future<void> sendResetCode(BuildContext context) async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      context.showErrorSnackBar(message: 'Email is required');
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (!context.mounted) return;
      context.showErrorSnackBar(
        message: 'Please check your email to reset password!',
      );
      Navigator.pushNamed(context, '/checkEmail');
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      context.showErrorSnackBar(message: e.toString());
    } finally {
      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E4D0),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/topography.png',
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.6),
                colorBlendMode: BlendMode.dstATop,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Retain Password',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                            const SizedBox(height: 40),
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'Enter your email',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => sendResetCode(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[900],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                              ),
                              child: const Text('Submit'),
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
