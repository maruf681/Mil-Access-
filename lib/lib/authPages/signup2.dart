import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/widgets/preloder.dart';
import 'package:flutter_application_1/widgets/snackbar.dart';

class Sign23CombinedScreen extends StatefulWidget {
  final String name, email, password, role;
  const Sign23CombinedScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  }) : super(key: key);

  @override
  State<Sign23CombinedScreen> createState() => _Sign23CombinedScreenState();
}

class _Sign23CombinedScreenState extends State<Sign23CombinedScreen> {
  TextEditingController contactController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController unitNameController = TextEditingController();
  bool isLoading = false;

  Future<void> onTapSignup(BuildContext context) async {
    final contact = contactController.text.trim();
    final idNumber = idNumberController.text.trim();
    final unitName = unitNameController.text.trim();
    if (contact.isEmpty || idNumber.isEmpty || unitName.isEmpty) {
      context.showErrorSnackBar(message: 'All Fields must be filled!');
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: widget.email,
            password: widget.password,
          );
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(widget.name);
        await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
          'email': widget.email,
          'name': widget.name,
          'role': widget.role,
          'contact': contact,
          'idNumber': idNumber,
          'unitName': unitName,
          'uid': user.uid,
          'status': 'pending',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      UserData.status = "pending";
      UserData.email = widget.email;
      UserData.role = widget.role;
      UserData.uid = user!.uid;
      UserData.name = widget.name;
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/signappv', (route) => false);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!context.mounted) return;
      context.showErrorSnackBar(message: e.message ?? "Something went wrong");
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!context.mounted) return;
      context.showErrorSnackBar(message: e.toString());
    }
  }

  @override
  void dispose() {
    contactController.dispose();
    idNumberController.dispose();
    unitNameController.dispose();
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
                  ), // Add pattern asset if needed
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
                        ? preloader
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              Text(
                                'Signup',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                ),
                              ),
                              const SizedBox(height: 40),
                              TextField(
                                controller: contactController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Military Contact',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: idNumberController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Military ID Number',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: unitNameController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Unit Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () => onTapSignup(context),
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
                                  child: const Text('Signup'),
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
