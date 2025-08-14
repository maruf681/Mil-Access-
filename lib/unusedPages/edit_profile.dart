import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String email;
  final String phone;
  final String username;

  const EditProfileScreen({
    super.key,
    required this.email,
    required this.phone,
    required this.username,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    usernameController = TextEditingController(text: widget.username);
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    Navigator.pop(context, {
      'email': emailController.text,
      'phone': phoneController.text,
      'username': usernameController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
