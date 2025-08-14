import 'package:flutter/material.dart';
import 'ammunition_report.dart';// Rename your ammunition_report.dart to this
import 'convoy_report.dart';
import 'grenade_report.dart';
import 'patrolling_report.dart';



class ReportTypeSelectorPage extends StatelessWidget {
  const ReportTypeSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reportTypes = [
      {
        'title': 'SA Firing Report',
        'icon': Icons.local_fire_department,
        'page': const ReportGeneratorPage(),
      },
      {
        'title': 'Mov Report',
        'icon': Icons.directions_bus,
        'page': const ConvoyReportPage(),
      },
      {
        'title': 'Grenade Firing Report',
        'icon': Icons.brightness_high,
        'page': const GrenadeReportPage(),
      },
      {
        'title': 'Patrolling Report',
        'icon': Icons.directions_walk,
        'page': const PatrollingReportPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Report Type',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: reportTypes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final report = reportTypes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => report['page']),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(report['icon'], color: const Color(0xFF006400), size: 32),
                  const SizedBox(width: 16),
                  Text(
                    report['title'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'This form is coming soon!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
