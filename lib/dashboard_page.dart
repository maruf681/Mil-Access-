import 'package:flutter/material.dart';
import 'report_generation_page.dart';
import 'exam_module_page.dart';
import 'settings_page.dart';
import 'contact_info_page.dart';
import 'pending_requests_page.dart';
import 'chat_page.dart';
import 'profile_page.dart';
import 'archive_database_page.dart';
import 'todo_page.dart';
import 'training_calender_page.dart';
import 'report_incident_page.dart';
import 'quick_notes_page.dart';
import 'request_leave_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  String searchQuery = '';
  bool isSearchActive = false;
  List<String> recentSearches = [
    'Report Generation',
    'Contact Info',
    'Settings',
  ];

  // Search data for different categories
  final List<SearchItem> allSearchItems = [
    // Features/Pages
    SearchItem(
      title: 'Generate Report',
      category: 'Features',
      keywords: ['report', 'generate', 'document'],
      icon: Icons.description,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ReportGenerationPage()),
      ),
    ),
    SearchItem(
      title: 'Exam Module',
      category: 'Features',
      keywords: ['exam', 'test', 'module', 'training'],
      icon: Icons.school,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExamModulePage()),
      ),
    ),
    SearchItem(
      title: 'Settings',
      category: 'Features',
      keywords: ['settings', 'preferences', 'config'],
      icon: Icons.settings,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      ),
    ),
    SearchItem(
      title: 'Contact Info',
      category: 'Features',
      keywords: ['contact', 'phone', 'directory', 'people'],
      icon: Icons.contacts,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactInfoPage()),
      ),
    ),
    SearchItem(
      title: 'Pending Requests',
      category: 'Features',
      keywords: ['pending', 'requests', 'approval', 'leave'],
      icon: Icons.pending_actions,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PendingRequestPage()),
      ),
    ),
    SearchItem(
      title: 'Chat',
      category: 'Features',
      keywords: ['chat', 'message', 'communication'],
      icon: Icons.chat,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatPage()),
      ),
    ),
    SearchItem(
      title: 'Profile',
      category: 'Features',
      keywords: ['profile', 'account', 'personal'],
      icon: Icons.person,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      ),
    ),
    SearchItem(
      title: 'Archive Database',
      category: 'Features',
      keywords: ['archive', 'database', 'history', 'records'],
      icon: Icons.archive,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArchiveDatabasePage()),
      ),
    ),
    SearchItem(
      title: 'To-Do List',
      category: 'Features',
      keywords: ['todo', 'task', 'checklist', 'list'],
      icon: Icons.check,
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TodoPage()),
      ),
    ),
    // Quick Actions
    SearchItem(
      title: 'Request Leave',
      category: 'Quick Actions',
      keywords: ['leave', 'request', 'vacation', 'time off'],
      icon: Icons.exit_to_app,
      onTap: (context) => _showComingSoon(context, 'Request Leave'),
    ),
    SearchItem(
      title: 'Report Incident',
      category: 'Quick Actions',
      keywords: ['incident', 'report', 'emergency', 'alert'],
      icon: Icons.warning,
      onTap: (context) => _showComingSoon(context, 'Report Incident'),
    ),
    SearchItem(
      title: 'Training Calendar',
      category: 'Quick Actions',
      keywords: ['training', 'calendar', 'schedule', 'events'],
      icon: Icons.calendar_today,
      onTap: (context) => _showComingSoon(context, 'Training Calendar'),
    ),
    SearchItem(
      title: 'Quick Notes',
      category: 'Quick Actions',
      keywords: ['notes', 'memo', 'reminder', 'write'],
      icon: Icons.note,
      onTap: (context) => _showComingSoon(context, 'Quick Notes'),
    ),
  ];

  static void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon!'),
        backgroundColor: Colors.green[800],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });

    searchFocusNode.addListener(() {
      setState(() {
        isSearchActive = searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  List<SearchItem> get filteredSearchResults {
    if (searchQuery.isEmpty) return [];

    return allSearchItems.where((item) {
      return item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.keywords.any(
            (keyword) =>
                keyword.toLowerCase().contains(searchQuery.toLowerCase()),
          );
    }).toList();
  }

  void _performSearch(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      setState(() {
        recentSearches.insert(0, query);
        if (recentSearches.length > 5) {
          recentSearches.removeLast();
        }
      });
    }
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
      searchQuery = '';
      searchFocusNode.unfocus();
    });
  }

  void _showNotificationPanel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications, color: Colors.green[800]),
                      SizedBox(width: 8),
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  ),
                ],
              ),
            ),
          ),
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
        color: color.withOpacity(0.1),
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
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactInfoPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.pending_actions),
              title: Text('Pending Requests'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PendingRequestPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
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
      body: Builder(
        builder: (BuildContext scaffoldContext) {
          return Container(
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
                            Scaffold.of(scaffoldContext).openDrawer();
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

                  // Enhanced Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
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
                            controller: searchController,
                            focusNode: searchFocusNode,
                            onSubmitted: _performSearch,
                            decoration: InputDecoration(
                              hintText:
                                  'Search features, contacts, or actions...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (searchQuery.isNotEmpty)
                                    IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                      onPressed: _clearSearch,
                                    ),
                                  AnimatedRotation(
                                    turns: isSearchActive ? 0.5 : 0.0,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Search Results or Recent Searches
                        if (isSearchActive)
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (searchQuery.isEmpty) ...[
                                  // Recent Searches
                                  if (recentSearches.isNotEmpty) ...[
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Recent Searches',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    ...recentSearches.map(
                                      (search) => ListTile(
                                        leading: Icon(
                                          Icons.history,
                                          color: Colors.grey,
                                        ),
                                        title: Text(search),
                                        onTap: () {
                                          searchController.text = search;
                                          setState(() {
                                            searchQuery = search;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ] else ...[
                                  // Search Results
                                  if (filteredSearchResults.isNotEmpty) ...[
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Search Results (${filteredSearchResults.length})',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    ...filteredSearchResults.map(
                                      (item) => ListTile(
                                        leading: Icon(
                                          item.icon,
                                          color: Colors.green[800],
                                        ),
                                        title: Text(item.title),
                                        subtitle: Text(item.category),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                        ),
                                        onTap: () async {
                                          _performSearch(searchQuery);
                                          searchController.clear();
                                          setState(() {
                                            searchQuery = '';
                                            isSearchActive = false;
                                          });
                                          searchFocusNode.unfocus();

                                          // Ensure navigation happens after UI update
                                          await Future.delayed(
                                            Duration(milliseconds: 50),
                                          );
                                          if (context.mounted) {
                                            item.onTap(context);
                                          }
                                        },
                                      ),
                                    ),
                                  ] else ...[
                                    Padding(
                                      padding: EdgeInsets.all(32),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.search_off,
                                            size: 48,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'No results found for "$searchQuery"',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Grid of Cards (only show when search is not active)
                  if (!isSearchActive)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.0,
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
                              child: _buildCardItem(
                                context,
                                Icons.description,
                                'Generate\nReport',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ExamModulePage(),
                                  ),
                                );
                              },
                              child: _buildCardItem(
                                context,
                                Icons.school,
                                'Exam\nModule',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArchiveDatabasePage(),
                                  ),
                                );
                              },
                              child: _buildCardItem(
                                context,
                                Icons.archive,
                                'Archive\nDatabase',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TrainingCalendarPage(),
                                  ),
                                );
                              },
                              child: _buildCardItem(
                                context,
                                Icons.calendar_today,
                                'Training\nCalendar',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ReportIncidentPage(),
                                  ),
                                );
                              },
                              child: _buildCardItem(
                                context,
                                Icons.warning,
                                'Report\nIncident',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TodoPage(),
                                  ),
                                );
                              },
                              child: _buildCardItem(
                                context,
                                Icons.check,
                                'To-Do\nList',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const QuickNotesPage(),
                                  ),
                                );
                              },
                              child: _buildCardItem(
                                context,
                                Icons.note,
                                'Quick\nNotes',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RequestLeavePage(),
                                  ),
                                );
                              },
                              child: _buildCardItem(
                                context,
                                Icons.exit_to_app,
                                'Request\nLeave',
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
                              child: _buildCardItem(
                                context,
                                Icons.settings,
                                'Settings',
                              ),
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
        },
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.green[800], size: 30),
          ),
          SizedBox(height: 7),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchItem {
  final String title;
  final String category;
  final List<String> keywords;
  final IconData icon;
  final Function(BuildContext) onTap;

  SearchItem({
    required this.title,
    required this.category,
    required this.keywords,
    required this.icon,
    required this.onTap,
  });
}
