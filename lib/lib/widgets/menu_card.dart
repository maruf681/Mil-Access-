import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const MenuCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.assignment, color: Colors.green),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}

