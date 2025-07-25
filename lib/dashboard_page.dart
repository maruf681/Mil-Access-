import 'package:flutter/material.dart';
import 'report_generation_page.dart';
import 'exam_module_page.dart';
import 'settings_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void _showNotificationPanel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.notifications, color: Colors.green[800]),
              SizedBox(width: 8),
              Text('Notifications'),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView(
              children: [
                _buildNotificationItem(
                  'Pending Request',
                  'You have 3 pending leave requests to review',
                  Icons.pending_actions,
                  Colors.orange,
                ),
                _buildNotificationItem(
                  'Training Reminder',
                  'Safety training scheduled for tomorrow at 09:00',
                  Icons.school,
                  Colors.blue,
                ),
                _buildNotificationItem(
                  'System Alert',
                  'Monthly report submission deadline: 2 days left',
                  Icons.warning,
                  Colors.red,
                ),
                _buildNotificationItem(
                  'New Message',
                  'You have 5 unread messages in chat',
                  Icons.message,
                  Colors.green,
                ),
                _buildNotificationItem(
                  'Update Available',
                  'New app version available for download',
                  Icons.system_update,
                  Colors.purple,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
              ),
              child: Text('View All'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotificationItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green[800]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome, User!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'user@military.gov',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.pending_actions),
              title: Text('Pending Requests'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => Navigator.pop(context),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () => Navigator.pop(context),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor,
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
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: Theme.of(context).iconTheme.color,
                        size: 28,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showNotificationPanel(context),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Theme.of(context).iconTheme.color,
                            size: 28,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0.2,
                    mainAxisSpacing: 0.1,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ReportGenerationPage(),
                            ),
                          );
                        },
                        child: _buildGridItem(
                          context,
                          Icons.description,
                          'Generate\nReport',
                          Colors.green[800]!,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExamModulePage(),
                            ),
                          );
                        },
                        child: _buildGridItem(
                          context,
                          Icons.school,
                          'Exam\nModule',
                          Colors.green[800]!,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                        },
                        child: _buildGridItem(
                          context,
                          Icons.settings,
                          'Settings',
                          Colors.green[800]!,
                        ),
                      ),

                      _buildGridItem(
                        context,
                        Icons.archive,
                        'Archive\nDatabase',
                        Colors.green[800]!,
                      ),
                      _buildGridItem(
                        context,
                        Icons.check,
                        'To-Do\nList',
                        Colors.green[800]!,
                      ),
                      _buildGridItem(
                        context,
                        Icons.calendar_today,
                        'Training\nCalendar',
                        Colors.green[800]!,
                      ),
                      _buildGridItem(
                        context,
                        Icons.warning,
                        'Report\nIncident',
                        Colors.green[800]!,
                      ),
                      _buildGridItem(
                        context,
                        Icons.note,
                        'Quick\nNotes',
                        Colors.green[800]!,
                      ),
                      _buildGridItem(
                        context,
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
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 40),
        ),
        SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
