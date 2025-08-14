import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoPage extends StatefulWidget {
  const ContactInfoPage({super.key});

  @override
  ContactInfoPageState createState() => ContactInfoPageState();
}

class ContactInfoPageState extends State<ContactInfoPage> {
  String selectedCategory = 'All';
  String searchQuery = '';
  List<String> favorites = [];
  List<String> recentContacts = [];

  final List<String> categories = [
    'All',
    'Command Structure',
    'Emergency Contacts',
    'External Contacts',
    'Support Services',
  ];

  final List<ContactInfo> contacts = [
    // Command Structure
    ContactInfo(
      name: 'Lt. General Rahman',
      rank: 'Lieutenant General',
      position: 'Corps Commander',
      phone: '+880-1711-123456',
      email: 'ltgen.rahman@army.mil.bd',
      radio: 'ALPHA-01',
      office: 'HQ Building, Room 101',
      category: 'Command Structure',
      isOnDuty: true,
      priority: 'High',
    ),
    ContactInfo(
      name: 'Brigadier Ahmed',
      rank: 'Brigadier',
      position: 'Chief of Staff',
      phone: '+880-1712-234567',
      email: 'brig.ahmed@army.mil.bd',
      radio: 'ALPHA-02',
      office: 'HQ Building, Room 102',
      category: 'Command Structure',
      isOnDuty: true,
      priority: 'High',
    ),
    ContactInfo(
      name: 'Colonel Khan',
      rank: 'Colonel',
      position: 'Operations Officer',
      phone: '+880-1713-345678',
      email: 'col.khan@army.mil.bd',
      radio: 'BRAVO-01',
      office: 'Operations Center',
      category: 'Command Structure',
      isOnDuty: false,
      priority: 'Medium',
    ),
    // Emergency Contacts
    ContactInfo(
      name: 'Medical Emergency',
      rank: 'N/A',
      position: 'Emergency Services',
      phone: '+880-1714-911911',
      email: 'medical@army.mil.bd',
      radio: 'MEDICAL-01',
      office: 'Medical Center',
      category: 'Emergency Contacts',
      isOnDuty: true,
      priority: 'Critical',
    ),
    ContactInfo(
      name: 'Security Control',
      rank: 'N/A',
      position: 'Base Security',
      phone: '+880-1715-999999',
      email: 'security@army.mil.bd',
      radio: 'SECURITY-01',
      office: 'Main Gate',
      category: 'Emergency Contacts',
      isOnDuty: true,
      priority: 'Critical',
    ),
    // External Contacts
    ContactInfo(
      name: 'Major Hasan',
      rank: 'Major',
      position: 'Liaison Officer',
      phone: '+880-1716-456789',
      email: 'maj.hasan@navy.mil.bd',
      radio: 'CHARLIE-01',
      office: 'Naval Base',
      category: 'External Contacts',
      isOnDuty: true,
      priority: 'Medium',
    ),
    // Support Services
    ContactInfo(
      name: 'IT Help Desk',
      rank: 'N/A',
      position: 'Technical Support',
      phone: '+880-1717-567890',
      email: 'ithelp@army.mil.bd',
      radio: 'TECH-01',
      office: 'IT Center',
      category: 'Support Services',
      isOnDuty: true,
      priority: 'Low',
    ),
    ContactInfo(
      name: 'Captain Uddin',
      rank: 'Captain',
      position: 'Logistics Officer',
      phone: '+880-1718-678901',
      email: 'capt.uddin@army.mil.bd',
      radio: 'DELTA-01',
      office: 'Supply Depot',
      category: 'Support Services',
      isOnDuty: false,
      priority: 'Medium',
    ),
  ];

  List<ContactInfo> get filteredContacts {
    return contacts.where((contact) {
      final matchesCategory =
          selectedCategory == 'All' || contact.category == selectedCategory;
      final matchesSearch =
          contact.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          contact.rank.toLowerCase().contains(searchQuery.toLowerCase()) ||
          contact.position.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
    _addToRecent(phoneNumber);
  }

  void _sendEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    await launchUrl(launchUri);
    _addToRecent(email);
  }

  void _sendMessage(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'sms', path: phoneNumber);
    await launchUrl(launchUri);
    _addToRecent(phoneNumber);
  }

  void _addToRecent(String contact) {
    setState(() {
      recentContacts.remove(contact);
      recentContacts.insert(0, contact);
      if (recentContacts.length > 5) {
        recentContacts.removeLast();
      }
    });
  }

  void _toggleFavorite(String contactName) {
    setState(() {
      if (favorites.contains(contactName)) {
        favorites.remove(contactName);
      } else {
        favorites.add(contactName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Info")),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Category Filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Colors.green.shade200,
                  ),
                );
              },
            ),
          ),

          // Emergency Quick Access
          if (selectedCategory == 'All' ||
              selectedCategory == 'Emergency Contacts')
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.emergency, color: Colors.red, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Emergency Contacts',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _makePhoneCall('+880-1714-911911'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('EMERGENCY'),
                  ),
                ],
              ),
            ),

          // Contacts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                final isFavorite = favorites.contains(contact.name);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 4,
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: _getPriorityColor(contact.priority),
                      child: Text(
                        contact.rank != 'N/A'
                            ? contact.rank.substring(0, 1)
                            : 'S',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            contact.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (contact.isOnDuty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'ON DUTY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => _toggleFavorite(contact.name),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${contact.rank} - ${contact.position}'),
                        Text(
                          'Radio: ${contact.radio}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(Icons.phone, 'Phone', contact.phone),
                            _buildInfoRow(Icons.email, 'Email', contact.email),
                            _buildInfoRow(Icons.radio, 'Radio', contact.radio),
                            _buildInfoRow(
                              Icons.location_on,
                              'Office',
                              contact.office,
                            ),
                            _buildInfoRow(
                              Icons.priority_high,
                              'Priority',
                              contact.priority,
                            ),

                            const SizedBox(height: 16),

                            // Action Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildActionButton(
                                  icon: Icons.phone,
                                  label: 'Call',
                                  color: Colors.green,
                                  onPressed: () =>
                                      _makePhoneCall(contact.phone),
                                ),
                                _buildActionButton(
                                  icon: Icons.email,
                                  label: 'Email',
                                  color: Colors.blue,
                                  onPressed: () => _sendEmail(contact.email),
                                ),
                                _buildActionButton(
                                  icon: Icons.message,
                                  label: 'Message',
                                  color: Colors.orange,
                                  onPressed: () => _sendMessage(contact.phone),
                                ),
                                _buildActionButton(
                                  icon: Icons.qr_code,
                                  label: 'QR',
                                  color: Colors.purple,
                                  onPressed: () => _showQRCode(contact),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          child: Icon(icon),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.blue;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showQRCode(ContactInfo contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  'QR Code\n${contact.name}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Scan to save contact', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class ContactInfo {
  final String name;
  final String rank;
  final String position;
  final String phone;
  final String email;
  final String radio;
  final String office;
  final String category;
  final bool isOnDuty;
  final String priority;

  ContactInfo({
    required this.name,
    required this.rank,
    required this.position,
    required this.phone,
    required this.email,
    required this.radio,
    required this.office,
    required this.category,
    required this.isOnDuty,
    required this.priority,
  });
}
