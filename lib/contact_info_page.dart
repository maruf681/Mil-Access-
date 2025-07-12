import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({super.key});

  final List<String> contacts = const [
    "Dhaka Exchange",
    "Chattogram Exchange",
    "Jashore Exchange",
    "Rangpur Exchange",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Info")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SearchBarWidget(),
          ...contacts.map((contact) => CustomCard(title: contact)).toList(),
        ],
      ),
    );
  }
}
