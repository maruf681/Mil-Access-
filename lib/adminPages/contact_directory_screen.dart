import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';

// --- Data Models ---
class Unit {
  final String name;
  final String coNumber;
  final String twoIcNumber;
  final String adjNumber;
  final String qmNumber;

  Unit({
    required this.name,
    required this.coNumber,
    required this.twoIcNumber,
    required this.adjNumber,
    required this.qmNumber,
  });
}

class Cantonment {
  final String name;
  final List<Unit> units;

  Cantonment({required this.name, required this.units});
}

class ContactDirectoryScreen extends StatefulWidget {
  const ContactDirectoryScreen({super.key});

  @override
  State<ContactDirectoryScreen> createState() => _ContactDirectoryScreenState();
}

class _ContactDirectoryScreenState extends State<ContactDirectoryScreen> {
  // --- Sample Data ---
  // This data structure now holds cantonments, and each cantonment holds its units
  final List<Cantonment> _cantonmentsData = [
    Cantonment(
      name: 'Dhaka Cantonment',
      units: [
        Unit(
          name: '1 Signal Battalion',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
        Unit(
          name: '2 Field Regiment Artillery',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
        Unit(
          name: '46 Independent Infantry Brigade',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
        Unit(
          name: 'Army Headquarters (AHQ)',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
        Unit(
          name: 'MIST (Military Institute of Science and Technology)',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Jashore Cantonment',
      units: [
        Unit(
          name: '3 East Bengal Regiment',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
        Unit(
          name: '10 Field Ambulance',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Savar Cantonment',
      units: [
        Unit(
          name: '9 Infantry Division',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
        Unit(
          name: 'Bangladesh Ordnance Factory',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Chattogram Cantonment',
      units: [
        Unit(
          name: '24 Infantry Division',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
        Unit(
          name: 'East Bengal Regimental Centre',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Comilla Cantonment',
      units: [
        Unit(
          name: '33 Infantry Division',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Rangpur Cantonment',
      units: [
        Unit(
          name: '66 Infantry Division',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Mymensingh Cantonment',
      units: [
        Unit(
          name: '19 Infantry Division',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Sylhet Cantonment',
      units: [
        Unit(
          name: '17 Infantry Division',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Khulna Cantonment',
      units: [
        Unit(
          name: 'Army Medical College Jessore',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Bogura Cantonment',
      units: [
        Unit(
          name: '11 Infantry Division',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Rajshahi Cantonment',
      units: [
        Unit(
          name:
              'Bangladesh Army University of Engineering & Technology (BAUET)',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Saidpur Cantonment',
      units: [
        Unit(
          name: '6 Infantry Brigade',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Ghatail Cantonment',
      units: [
        Unit(
          name: '19 Infantry Division (Ghatail)',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Jalalabad Cantonment',
      units: [
        Unit(
          name: 'Artillery Centre & School',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Kaptai Cantonment',
      units: [
        Unit(
          name: '203 Infantry Brigade',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Bandarban Cantonment',
      units: [
        Unit(
          name: '69 Infantry Brigade',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Cox\'s Bazar Cantonment',
      units: [
        Unit(
          name: '10 Infantry Division',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Bhairab Cantonment',
      units: [
        Unit(
          name: 'Army Service Corps Centre & School',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Rangamati Cantonment',
      units: [
        Unit(
          name: '305 Infantry Brigade',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
    Cantonment(
      name: 'Kishoreganj Cantonment',
      units: [
        Unit(
          name: 'Army Education Corps Centre & School',
          coNumber: '01769XXXXXX',
          twoIcNumber: '01769XXXXXX',
          adjNumber: '01769XXXXXX',
          qmNumber: '01769XXXXXX',
        ),
      ],
    ),
  ];

  // State variables for navigation
  Cantonment? _selectedCantonment;
  Unit? _selectedUnit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedUnit != null
              ? _selectedUnit!
                    .name // Display unit name if unit is selected
              : _selectedCantonment != null
              ? _selectedCantonment!
                    .name // Display cantonment name if cantonment is selected
              : 'Contact Directory', // Default title
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        leading: _selectedCantonment != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    if (_selectedUnit != null) {
                      _selectedUnit = null; // Go back to unit list
                    } else {
                      _selectedCantonment = null; // Go back to cantonment list
                    }
                  });
                },
              )
            : null, // No back button on the main cantonment list
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notification tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(hintText: 'Search...'),
            const SizedBox(height: 20),
            // Conditionally render content based on navigation state
            if (_selectedUnit != null)
              _buildUnitDetails(_selectedUnit!)
            else if (_selectedCantonment != null)
              _buildUnitList(_selectedCantonment!)
            else
              _buildCantonmentList(),
          ],
        ),
      ),
    );
  }

  // --- View Builders ---

  Widget _buildCantonmentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _cantonmentsData.map((cantonment) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.location_on, color: Color(0xFF4CAF50)),
            title: Text(
              cantonment.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {
              setState(() {
                _selectedCantonment = cantonment;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUnitList(Cantonment cantonment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Units in ${cantonment.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...cantonment.units.map((unit) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.military_tech,
                color: Color(0xFF4CAF50),
              ),
              title: Text(
                unit.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                setState(() {
                  _selectedUnit = unit;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildUnitDetails(Unit unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Contacts for ${unit.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildContactRow(Icons.person, 'CO', unit.coNumber),
                const Divider(),
                _buildContactRow(Icons.group, '2IC', unit.twoIcNumber),
                const Divider(),
                _buildContactRow(Icons.assignment_ind, 'Adj', unit.adjNumber),
                const Divider(),
                _buildContactRow(Icons.warehouse, 'QM', unit.qmNumber),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String role, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green[700]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(number),
              ],
            ),
          ),
          // Optionally add a call icon here
          IconButton(
            icon: Icon(Icons.phone, color: Colors.green[700]),
            onPressed: () {
              // Implement call functionality (e.g., using url_launcher package)
              _showMessageBox(context, 'Call', 'Initiating call to $number');
            },
          ),
        ],
      ),
    );
  }

  void _showMessageBox(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
