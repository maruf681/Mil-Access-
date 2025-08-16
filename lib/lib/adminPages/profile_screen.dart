import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var listTile = const ListTile(
      leading: Icon(Icons.phone),
      title: Text('+880 1769 XXXXX'),
    );
    var listTile2 = listTile;
    var listTile22 = listTile2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('1 Signal Battalion'),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
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
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: Icon(Icons.security, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text('Unit Admin', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('1sigbn@army.mil.bd'),
                ),
              ),
              Card(child: listTile22),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Jashore Cantonment, Jashore'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
