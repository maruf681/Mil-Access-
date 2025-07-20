import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneTile = ListTile(
      leading: const Icon(Icons.phone),
      title: const Text('+880 1769 XXXXX'),
    );

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
                child: const Icon(
                  Icons.security,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text('Indl Profile', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Rafid Kabir'),
                ),
              ),
              Card(child: phoneTile),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Rangpur Cantonment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
