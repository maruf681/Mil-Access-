import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey; // Key to open drawer

  const CustomAppBar({
    super.key,
    required this.title,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // The background gradient/wave effect is complex for a simple AppBar.
      // For this example, we'll use a solid color that matches the overall theme
      // and focus on the layout of the icons and text.
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFDCEDC8), // A lighter green for the app bar background
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)), // Rounded bottom corners
        ),
        child: Stack(
          children: [
            // Placeholder for the wave pattern (can be CustomPaint for actual waves)
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black), // Menu icon
        onPressed: () {
          scaffoldKey.currentState?.openDrawer(); // Open the drawer
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true, // Center the title
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black), // Notification icon
          onPressed: () {
            // Handle notification tap
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30), // Match the flexibleSpace border radius
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20); // Standard app bar height + some extra padding
}

