import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/calendar/calendar_screen.dart';
import 'report_type.dart';
import 'uploadrequests.dart';
import 'documents.dart';

// void main() {
//   runApp(const AHQHome());
// }

int _selectedIndex = 0;

// class AHQHome extends StatelessWidget {
//   const AHQHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Admin Dashboard',
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//       ),
//       home: const AdminDashboard(),
//     );
//   }
// }

class AHQHome extends StatefulWidget {
  const AHQHome({super.key});

  @override
  State<AHQHome> createState() => _AHQHomeState();
}

class _AHQHomeState extends State<AHQHome> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2), // Light green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center all horizontally
          children: [
            const SizedBox(height: 24),
            const Text(
              'Welcome, AHQ!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Search bar
            Container(
              width: double.infinity, // Stretch to full width if needed
              padding: const EdgeInsets.symmetric(horizontal: 26),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: Color(0xFF006400)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Cards
            DashboardCard(
              title: 'Report Generator',
              icon: Icons.assignment, // Custom icon
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportTypeSelectorPage(),
                  ),
                );
              },
            ),
            DashboardCard(
              title: 'Pending Upload Requests',
              icon: Icons.cloud_upload, // Custom icon
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadRequests(),
                  ),
                );
              },
            ),
            DashboardCard(
              title: 'View Documents',
              icon: Icons.article, // Custom icon
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DocumentsPage(),
                  ),
                );
              },
            ),
            DashboardCard(
              title: 'Training Calendar',
              icon: Icons.calendar_today,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalendarScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData icon;

  const DashboardCard({
    Key? key,
    required this.title,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF006400),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
