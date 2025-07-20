import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF7ED321), // Light green
            Color(0xFF4A90E2), // Light blue
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, color: Colors.white, size: 28),
                  Icon(Icons.notifications, color: Colors.white, size: 28),
                ],
              ),
            ),

            // Welcome Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Welcome, User!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.green),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Grid of Icons
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildGridItem(
                      Icons.description,
                      'Generate\nReport',
                      Colors.green[800]!,
                    ),
                    _buildGridItem(
                      Icons.school,
                      'Exam\nModule',
                      Colors.green[800]!,
                    ),
                    _buildGridItem(
                      Icons.settings,
                      'Settings',
                      Colors.green[800]!,
                    ),
                    _buildGridItem(
                      Icons.archive,
                      'Archive\nDatabase',
                      Colors.green[800]!,
                    ),
                    _buildGridItem(
                      Icons.check,
                      'To-Do\nList',
                      Colors.green[800]!,
                    ),
                    _buildGridItem(
                      Icons.calendar_today,
                      'Training\nCalendar',
                      Colors.green[800]!,
                    ),
                    _buildGridItem(
                      Icons.warning,
                      'Report\nIncident',
                      Colors.green[800]!,
                    ),
                    _buildGridItem(
                      Icons.note,
                      'Quick\nNotes',
                      Colors.green[800]!,
                    ),
                    _buildGridItem(
                      Icons.exit_to_app,
                      'Request\nLeave',
                      Colors.green[800]!,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
