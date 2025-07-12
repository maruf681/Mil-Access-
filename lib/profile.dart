import 'package:flutter/material.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = 'ahq@army.mil.bd';
  String phone = '+880 1769 XXXXX';
  String username = 'AHQ Admin';

  Future<void> _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          email: email,
          phone: phone,
          username: username,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        email = result['email'];
        phone = result['phone'];
        username = result['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2), // Soft green
      body: SafeArea(
        child: Column(
          children: [
            // Header (Icons)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.menu, color: Colors.black),
                  Icon(Icons.notifications_none, color: Colors.black),
                ],
              ),
            ),

            // Logo + Title
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF006400), width: 3),
                  ),
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/logo.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 4),
                Text(
                  username,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "AHQ Admin",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),

              ],
            ),

            const SizedBox(height: 16),

            // Expanded White Card Section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.email, color: Color(0xFF006400)),
                          const SizedBox(width: 10),
                          Text(email, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Color(0xFF006400)),
                          const SizedBox(width: 10),
                          Text(phone, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.location_on, color: Color(0xFF006400)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Information Technology Directorate\n'
                                  'General Staff Branch\n'
                                  'Army Headquarters\n'
                                  'Dhaka Cantonment, Dhaka - 1206',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Edit button inside card
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: _editProfile,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF006400),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
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
