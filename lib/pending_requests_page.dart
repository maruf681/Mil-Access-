import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class PendingRequestPage extends StatelessWidget {
  const PendingRequestPage({super.key});

  final List<String> requests = const [
    "CO 2 SIG BN",
    "CO 27 EB",
    "9 Bengal Lancers",
    "2 Engrs",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pending Requests")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SearchBarWidget(),
          ...requests.map((req) => CustomCard(title: req)),
        ],
      ),
    );
  }
}
