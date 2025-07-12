import 'package:flutter/material.dart';

void main() {
  runApp(const PendingRequests());
}

class PendingRequests extends StatelessWidget {
  const PendingRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pending Requests - AHQ',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 24),
                  Text(
                    'Pending Requests',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  // Search Bar
                  _SearchBar(),
                  SizedBox(height: 24),

                  // Cards
                  DashboardCard(title: 'CO III Signal Battalion'),
                  DashboardCard(title: 'CO IX East Bengal Regiment'),
                  DashboardCard(title: 'CO XV Field Regiment'),
                  DashboardCard(title: 'CO XXXII ST Battalion'),
                  DashboardCard(title: 'CO XVII BIR'),
                  DashboardCard(title: 'OC EW Coy'),
                  DashboardCard(title: 'CO Army Static Signal Battalion'),
                  DashboardCard(title: 'CO XXVI Lancers'),
                  DashboardCard(title: 'OC Adhoc Satcom Unit'),
                  DashboardCard(title: 'Comdt 509 DOC'),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF006400),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.home),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.contacts),
              ),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.pending_actions),
              ),
              label: 'Pending',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.person),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: const [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.search, color: const Color(0xFF006400)),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;

  const DashboardCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const CircleAvatar(
            backgroundColor: const Color(0xFF006400),
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
              ],
            ),
          ),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
