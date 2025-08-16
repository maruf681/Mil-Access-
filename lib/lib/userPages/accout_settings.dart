import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Account Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Example setting: Change username
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Change Username'),
            onTap: () {
              // TODO: Navigate to username change screen or dialog
            },
          ),

          // Example setting: Change password
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {
              // TODO: Navigate to password change screen or dialog
            },
          ),

          // Example setting: Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // TODO: Handle logout logic
            },
          ),
        ],
      ),
    );
  }
}
