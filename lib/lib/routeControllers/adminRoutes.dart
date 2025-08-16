import 'package:flutter/material.dart';
import 'package:flutter_application_1/adminPages/admin_home.dart';
import 'package:flutter_application_1/adminPages/pending_requests_screen.dart';
import 'package:flutter_application_1/ahqPages/profile_page.dart';
import 'package:flutter_application_1/userPages/contact_info_page.dart';

class Adminroutes extends StatefulWidget {
  const Adminroutes({super.key});
  @override
  State<Adminroutes> createState() => AdminroutesState();
}

class AdminroutesState extends State<Adminroutes> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTapped,
        physics: const BouncingScrollPhysics(),
        children: const [
          AdminHomeScreen(),
          ContactInfoPage(),
          PendingRequestsScreen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onNavTapped,
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
