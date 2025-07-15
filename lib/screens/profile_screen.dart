import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1 Signal Battalion'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification tap
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: Icon(Icons.security, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text('Unit Admin', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('1sigbn@army.mil.bd'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('+880 1769 XXXXX'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text(
                      'Jashore Cantonment, Jashore'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

