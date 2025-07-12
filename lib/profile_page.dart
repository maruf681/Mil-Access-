import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 30),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green,
            child: Icon(Icons.shield, size: 50, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Army Head Quarters',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text('AHQ Admin'),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    InfoRow(icon: Icons.email, text: "ahq@army.mil.bd"),
                    InfoRow(icon: Icons.phone, text: "+880 1769 XXXXX"),
                    InfoRow(
                      icon: Icons.location_on,
                      text:
                          "Information Technology Directorate\nGeneral Staff Branch\nArmy Headquarters\nDhaka Cantonment, Dhaka – 1206",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
