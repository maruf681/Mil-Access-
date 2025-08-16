import 'package:flutter/material.dart';
import 'package:flutter_application_1/unusedPages/chat_page.dart';
import 'package:flutter_application_1/userPages/contact_info_page.dart';
import 'package:flutter_application_1/userPages/pending_requests_page.dart';
import 'package:flutter_application_1/ahqPages/profile_page.dart';
import 'package:provider/provider.dart';
import '../userPages/theme_notifier.dart';
// import 'pages/dashboard_page.dart';
// import 'pages/pending_requests_page.dart';
// import 'pages/contact_info_page.dart';
// import 'pages/profile_page.dart';
// import 'pages/chat_page.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: const indl()),
//   );
// }

class indl extends StatelessWidget {
  const indl({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'MILBOT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          170,
          242,
          153,
        ), // Set default green background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(
            255,
            170,
            242,
            153,
          ), // Match AppBar color
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          170,
          242,
          153,
        ), // Set default green background for dark theme too
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(
            255,
            170,
            242,
            153,
          ), // Match AppBar color
          elevation: 0,
        ),
      ),
      themeMode: themeNotifier.currentTheme, // switch dynamically
      home: const HomeScreen(), // Fixed: Changed from indl() to HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    //const DashboardPage(),
    const ContactInfoPage(),
    const PendingRequestPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _pages[_currentIndex], // Fixed: Changed from *pages[*currentIndex] to _pages[_currentIndex]
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 120, 248, 163),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            backgroundColor: const Color.fromARGB(255, 152, 231, 118),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.contacts),
                label: 'Contacts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pending_actions),
                label: 'Pending',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flash_on),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
