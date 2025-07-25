import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';

// Define a class for individual request items
class RequestItem {
  final String name;
  final String phone;
  String status; // 'pending', 'accepted', 'rejected'

  RequestItem({required this.name, required this.phone, this.status = 'pending'});
}

class PendingRequestsScreen extends StatefulWidget {
  const PendingRequestsScreen({super.key});

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  // Using a List of RequestItem objects to manage state
  final List<RequestItem> _requests = [
    RequestItem(name: 'Lt Rafid', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Lt Abdullah', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Capt Omar', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Capt Saikat', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Lt Rohan', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Lt Asif', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Capt Titumir', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Capt Zainab', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Lt Tara', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Lt Sara', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Capt Oysik', phone: '+880 1769 XXXXX', status: 'pending'),
    RequestItem(name: 'Capt Rahul', phone: '+880 1769 XXXXX', status: 'pending'),
  ];

  void _acceptRequest(RequestItem request) {
    setState(() {
      request.status = 'accepted';
    });
    _showMessageBox(context, 'Request Accepted', '${request.name}\'s request has been accepted.');
  }

  void _rejectRequest(RequestItem request) {
    setState(() {
      request.status = 'rejected';
    });
    _showMessageBox(context, 'Request Rejected', '${request.name}\'s request has been rejected.');
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

  // Helper to get icon based on status
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'accepted':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.pending_actions;
    }
  }

  // Helper to get color based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Requests'),
        backgroundColor: Colors.green[700],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pending Requests',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SearchBarWidget(hintText: 'Search...'),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true, // Important for nested ListView
              physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(_getStatusIcon(request.status), color: _getStatusColor(request.status)),
                    title: Text(
                      request.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: request.status == 'rejected' ? TextDecoration.lineThrough : TextDecoration.none,
                        color: request.status == 'rejected' ? Colors.grey : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      request.phone,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check_circle, color: request.status == 'accepted' ? Colors.green : Colors.grey),
                          onPressed: request.status == 'pending'
                              ? () => _acceptRequest(request)
                              : null, // Disable if already acted upon
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel, color: request.status == 'rejected' ? Colors.red : Colors.grey),
                          onPressed: request.status == 'pending'
                              ? () => _rejectRequest(request)
                              : null, // Disable if already acted upon
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

