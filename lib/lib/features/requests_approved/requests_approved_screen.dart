import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting

// Data model for an approved request
class ApprovedRequest {
  final String title;
  final DateTime approvalDateTime;

  ApprovedRequest({required this.title, required this.approvalDateTime});
}

class RequestsApprovedScreen extends StatefulWidget {
  const RequestsApprovedScreen({super.key});

  @override
  State<RequestsApprovedScreen> createState() => _RequestsApprovedScreenState();
}

class _RequestsApprovedScreenState extends State<RequestsApprovedScreen> {
  // Sample data for approved requests
  final List<ApprovedRequest> _approvedRequests = [
    ApprovedRequest(title: 'Leave Application - Lt. Karim', approvalDateTime: DateTime(2025, 7, 10, 10, 30)),
    ApprovedRequest(title: 'Procurement of New Radios', approvalDateTime: DateTime(2025, 7, 9, 14, 0)),
    ApprovedRequest(title: 'Training Exercise Approval - Alpha Coy', approvalDateTime: DateTime(2025, 7, 8, 9, 15)),
    ApprovedRequest(title: 'Vehicle Repair Sanction - Jeep 123', approvalDateTime: DateTime(2025, 7, 7, 11, 45)),
    ApprovedRequest(title: 'Construction of New Mess Hall', approvalDateTime: DateTime(2025, 7, 6, 16, 0)),
    ApprovedRequest(title: 'Promotion of Sgt. Rahman', approvalDateTime: DateTime(2025, 7, 5, 10, 0)),
    ApprovedRequest(title: 'Deployment to UN Mission - Capt. Hasan', approvalDateTime: DateTime(2025, 7, 4, 13, 20)),
    ApprovedRequest(title: 'Budget Allocation for Sports Event', approvalDateTime: DateTime(2025, 7, 3, 9, 50)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests Approved'),
        backgroundColor: Colors.green[700],
      ),
      body: _approvedRequests.isEmpty
          ? const Center(
              child: Text(
                'No approved requests found.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _approvedRequests.length,
              itemBuilder: (context, index) {
                final request = _approvedRequests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green[700]),
                    title: Text(
                      request.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      'Approved on: ${DateFormat('dd MMM yyyy').format(request.approvalDateTime)} at ${DateFormat('hh:mm a').format(request.approvalDateTime)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    // You can add more details or actions here if needed
                    onTap: () {
                      // Optional: Show more details about the approved request
                      _showMessageBox(
                        context,
                        'Request Details',
                        'Title: ${request.title}\nApproved: ${DateFormat('dd MMM yyyy hh:mm a').format(request.approvalDateTime)}',
                      );
                    },
                  ),
                );
              },
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

