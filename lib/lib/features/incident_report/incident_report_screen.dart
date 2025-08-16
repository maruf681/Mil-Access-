import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting

// Data model for an Incident Report
class IncidentReport {
  final String title;
  final String incidentDetails; // Detailed description of the incident
  final DateTime reportDateTime;
  final String reportedBy;

  IncidentReport({
    required this.title,
    required this.incidentDetails,
    required this.reportDateTime,
    required this.reportedBy,
  });
}

class IncidentReportScreen extends StatefulWidget {
  const IncidentReportScreen({super.key});

  @override
  State<IncidentReportScreen> createState() => _IncidentReportScreenState();
}

class _IncidentReportScreenState extends State<IncidentReportScreen> {
  // Sample data for incident reports
  final List<IncidentReport> _incidentReports = [
    IncidentReport(
      title: 'Minor Vehicle Accident',
      incidentDetails: 'A minor collision occurred involving Unit A\'s jeep and a civilian car near the main gate. No major injuries, minor vehicle damage. Police report filed.',
      reportDateTime: DateTime(2025, 7, 18, 09, 30),
      reportedBy: 'Sgt. Rahman',
    ),
    IncidentReport(
      title: 'Equipment Malfunction - Radio Set',
      incidentDetails: 'Alpha Company\'s primary radio set (Model X-500) experienced a critical malfunction during routine checks. Unable to transmit. Sent for repair.',
      reportDateTime: DateTime(2025, 7, 17, 14, 00),
      reportedBy: 'Lt. Karim',
    ),
    IncidentReport(
      title: 'Unauthorized Entry Attempt',
      incidentDetails: 'An unknown individual attempted to breach the perimeter fence near Sector 3 at approximately 02:15 AM. Security personnel apprehended the individual. Investigation ongoing.',
      reportDateTime: DateTime(2025, 7, 16, 03, 00),
      reportedBy: 'Cpl. Hasan',
    ),
    IncidentReport(
      title: 'Power Outage - Barrack 5',
      incidentDetails: 'A sudden power outage affected Barrack 5 for approximately 2 hours due to a fault in the local transformer. Power restored by unit electricians.',
      reportDateTime: DateTime(2025, 7, 15, 20, 45),
      reportedBy: 'WO. Jamal',
    ),
  ];

  void _viewIncidentDetails(IncidentReport report) {
    // Simulate opening a PDF for incident details
    _showMessageBox(
      context,
      'Incident Report Details (PDF View)',
      'Simulating PDF view for: "${report.title}"\n\n'
      'Reported by: ${report.reportedBy}\n'
      'Date/Time: ${DateFormat('dd MMM yyyy hh:mm a').format(report.reportDateTime)}\n\n'
      'Details:\n${report.incidentDetails}\n\n'
      '(In a real app, a PDF viewer would open here to display the full report.)',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Reports'),
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
      body: _incidentReports.isEmpty
          ? const Center(
              child: Text(
                'No incident reports found.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _incidentReports.length,
              itemBuilder: (context, index) {
                final report = _incidentReports[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.warning_amber, color: Colors.orange[700]),
                    title: Text(
                      report.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      'Reported by: ${report.reportedBy} on ${DateFormat('dd MMM yyyy').format(report.reportDateTime)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () {
                      _viewIncidentDetails(report);
                    },
                  ),
                );
              },
            ),
    );
  }
}

