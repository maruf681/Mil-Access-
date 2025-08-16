import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';

class ApprovedScreen extends StatefulWidget {
  const ApprovedScreen({super.key});
  @override
  State<ApprovedScreen> createState() => ApprovedScreenState();
}

class ApprovedScreenState extends State<ApprovedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA3C9A8), // Light green
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_box_outlined,
                    size: 120,
                    color: Color(0xFF1B5E20), // Dark green
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Your Application Has\nBeen Approved!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const Text(
                          'Profile details and information are verified for enhanced security. Thank you for your patience. Please Login to access the app.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
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
                            },
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
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Login Button (Bottom Center)
            // Positioned(
            //   bottom: 60,
            //   left: MediaQuery.of(context).size.width * 0.25,
            //   right: MediaQuery.of(context).size.width * 0.25,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/login');
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.white,
            //       elevation: 4,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       padding: const EdgeInsets.symmetric(vertical: 12),
            //     ),
            //     child: const Text(
            //       'Login',
            //       style: TextStyle(
            //         color: Color(0xFF1B5E20),
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
