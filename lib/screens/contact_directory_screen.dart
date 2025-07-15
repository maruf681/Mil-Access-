import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart'; // Renamed import
import '../widgets/menu_card.dart'; // Renamed import

class ContactDirectoryScreen extends StatelessWidget {
  const ContactDirectoryScreen({super.key});

  final List<Map<String, String>> contacts = const [
   {'name': 'Dhaka Exchange', 'date': '2 Days ago'},
    {'name': 'Barishal Exchange', 'date': '2 Days ago'},
    {'name': 'Sylhet Exchange', 'date': '2 Days ago'},
    {'name': 'Chattogram Exchange', 'date': '2 Days ago'},
    {'name': 'Khulna Exchange', 'date': '5 Days ago'},
    {'name': 'Rajshahi Exchange', 'date': '1 Day ago'},
    {'name': 'Comilla Exchange', 'date': '3 Days ago'},
    {'name': 'Rangpur Exchange', 'date': '7 Days ago'},
    {'name': 'Mymensingh Exchange', 'date': '4 Days ago'},
    {'name': 'Cox\'s Bazar Exchange', 'date': '6 Days ago'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Directory'),
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SearchBarWidget(), // Using the renamed widget
          const SizedBox(height: 20),
          ...contacts.map((contact) => MenuCard(
                title: contact['name']!,
                subtitle: contact['date']!,
              )),
        ],
      ),
    );
  }
}

