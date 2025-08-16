import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting

// Data model for a leave request
class LeaveRequest {
  final String applicantName;
  final String applicantDetails; // e.g., "Lt. Karim, BA-12345, 1 Signal Bn"
  final String requestDetails; // e.g., "Casual Leave for 3 days (15-17 Jul 2025)"
  String status; // 'pending', 'approved', 'disapproved'
  DateTime? actionDateTime; // When the request was approved/disapproved

  LeaveRequest({
    required this.applicantName,
    required this.applicantDetails,
    required this.requestDetails,
    this.status = 'pending',
    this.actionDateTime,
  });
}

class PendingLeaveRequestsScreen extends StatefulWidget {
  const PendingLeaveRequestsScreen({super.key});

  @override
  State<PendingLeaveRequestsScreen> createState() => _PendingLeaveRequestsScreenState();
}

class _PendingLeaveRequestsScreenState extends State<PendingLeaveRequestsScreen> {
  // Sample data for pending leave requests
  final List<LeaveRequest> _leaveRequests = [
    LeaveRequest(
      applicantName: 'Lt. Rafid',
      applicantDetails: 'Lt. Rafid, BA-12345, 1 Signal Bn',
      requestDetails: 'Casual Leave for 3 days (25-27 Jul 2025) due to family event.',
      status: 'pending',
    ),
    LeaveRequest(
      applicantName: 'Capt. Abdullah',
      applicantDetails: 'Capt. Abdullah, BA-67890, 2 Field Regt Arty',
      requestDetails: 'Earned Leave for 7 days (01-07 Aug 2025) for personal matters.',
      status: 'pending',
    ),
    LeaveRequest(
      applicantName: 'Maj. Omar',
      applicantDetails: 'Maj. Omar, BA-11223, AHQ',
      requestDetails: 'Sick Leave for 2 days (20-21 Jul 2025) due to flu.',
      status: 'pending',
    ),
    LeaveRequest(
      applicantName: 'Snk. Saikat',
      applicantDetails: 'Snk. Saikat, SNK-98765, 46 Indep Inf Bde',
      requestDetails: 'Casual Leave for 1 day (22 Jul 2025) for a medical appointment.',
      status: 'pending',
    ),
    LeaveRequest(
      applicantName: 'Lt. Rohan',
      applicantDetails: 'Lt. Rohan, BA-54321, MIST',
      requestDetails: 'Study Leave for 10 days (05-14 Aug 2025) for exam preparation.',
      status: 'pending',
    ),
    LeaveRequest(
      applicantName: 'Capt. Asif',
      applicantDetails: 'Capt. Asif, BA-24680, 3 East Bengal Regt',
      requestDetails: 'Maternity Leave for 90 days (01 Sep - 30 Nov 2025).',
      status: 'pending',
    ),
  ];

  void _approveRequest(LeaveRequest request) {
    setState(() {
      request.status = 'approved';
      request.actionDateTime = DateTime.now();
    });
    _showMessageBox(context, 'Request Approved', '${request.applicantName}\'s leave request has been approved.');
  }

  void _disapproveRequest(LeaveRequest request) {
    setState(() {
      request.status = 'disapproved';
      request.actionDateTime = DateTime.now();
    });
    _showMessageBox(context, 'Request Disapproved', '${request.applicantName}\'s leave request has been disapproved.');
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

  // Helper to get icon based on status for the leading icon
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'approved':
        return Icons.check_circle;
      case 'disapproved':
        return Icons.cancel;
      default:
        return Icons.pending_actions;
    }
  }

  // Helper to get color based on status for the leading icon
  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'disapproved':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Leave Requests'),
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
      body: _leaveRequests.isEmpty
          ? const Center(
              child: Text(
                'No pending leave requests found.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _leaveRequests.length,
              itemBuilder: (context, index) {
                final request = _leaveRequests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Icon(_getStatusIcon(request.status), color: _getStatusColor(request.status)),
                    title: Text(
                      request.applicantName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: request.status == 'disapproved' ? TextDecoration.lineThrough : TextDecoration.none,
                        color: request.status == 'disapproved' ? Colors.grey : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      request.requestDetails,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.check,
                            // Green if approved, grey otherwise
                            color: request.status == 'approved' ? Colors.green : Colors.grey,
                          ),
                          onPressed: request.status != 'approved' // Enable if not already approved
                              ? () => _approveRequest(request)
                              : null, // Disable if already approved
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            // Red if disapproved, grey otherwise
                            color: request.status == 'disapproved' ? Colors.red : Colors.grey,
                          ),
                          onPressed: request.status != 'disapproved' // Enable if not already disapproved
                              ? () => _disapproveRequest(request)
                              : null, // Disable if already disapproved
                        ),
                      ],
                    ),
                    onTap: () {
                      _showMessageBox(
                        context,
                        'Leave Request Details',
                        'Applicant: ${request.applicantName}\n'
                        'Details: ${request.applicantDetails}\n'
                        'Request: ${request.requestDetails}\n'
                        'Status: ${request.status.toUpperCase()}'
                        '${request.actionDateTime != null ? '\nAction Date: ${DateFormat('dd MMM yyyy hh:mm a').format(request.actionDateTime!)}' : ''}',
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

