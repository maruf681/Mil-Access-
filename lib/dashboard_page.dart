import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  final List<String> items = const [
    "Report Generator",
    "Examiner Module",
    "Archive Database",
    "To-Do List",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SearchBarWidget(),
          ...items.map((item) => CustomCard(title: item)).toList(),
        ],
      ),
    );
  }
}
