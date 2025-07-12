import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;

  const TopBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.menu, size: 28),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Icon(Icons.notifications_none),
      ],
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.search, color: Colors.green),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;

  const CustomCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: Icon(Icons.assignment, color: Colors.green),
        title: Text(title),
        subtitle: Text("2 Days ago"),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(text),
    );
  }
}
