import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/common_widgets.dart';
//import '../widgets/common_widgets.dart';

class PendingRequestPage extends StatefulWidget {
  const PendingRequestPage({super.key});

  @override
  State<PendingRequestPage> createState() => _PendingRequestPageState();
}

class _PendingRequestPageState extends State<PendingRequestPage> {
  List<PendingRequest> requests = [
    const PendingRequest(
      id: "1",
      title: "CO 2 SIG BN",
      requestType: "Leave Request",
      status: "Urgent",
      submittedDate: "2024-01-15",
      daysPending: 5,
      description: "Emergency leave for family medical issue",
    ),
    const PendingRequest(
      id: "2",
      title: "CO 27 EB",
      requestType: "Equipment Requisition",
      status: "Pending",
      submittedDate: "2024-01-18",
      daysPending: 2,
      description: "Request for new communication equipment",
    ),
    const PendingRequest(
      id: "3",
      title: "9 Bengal Lancers",
      requestType: "Training Approval",
      status: "Under Review",
      submittedDate: "2024-01-16",
      daysPending: 4,
      description: "Advanced tactical training program approval",
    ),
    const PendingRequest(
      id: "4",
      title: "2 Engrs",
      requestType: "Transfer Request",
      status: "Pending",
      submittedDate: "2024-01-19",
      daysPending: 1,
      description: "Transfer to engineering division",
    ),
    const PendingRequest(
      id: "5",
      title: "Maj Hasan",
      requestType: "Medical Request",
      status: "Urgent",
      submittedDate: "2024-01-14",
      daysPending: 6,
      description: "Medical examination approval required",
    ),
    const PendingRequest(
      id: "6",
      title: "Capt Riasat",
      requestType: "Leave Request",
      status: "Under Review",
      submittedDate: "2024-01-17",
      daysPending: 3,
      description: "Annual leave request for 15 days",
    ),
  ];

  String selectedFilter = "All";
  String selectedSort = "Date";

  List<PendingRequest> get filteredRequests {
    List<PendingRequest> filtered = requests;

    // Apply filter
    if (selectedFilter != "All") {
      if (selectedFilter == "Leave Request" ||
          selectedFilter == "Equipment Requisition" ||
          selectedFilter == "Training Approval" ||
          selectedFilter == "Transfer Request" ||
          selectedFilter == "Medical Request") {
        filtered = filtered
            .where((req) => req.requestType == selectedFilter)
            .toList();
      } else {
        filtered = filtered
            .where((req) => req.status == selectedFilter)
            .toList();
      }
    }

    // Apply sorting
    switch (selectedSort) {
      case "Date":
        filtered.sort((a, b) => b.daysPending.compareTo(a.daysPending));
        break;
      case "Status":
        filtered.sort((a, b) => a.status.compareTo(b.status));
        break;
      case "Type":
        filtered.sort((a, b) => a.requestType.compareTo(b.requestType));
        break;
      case "Name":
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
    }

    return filtered;
  }

  void _approveRequest(String requestId) {
    setState(() {
      requests.removeWhere((req) => req.id == requestId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Request approved successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _rejectRequest(String requestId) {
    setState(() {
      requests.removeWhere((req) => req.id == requestId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Request rejected'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _changePriority(String requestId, String newStatus) {
    setState(() {
      int index = requests.indexWhere((req) => req.id == requestId);
      if (index != -1) {
        requests[index] = PendingRequest(
          id: requests[index].id,
          title: requests[index].title,
          requestType: requests[index].requestType,
          status: newStatus,
          submittedDate: requests[index].submittedDate,
          daysPending: requests[index].daysPending,
          description: requests[index].description,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Priority changed to $newStatus'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pending Requests")),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SearchBarWidget(),
                const SizedBox(height: 16),
                // Filter and Sort Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: selectedFilter,
                          isExpanded: true,
                          underline: const SizedBox(),
                          hint: const Text("Filter by"),
                          items:
                              [
                                "All",
                                "Urgent",
                                "Pending",
                                "Under Review",
                                "Leave Request",
                                "Equipment Requisition",
                                "Training Approval",
                                "Transfer Request",
                                "Medical Request",
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedFilter = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: selectedSort,
                          isExpanded: true,
                          underline: const SizedBox(),
                          hint: const Text("Sort by"),
                          items: ["Date", "Status", "Type", "Name"].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSort = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${filteredRequests.length} requests found",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Requests List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredRequests.length,
              itemBuilder: (context, index) {
                return EnhancedRequestCard(
                  request: filteredRequests[index],
                  onApprove: () => _approveRequest(filteredRequests[index].id),
                  onReject: () => _rejectRequest(filteredRequests[index].id),
                  onChangePriority: (newStatus) =>
                      _changePriority(filteredRequests[index].id, newStatus),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PendingRequest {
  final String id;
  final String title;
  final String requestType;
  final String status;
  final String submittedDate;
  final int daysPending;
  final String description;

  const PendingRequest({
    required this.id,
    required this.title,
    required this.requestType,
    required this.status,
    required this.submittedDate,
    required this.daysPending,
    required this.description,
  });
}

class EnhancedRequestCard extends StatelessWidget {
  final PendingRequest request;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final Function(String) onChangePriority;

  const EnhancedRequestCard({
    required this.request,
    required this.onApprove,
    required this.onReject,
    required this.onChangePriority,
    super.key,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Urgent':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      case 'Under Review':
        return Colors.yellow[700]!;
      default:
        return Colors.grey;
    }
  }

  IconData _getRequestTypeIcon(String requestType) {
    switch (requestType) {
      case 'Leave Request':
        return Icons.exit_to_app;
      case 'Equipment Requisition':
        return Icons.build;
      case 'Training Approval':
        return Icons.school;
      case 'Transfer Request':
        return Icons.swap_horiz;
      case 'Medical Request':
        return Icons.local_hospital;
      default:
        return Icons.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getRequestTypeIcon(request.requestType),
            color: Colors.green[800],
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                request.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () => _showPriorityDialog(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(request.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      request.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.edit, color: Colors.white, size: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              request.requestType,
              style: TextStyle(
                color: Colors.green[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Submitted: ${request.submittedDate}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${request.daysPending} days pending',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  request.description,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onApprove,
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: const Text('Approve'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onReject,
                        icon: const Icon(Icons.close, color: Colors.white),
                        label: const Text('Reject'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPriorityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Priority'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                title: const Text('Urgent'),
                onTap: () {
                  Navigator.of(context).pop();
                  onChangePriority('Urgent');
                },
              ),
              ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                title: const Text('Pending'),
                onTap: () {
                  Navigator.of(context).pop();
                  onChangePriority('Pending');
                },
              ),
              ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    shape: BoxShape.circle,
                  ),
                ),
                title: const Text('Under Review'),
                onTap: () {
                  Navigator.of(context).pop();
                  onChangePriority('Under Review');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
