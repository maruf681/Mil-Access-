import 'package:flutter/material.dart';

void main() {
  runApp(SignAppApproved());
}

class SignAppApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApprovedScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ApprovedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA3C9A8), // Light green
      body: SafeArea(
        child: Stack(
          children: [
            // Menu Icon
            Positioned(
              top: 16,
              left: 16,
              child: Icon(Icons.menu, color: Colors.black87, size: 30),
            ),

            // Centered Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_box_outlined,
                    size: 120,
                    color: Color(0xFF1B5E20), // Dark green
                  ),
                  const SizedBox(height: 20),

                  // Main Title
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Profile details and information are verified for enhanced security. Thank you for your patience. Please Login to access the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),

            // Login Button (Bottom Center)
            Positioned(
              bottom: 60,
              left: MediaQuery.of(context).size.width * 0.25,
              right: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                onPressed: () {
                  // Handle login navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
