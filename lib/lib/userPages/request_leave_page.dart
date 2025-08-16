import 'package:flutter/material.dart';

class RequestLeavePage extends StatefulWidget {
  const RequestLeavePage({super.key});

  @override
  RequestLeavePageState createState() => RequestLeavePageState();
}

class RequestLeavePageState extends State<RequestLeavePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Form controllers
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _additionalNotesController =
      TextEditingController();

  // Form data
  String selectedLeaveType = 'Annual Leave';
  DateTime? startDate;
  DateTime? endDate;
  String selectedDuration = 'Full Day';
  String selectedPriority = 'Normal';
  bool isEmergencyLeave = false;

  // Sample data for existing requests
  List<LeaveRequest> leaveRequests = [
    LeaveRequest(
      id: '1',
      type: 'Annual Leave',
      startDate: DateTime.now().add(const Duration(days: 10)),
      endDate: DateTime.now().add(const Duration(days: 12)),
      reason: 'Family vacation',
      status: 'Pending',
      submittedDate: DateTime.now().subtract(const Duration(days: 2)),
      duration: 'Full Day',
      priority: 'Normal',
    ),
    LeaveRequest(
      id: '2',
      type: 'Sick Leave',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().subtract(const Duration(days: 3)),
      reason: 'Medical treatment',
      status: 'Approved',
      submittedDate: DateTime.now().subtract(const Duration(days: 7)),
      duration: 'Full Day',
      priority: 'High',
    ),
    LeaveRequest(
      id: '3',
      type: 'Emergency Leave',
      startDate: DateTime.now().subtract(const Duration(days: 15)),
      endDate: DateTime.now().subtract(const Duration(days: 14)),
      reason: 'Family emergency',
      status: 'Approved',
      submittedDate: DateTime.now().subtract(const Duration(days: 16)),
      duration: 'Full Day',
      priority: 'Urgent',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reasonController.dispose();
    _contactController.dispose();
    _emergencyContactController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Leave',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 170, 242, 153),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.green[800],
          tabs: const [
            Tab(icon: Icon(Icons.add_circle_outline), text: 'New Request'),
            Tab(icon: Icon(Icons.list_alt), text: 'My Requests'),
            Tab(icon: Icon(Icons.info_outline), text: 'Leave Balance'),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 170, 242, 153),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildNewRequestTab(),
            _buildMyRequestsTab(),
            _buildLeaveBalanceTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewRequestTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Leave Type Selection
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.green[800]),
                    const SizedBox(width: 8),
                    const Text(
                      'Quick Leave Types',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildQuickLeaveChip(
                      'Annual Leave',
                      Icons.beach_access,
                      Colors.blue,
                    ),
                    _buildQuickLeaveChip(
                      'Sick Leave',
                      Icons.local_hospital,
                      Colors.red,
                    ),
                    _buildQuickLeaveChip(
                      'Emergency Leave',
                      Icons.warning,
                      Colors.orange,
                    ),
                    _buildQuickLeaveChip(
                      'Maternity Leave',
                      Icons.child_care,
                      Colors.pink,
                    ),
                    _buildQuickLeaveChip(
                      'Training Leave',
                      Icons.school,
                      Colors.purple,
                    ),
                    _buildQuickLeaveChip(
                      'Other',
                      Icons.more_horiz,
                      Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Main Form
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leave Request Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 16),

                // Emergency Leave Toggle
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isEmergencyLeave ? Colors.red[50] : Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isEmergencyLeave ? Colors.red : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: isEmergencyLeave ? Colors.red : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Emergency Leave Request',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isEmergencyLeave
                                ? Colors.red[800]
                                : Colors.grey[700],
                          ),
                        ),
                      ),
                      Switch(
                        value: isEmergencyLeave,
                        onChanged: (value) {
                          setState(() {
                            isEmergencyLeave = value;
                            if (value) {
                              selectedLeaveType = 'Emergency Leave';
                              selectedPriority = 'Urgent';
                            }
                          });
                        },
                        activeColor: Colors.red,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Leave Type Dropdown
                DropdownButtonFormField<String>(
                  value: selectedLeaveType,
                  decoration: InputDecoration(
                    labelText: 'Leave Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.category),
                  ),
                  items:
                      [
                            'Annual Leave',
                            'Sick Leave',
                            'Emergency Leave',
                            'Maternity Leave',
                            'Paternity Leave',
                            'Training Leave',
                            'Compassionate Leave',
                            'Other',
                          ]
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLeaveType = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Date Selection
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectStartDate(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    startDate != null
                                        ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                                        : 'Select Date',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectEndDate(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    endDate != null
                                        ? '${endDate!.day}/${endDate!.month}/${endDate!.year}'
                                        : 'Select Date',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Duration and Priority
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedDuration,
                        decoration: InputDecoration(
                          labelText: 'Duration',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.access_time),
                        ),
                        items:
                            [
                                  'Full Day',
                                  'Half Day - Morning',
                                  'Half Day - Afternoon',
                                  'Custom Hours',
                                ]
                                .map(
                                  (duration) => DropdownMenuItem(
                                    value: duration,
                                    child: Text(duration),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDuration = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedPriority,
                        decoration: InputDecoration(
                          labelText: 'Priority',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.priority_high),
                        ),
                        items: ['Normal', 'High', 'Urgent']
                            .map(
                              (priority) => DropdownMenuItem(
                                value: priority,
                                child: Text(priority),
                              ),
                            )
                            .toList(),
                        onChanged: isEmergencyLeave
                            ? null
                            : (value) {
                                setState(() {
                                  selectedPriority = value!;
                                });
                              },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Reason
                TextField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    labelText: 'Reason for Leave',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.description),
                    hintText: 'Please provide a detailed reason...',
                  ),
                  maxLines: 3,
                ),

                const SizedBox(height: 16),

                // Contact Information
                TextField(
                  controller: _contactController,
                  decoration: InputDecoration(
                    labelText: 'Contact Number During Leave',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                    hintText: '+880XXXXXXXXX',
                  ),
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 16),

                // Emergency Contact (if emergency leave)
                if (isEmergencyLeave)
                  Column(
                    children: [
                      TextField(
                        controller: _emergencyContactController,
                        decoration: InputDecoration(
                          labelText: 'Emergency Contact Person',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.contact_emergency),
                          hintText: 'Name and contact details',
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                // Additional Notes
                TextField(
                  controller: _additionalNotesController,
                  decoration: InputDecoration(
                    labelText: 'Additional Notes (Optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.note),
                    hintText: 'Any additional information...',
                  ),
                  maxLines: 2,
                ),

                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitLeaveRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEmergencyLeave
                          ? Colors.red[600]
                          : Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isEmergencyLeave ? Icons.emergency : Icons.send,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isEmergencyLeave
                              ? 'Submit Emergency Request'
                              : 'Submit Leave Request',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLeaveChip(String type, IconData icon, Color color) {
    bool isSelected = selectedLeaveType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLeaveType = type;
          if (type == 'Emergency Leave') {
            isEmergencyLeave = true;
            selectedPriority = 'Urgent';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isSelected ? color : Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              type,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? color : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyRequestsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary Cards
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                'Pending',
                leaveRequests
                    .where((r) => r.status == 'Pending')
                    .length
                    .toString(),
                Icons.pending_actions,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                'Approved',
                leaveRequests
                    .where((r) => r.status == 'Approved')
                    .length
                    .toString(),
                Icons.check_circle,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                'Rejected',
                leaveRequests
                    .where((r) => r.status == 'Rejected')
                    .length
                    .toString(),
                Icons.cancel,
                Colors.red,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Requests List
        ...leaveRequests.map((request) => _buildRequestCard(request)).toList(),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String count,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildRequestCard(LeaveRequest request) {
    Color statusColor = _getStatusColor(request.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: statusColor, width: 4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      request.type,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      request.status,
                      style: TextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                request.reason,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${_formatDate(request.startDate)} - ${_formatDate(request.endDate)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const Spacer(),
                  Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    _calculateDays(request.startDate, request.endDate),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Submitted: ${_formatDate(request.submittedDate)}',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                  const Spacer(),
                  if (request.status == 'Pending')
                    TextButton(
                      onPressed: () => _showCancelDialog(request),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveBalanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Leave Balance Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Annual Leave Balance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBalanceItem('Total', '30', Colors.blue),
                    Container(width: 1, height: 40, color: Colors.grey[300]),
                    _buildBalanceItem('Used', '8', Colors.red),
                    Container(width: 1, height: 40, color: Colors.grey[300]),
                    _buildBalanceItem('Remaining', '22', Colors.green),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Leave Types Breakdown
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Leave Types & Entitlements',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildLeaveTypeItem('Annual Leave', '22', '30', Colors.blue),
                _buildLeaveTypeItem('Sick Leave', '12', '15', Colors.red),
                _buildLeaveTypeItem('Emergency Leave', '3', '5', Colors.orange),
                _buildLeaveTypeItem('Training Leave', '5', '10', Colors.purple),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Leave Policy Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue[800]),
                    const SizedBox(width: 8),
                    Text(
                      'Leave Policy Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildPolicyItem(
                  '• Annual leave must be applied 7 days in advance',
                ),
                _buildPolicyItem(
                  '• Emergency leave can be applied retrospectively',
                ),
                _buildPolicyItem(
                  '• Medical certificates required for sick leave > 3 days',
                ),
                _buildPolicyItem(
                  '• Leave balance resets annually on January 1st',
                ),
                _buildPolicyItem(
                  '• Maximum 15 consecutive days without special approval',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildLeaveTypeItem(
    String type,
    String remaining,
    String total,
    Color color,
  ) {
    double percentage = double.parse(remaining) / double.parse(total);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                '$remaining/$total days',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.blue[700]),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        if (endDate != null && endDate!.isBefore(picked)) {
          endDate = null;
        }
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    if (startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select start date first'),
          backgroundColor: Colors.red[800],
        ),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? startDate!.add(const Duration(days: 1)),
      firstDate: startDate!,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  void _submitLeaveRequest() {
    if (_validateForm()) {
      setState(() {
        leaveRequests.add(
          LeaveRequest(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            type: selectedLeaveType,
            startDate: startDate!,
            endDate: endDate!,
            reason: _reasonController.text,
            status: 'Pending',
            submittedDate: DateTime.now(),
            duration: selectedDuration,
            priority: selectedPriority,
          ),
        );
      });

      // Clear form
      _clearForm();

      // Show success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                isEmergencyLeave ? Icons.emergency : Icons.check_circle,
                color: isEmergencyLeave ? Colors.red : Colors.green,
              ),
              const SizedBox(width: 8),
              const Text('Request Submitted'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEmergencyLeave
                    ? 'Your emergency leave request has been submitted and will be processed immediately.'
                    : 'Your leave request has been submitted successfully and is pending approval.',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request Summary:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text('Type: $selectedLeaveType'),
                    Text('Duration: ${_calculateDays(startDate!, endDate!)}'),
                    Text('Priority: $selectedPriority'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _tabController.animateTo(1); // Switch to My Requests tab
              },
              child: const Text('View Requests'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  bool _validateForm() {
    if (startDate == null) {
      _showErrorMessage('Please select start date');
      return false;
    }
    if (endDate == null) {
      _showErrorMessage('Please select end date');
      return false;
    }
    if (_reasonController.text.trim().isEmpty) {
      _showErrorMessage('Please provide reason for leave');
      return false;
    }
    if (_contactController.text.trim().isEmpty) {
      _showErrorMessage('Please provide contact number');
      return false;
    }
    if (isEmergencyLeave && _emergencyContactController.text.trim().isEmpty) {
      _showErrorMessage('Please provide emergency contact for emergency leave');
      return false;
    }
    return true;
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red[800],
      ),
    );
  }

  void _clearForm() {
    setState(() {
      selectedLeaveType = 'Annual Leave';
      startDate = null;
      endDate = null;
      selectedDuration = 'Full Day';
      selectedPriority = 'Normal';
      isEmergencyLeave = false;
    });
    _reasonController.clear();
    _contactController.clear();
    _emergencyContactController.clear();
    _additionalNotesController.clear();
  }

  void _showCancelDialog(LeaveRequest request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.cancel, color: Colors.red),
            SizedBox(width: 8),
            Text('Cancel Request'),
          ],
        ),
        content: const Text('Are you sure you want to cancel this leave request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                leaveRequests.removeWhere((r) => r.id == request.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Leave request cancelled successfully'),
                  backgroundColor: Colors.green[800],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _calculateDays(DateTime start, DateTime end) {
    int days = end.difference(start).inDays + 1;
    return days == 1 ? '1 day' : '$days days';
  }
}

class LeaveRequest {
  final String id;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String status;
  final DateTime submittedDate;
  final String duration;
  final String priority;

  LeaveRequest({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.submittedDate,
    required this.duration,
    required this.priority,
  });
}
