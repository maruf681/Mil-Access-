import 'package:flutter/material.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E4D0),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.green, size: 28),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Full green circle with black arc
              SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(painter: _FullGreenWithArcPainter()),
              ),
              const SizedBox(height: 40),
              const Text(
                'Your Application Is Sent For Approval!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Profile details and information are being verified for enhanced security. Please have patience. This may take a while.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FullGreenWithArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;

    // Draw full green circle
    final greenPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, radius, greenPaint);

    // Draw black arc on top of green circle
    final blackPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.14,
      0.75 * 3.14,
      false,
      blackPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
