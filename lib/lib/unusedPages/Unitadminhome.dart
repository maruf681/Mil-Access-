import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Admin App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFE6F2E6),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    PendingRequestsScreen(),
    ContactDirectoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome, Unit Admin!'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SearchBar(),
          SizedBox(height: 20),
          MenuCard(title: 'Report Generator', subtitle: ''),
          MenuCard(title: 'Document Upload', subtitle: '2 Days ago'),
          MenuCard(title: 'Pending Requests', subtitle: '2 Days ago'),
          MenuCard(title: 'To-Do List', subtitle: '2 Days ago'),
        ],
      ),
    );
  }
}

class PendingRequestsScreen extends StatelessWidget {
  final List<Map<String, String>> requests = [
    {'name': 'Lt Rafid', 'phone': '+880 1769 XXXXX'},
    {'name': 'Lt Abdullah', 'phone': '+880 1769 XXXXX'},
    {'name': 'Capt Omar', 'phone': '+880 1769 XXXXX'},
    {'name': 'Capt Saikat', 'phone': '+880 1769 XXXXX'},
  ];

  PendingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Requests'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SearchBar(),
          const SizedBox(height: 20),
          ...requests.map((req) => MenuCard(
                title: req['name']!,
                subtitle: req['phone']!,
              )),
        ],
      ),
    );
  }
}

class ContactDirectoryScreen extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'name': 'Dhaka Exchange', 'date': '2 Days ago'},
    {'name': 'Barishal Exchange', 'date': '2 Days ago'},
    {'name': 'Sylhet Exchange', 'date': '2 Days ago'},
    {'name': 'Chattogram Exchange', 'date': '2 Days ago'},
  ];

  ContactDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Directory'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SearchBar(),
          const SizedBox(height: 20),
          ...contacts.map((contact) => MenuCard(
                title: contact['name']!,
                subtitle: contact['date']!,
              )),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1 Signal Battalion'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: Icon(Icons.security, size: 50, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text('Unit Admin', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('1sigbn@army.mil.bd'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('+880 1769 XXXXX'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(
                      'Jashore Cantonment, Jashore'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const MenuCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.assignment, color: Colors.green),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
