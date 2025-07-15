import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart'; // Renamed import
import '../widgets/menu_card.dart'; // Renamed import

class PendingRequestsScreen extends StatelessWidget {
  const PendingRequestsScreen({super.key});

  final List<Map<String, String>> requests = const [
    {'name': 'Lt Rafid', 'phone': '+880 1769 XXXXX'},
    {'name': 'Lt Abdullah', 'phone': '+880 1769 XXXXX'},
    {'name': 'Capt Omar', 'phone': '+880 1769 XXXXX'},
    {'name': 'Capt Saikat', 'phone': '+880 1769 XXXXX'},
    {'name': 'Lt Rohan', 'phone': '+880 1769 XXXXX'},
    {'name': 'Lt Asif', 'phone': '+880 1769 XXXXX'},
    {'name': 'Capt Titumir', 'phone': '+880 1769 XXXXX'},
    {'name': 'Capt Zainab', 'phone': '+880 1769 XXXXX'},
    {'name': 'Lt Tara', 'phone': '+880 1769 XXXXX'},
    {'name': 'Lt Sara', 'phone': '+880 1769 XXXXX'},
    {'name': 'Capt Oysik', 'phone': '+880 1769 XXXXX'},
    {'name': 'Capt Rahul', 'phone': '+880 1769 XXXXX'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Requests'),
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
          ...requests.map((req) => MenuCard(
                title: req['name']!,
                subtitle: req['phone']!,
              )),
        ],
      ),
    );
  }
}

