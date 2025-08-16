import 'package:flutter/material.dart';

class ReportGenerationPage extends StatefulWidget {
  const ReportGenerationPage({super.key});

  @override
  ReportGenerationPageState createState() => ReportGenerationPageState();
}

class ReportGenerationPageState extends State<ReportGenerationPage> {
  String selectedReportType = 'Parade State Report';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // Additional controllers for specific report fields
  final TextEditingController unitController = TextEditingController();
  final TextEditingController commanderController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final List<String> reportTypes = [
    'Parade State Report',
    'Firing Report',
    'Medical Report',
    'Training Report',
    'Incident Report',
    'Equipment Status Report',
    'Duty Roster Report',
    'General Report',
  ];

  @override
  void initState() {
    super.initState();
    _updateReportTemplate();
  }

  void _updateReportTemplate() {
    setState(() {
      switch (selectedReportType) {
        case 'Parade State Report':
          titleController.text = 'Daily Parade State Report';
          contentController.text =
              '''UNIT: ${unitController.text}
DATE: ${dateController.text}
TIME: ${timeController.text}

STRENGTH:
- Officers Present: ___
- JCOs Present: ___
- ORs Present: ___
- Total Present: ___
- On Leave: ___
- Sick: ___
- Detachment: ___

REMARKS:
${contentController.text.isEmpty ? 'Enter additional remarks here...' : contentController.text}

SUBMITTED BY:
Name: ${commanderController.text}
Rank: ___
Signature: ___''';
          break;

        case 'Firing Report':
          titleController.text = 'Weapon Firing Report';
          contentController.text =
              '''UNIT: ${unitController.text}
DATE: ${dateController.text}
LOCATION: ${locationController.text}

FIRING DETAILS:
- Weapon Type: ___
- Ammunition Used: ___
- Rounds Fired: ___
- Target Distance: ___
- Weather Conditions: ___

PARTICIPANTS:
- Total Personnel: ___
- Qualified: ___
- Unqualified: ___

SAFETY MEASURES:
- Range Safety Officer: ___
- Medical Support: ___
- Ammunition Account: ___

REMARKS:
${contentController.text.isEmpty ? 'Enter firing results and observations...' : contentController.text}

SUBMITTED BY:
Name: ${commanderController.text}
Rank: ___
Signature: ___''';
          break;

        case 'Medical Report':
          titleController.text = 'Medical Status Report';
          contentController.text =
              '''UNIT: ${unitController.text}
DATE: ${dateController.text}
MEDICAL OFFICER: ${commanderController.text}

MEDICAL STATUS:
- Total Personnel: ___
- Fit for Duty: ___
- Sick in Quarter: ___
- Hospitalized: ___
- Medical Leave: ___

MEDICAL CASES:
- New Cases: ___
- Ongoing Treatment: ___
- RTU (Return to Unit): ___
- Referred to Hospital: ___

MEDICAL INSPECTIONS:
- Routine Check-ups: ___
- Vaccination Status: ___
- Health Education: ___

REMARKS:
${contentController.text.isEmpty ? 'Enter medical observations and recommendations...' : contentController.text}

SUBMITTED BY:
Medical Officer: ${commanderController.text}
Signature: ___''';
          break;

        case 'Training Report':
          titleController.text = 'Training Activity Report';
          contentController.text =
              '''UNIT: ${unitController.text}
DATE: ${dateController.text}
TRAINING LOCATION: ${locationController.text}

TRAINING DETAILS:
- Training Subject: ___
- Duration: ___
- Instructor: ___
- Participants: ___

TRAINING OBJECTIVES:
- Objective 1: ___
- Objective 2: ___
- Objective 3: ___

PERFORMANCE ASSESSMENT:
- Excellent: ___
- Good: ___
- Satisfactory: ___
- Needs Improvement: ___

RESOURCES UTILIZED:
- Equipment: ___
- Ammunition/Stores: ___
- Training Aids: ___

REMARKS:
${contentController.text.isEmpty ? 'Enter training outcomes and recommendations...' : contentController.text}

SUBMITTED BY:
Training Officer: ${commanderController.text}
Signature: ___''';
          break;

        case 'Incident Report':
          titleController.text = 'Incident Report';
          contentController.text =
              '''UNIT: ${unitController.text}
DATE: ${dateController.text}
TIME: ${timeController.text}
LOCATION: ${locationController.text}

INCIDENT DETAILS:
- Type of Incident: ___
- Personnel Involved: ___
- Witnesses: ___
- Injuries/Casualties: ___

SEQUENCE OF EVENTS:
${contentController.text.isEmpty ? 'Describe the incident chronologically...' : contentController.text}

IMMEDIATE ACTIONS TAKEN:
- First Aid/Medical: ___
- Security Measures: ___
- Notification: ___
- Investigation: ___

RECOMMENDATIONS:
- Preventive Measures: ___
- Policy Changes: ___
- Training Requirements: ___

SUBMITTED BY:
Investigating Officer: ${commanderController.text}
Signature: ___''';
          break;

        case 'Equipment Status Report':
          titleController.text = 'Equipment Status Report';
          contentController.text =
              '''UNIT: ${unitController.text}
DATE: ${dateController.text}
EQUIPMENT OFFICER: ${commanderController.text}

EQUIPMENT STATUS:
- Total Equipment: ___
- Serviceable: ___
- Unserviceable: ___
- Under Repair: ___
- Condemned: ___

MAJOR EQUIPMENT:
- Vehicles: ___
- Weapons: ___
- Communication Equipment: ___
- Medical Equipment: ___

MAINTENANCE STATUS:
- Daily Maintenance: ___
- Periodic Maintenance: ___
- Overdue Maintenance: ___

REQUIREMENTS:
- Spare Parts: ___
- Technical Support: ___
- Replacement Equipment: ___

REMARKS:
${contentController.text.isEmpty ? 'Enter equipment observations and requirements...' : contentController.text}

SUBMITTED BY:
Equipment Officer: ${commanderController.text}
Signature: ___''';
          break;

        case 'Duty Roster Report':
          titleController.text = 'Duty Roster Report';
          contentController.text =
              '''UNIT: ${unitController.text}
DATE: ${dateController.text}
DUTY OFFICER: ${commanderController.text}

DUTY ASSIGNMENTS:
- Guard Duty: ___
- Orderly Duty: ___
- Piquet Duty: ___
- Special Duty: ___

DUTY PERFORMANCE:
- All Duties Covered: ___
- Reliefs on Time: ___
- Equipment Checked: ___
- Log Maintained: ___

INCIDENTS DURING DUTY:
${contentController.text.isEmpty ? 'Report any incidents or observations during duty hours...' : contentController.text}

NEXT DAY PREPARATION:
- Duty Personnel Briefed: ___
- Equipment Ready: ___
- Special Instructions: ___

SUBMITTED BY:
Duty Officer: ${commanderController.text}
Signature: ___''';
          break;

        default:
          titleController.text = 'General Report';
          contentController.text = 'Enter your report content here...';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Generate Report'),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Type Selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedReportType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: reportTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedReportType = newValue!;
                        _updateReportTemplate();
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Unit Information
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unit Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: unitController,
                          decoration: InputDecoration(
                            labelText: 'Unit',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onChanged: (value) => _updateReportTemplate(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: commanderController,
                          decoration: InputDecoration(
                            labelText: 'Officer Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onChanged: (value) => _updateReportTemplate(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            dateController.text =
                                "${picked?.day}/${picked?.month}/${picked?.year}";
                            _updateReportTemplate();
                          },
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: timeController,
                          decoration: InputDecoration(
                            labelText: 'Time',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            suffixIcon: const Icon(Icons.access_time),
                          ),
                          onTap: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              timeController.text = picked.format(context);
                              _updateReportTemplate();
                            }
                          },
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  if (selectedReportType == 'Firing Report' ||
                      selectedReportType == 'Training Report' ||
                      selectedReportType == 'Incident Report') ...[
                    const SizedBox(height: 12),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onChanged: (value) => _updateReportTemplate(),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Report Title
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Report Content
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report Content',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: TextField(
                      controller: contentController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Save as draft logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Report saved as draft!'),
                          backgroundColor: Colors.grey[700],
                        ),
                      );
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Draft'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Submit report logic
                      if (titleController.text.isEmpty ||
                          contentController.text.isEmpty ||
                          unitController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Please fill in all required fields!',
                            ),
                            backgroundColor: Colors.red[600],
                          ),
                        );
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Report submitted successfully to higher command!',
                          ),
                          backgroundColor: Colors.green[800],
                        ),
                      );

                      // Clear form or navigate back
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Submit Report'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    unitController.dispose();
    commanderController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
