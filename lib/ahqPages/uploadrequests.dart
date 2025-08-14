import 'package:flutter/material.dart';
import 'pdf_viewer.dart'; // Make sure this file exists

// void main() {
//   runApp(const UploadRequests());
// }

class UploadRequests extends StatelessWidget {
  const UploadRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pending Upload Requests - AHQ',
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

  void _openDocument(String title) {
    final sanitizedTitle = title.replaceAll(' ', '_');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PDFViewerScreen(pdfAssetPath: 'assets/$sanitizedTitle.pdf'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2),
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
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Pending Upload Requests',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const _SearchBar(),
                  const SizedBox(height: 24),
                  ...[
                        'JSSDM Edition 2025',
                        'JSSDM Edition 2024',
                        'JSSDM Edition 2023',
                        'JSSDM Edition 2022',
                        'JSSDM Edition 2021',
                        'AR(R)',
                        'AR(I)',
                        'ADR',
                        'Signal Officers Handbook',
                        'ICIB',
                        'IPIB',
                        'MBML',
                        'Notes On MBML',
                      ]
                      .map(
                        (title) => DashboardCard(
                          title: title,
                          onAccept: _openDocument,
                        ),
                      )
                      .toList(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: BorderRadius.circular(24),
      //   child: BottomNavigationBar(
      //     currentIndex: _selectedIndex,
      //     onTap: _onItemTapped,
      //     selectedItemColor: const Color(0xFF006400),
      //     unselectedItemColor: Colors.grey,
      //     backgroundColor: Colors.transparent,
      //     type: BottomNavigationBarType.fixed,
      //     elevation: 0,
      //     selectedFontSize: 12,
      //     unselectedFontSize: 12,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Padding(
      //           padding: EdgeInsets.only(top: 6),
      //           child: Icon(Icons.home),
      //         ),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Padding(
      //           padding: EdgeInsets.only(top: 6),
      //           child: Icon(Icons.contacts),
      //         ),
      //         label: 'Contacts',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Padding(
      //           padding: EdgeInsets.only(top: 6),
      //           child: Icon(Icons.pending_actions),
      //         ),
      //         label: 'Pending',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Padding(
      //           padding: EdgeInsets.only(top: 6),
      //           child: Icon(Icons.person),
      //         ),
      //         label: 'Profile',
      //       ),
      //     ],
      //   ),
      // ),
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
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.search, color: Color(0xFF006400)),
        ],
      ),
    );
  }
}

class DashboardCard extends StatefulWidget {
  final String title;
  final void Function(String) onAccept;

  const DashboardCard({super.key, required this.title, required this.onAccept});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  bool _showOptions = false;

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
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
                backgroundColor: Color(0xFF006400),
                child: Icon(Icons.article, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _toggleOptions,
                child: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
        if (_showOptions)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006400),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.check),
                  label: const Text("Accept"),
                  onPressed: () {
                    widget.onAccept(widget.title);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Accepted: ${widget.title}')),
                    );
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.close),
                  label: const Text("Decline"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Declined: ${widget.title}')),
                    );
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.remove_red_eye_outlined),
                  label: const Text("View"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Declined: ${widget.title}')),
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
