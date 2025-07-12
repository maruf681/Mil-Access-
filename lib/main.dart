import 'package:flutter/material.dart';
import 'ahqhome.dart';
import 'contactbook.dart';
import 'pendingrequests.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AHQ Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeNavigator(),
    );
  }
}

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AHQHome(),         // Page 0
    ContactBook(),     // Page 1
    PendingRequests(), // Page 2
    ProfileScreen()    // Page 3 (make sure the class is named ProfileScreen)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2), // Soft green background
      body: Stack(
        children: [
          _pages[_selectedIndex], // Your actual page content

          // Positioned Bottom Navigation Bar
          Positioned(
            left: 20,
            right: 20,
            bottom: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  selectedItemColor: const Color(0xFF006400), // Deep Green
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.contacts),
                      label: 'Contacts',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.pending_actions),
                      label: 'Pending',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
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


