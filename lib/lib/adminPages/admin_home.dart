import 'package:flutter/material.dart';
// import 'package:milbot/features/task_management/task_management.dart';
import '../widgets/search_bar_widget.dart';
import '../features/calendar/calendar_screen.dart'; // Import for CalendarScreen
import '../features/document_upload/document_upload_screen.dart'; // Import for DocumentUploadScreen
import '../features/pending_leave_requests/pending_leave_requests_screen.dart'; // Import for PendingLeaveRequestsScreen
import '../features/incident_report/incident_report_screen.dart'; // Import for IncidentReportScreen
import '../features/task_management/task_management.dart'; // Import for ToDoListScreen
import '../features/quick_notes/quick_notes_screen.dart'; // New import for QuickNotesScreen

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The main AppBar for the screen
      appBar: AppBar(
        backgroundColor: Colors.green[700], // Consistent color
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Handle menu tap (e.g., open drawer)
          },
        ),
        title: const Text(
          'Welcome, Admin!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // Handle notification tap
            },
          ),
        ],
        // Removed shape property from AppBar to allow seamless merge with the container below
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center content horizontally
          children: [
            // This container now holds only the search bar and extends the AppBar's color
            Container(
              width: double.infinity, // Take full width
              // No borderRadius here, as the AppBar already defines the top shape
              decoration: BoxDecoration(
                color: Colors.green[700], // Consistent color
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ), // Added vertical padding
                child: SearchBarWidget(
                  hintText: '',
                ), // Your existing search bar
              ),
            ),
            const SizedBox(
              height: 20,
            ), // Space between top colored section and grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap:
                    true, // Important to make GridView work inside SingleChildScrollView
                physics:
                    const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                crossAxisCount: 2, // Two columns as per the image
                crossAxisSpacing: 16.0, // Spacing between columns
                mainAxisSpacing: 16.0, // Spacing between rows
                childAspectRatio: 0.9, // Adjust aspect ratio to fit content
                children: [
                  _buildGridItem(
                    context,
                    icon: Icons.upload_file,
                    label: 'Upload Document',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DocumentUploadScreen(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Events Calendar',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarScreen(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    icon: Icons.assignment, // Icon for Pending Leave Requests
                    label: 'Pending Leave Requests',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PendingLeaveRequestsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    icon: Icons.warning_amber, // Icon for Incident Report
                    label: 'Incident Report',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IncidentReportScreen(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    icon: Icons.checklist, // Icon for To Do List
                    label: 'Task Management',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ToDoListScreen(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    icon: Icons.note_add, // Icon for Quick Notes
                    label: 'Quick Notes',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuickNotesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Space at the bottom
          ],
        ),
      ),
      // Bottom navigation bar will be handled by HomePage
    );
  }

  Widget _buildGridItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(
                  0xFFDCEDC8,
                ), // Light green background for icon
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF4CAF50), // Darker green for icon
                size: 36,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
