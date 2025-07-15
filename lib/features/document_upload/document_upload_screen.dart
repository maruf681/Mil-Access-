import 'package:flutter/material.dart';

// Define a class for individual document items
class DocumentItem {
  final String title;
  String status; // 'pending', 'forwarded', 'rejected'

  DocumentItem({required this.title, this.status = 'pending'});
}

// Define a class for document categories
class DocumentCategory {
  final String title;
  final List<DocumentItem> documents;

  DocumentCategory({required this.title, required this.documents});
}

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  // Sample data for document categories and documents
  final List<DocumentCategory> _documentCategories = [
    DocumentCategory(
      title: '1. Establishment and HR related',
      documents: [
        DocumentItem(title: 'Establishment proposals (e.g. increase/decrease of manpower)'),
        DocumentItem(title: 'Manning state adjustments'),
        DocumentItem(title: 'Proposals for creating new appointments/posts'),
        DocumentItem(title: 'Nominal rolls for specific selections'),
      ],
    ),
    DocumentCategory(
      title: '2. Financial and procurement',
      documents: [
        DocumentItem(title: 'Procurement proposals exceeding unit’s financial power (Local Purchase above delegated limits)'),
        DocumentItem(title: 'Annual procurement plan approvals'),
        DocumentItem(title: 'Major repair/overhaul proposals for vehicles or equipment'),
        DocumentItem(title: 'Bills requiring AHQ budget allocation or special sanction'),
      ],
    ),
    DocumentCategory(
      title: '3. Infrastructure and construction',
      documents: [
        DocumentItem(title: 'Construction or modification of permanent structures'),
        DocumentItem(title: 'Major maintenance proposals exceeding station HQ financial limits'),
        DocumentItem(title: 'Land acquisition or allotment related proposals'),
      ],
    ),
    DocumentCategory(
      title: '4. Training and operational plans',
      documents: [
        DocumentItem(title: 'Training exercise proposals involving multiple formations or strategic assets'),
        DocumentItem(title: 'Live firing exercises requiring AHQ clearance'),
        DocumentItem(title: 'Deployment proposals beyond unit operational area'),
      ],
    ),
    DocumentCategory(
      title: '5. Welfare and ceremonial',
      documents: [
        DocumentItem(title: 'Major welfare project proposals (new unit canteen, mess extension, recreational facility)'),
        DocumentItem(title: 'Approval for significant ceremonial events involving external agencies or national protocol'),
      ],
    ),
    DocumentCategory(
      title: '6. Discipline and legal',
      documents: [
        DocumentItem(title: 'Court martial proceedings requiring AHQ legal vetting or sanction'),
        DocumentItem(title: 'Serious disciplinary cases forwarded to AHQ for decision'),
      ],
    ),
    DocumentCategory(
      title: '7. Intelligence and security',
      documents: [
        DocumentItem(title: 'Intelligence summaries or threat reports that require upward dissemination'),
        DocumentItem(title: 'Security classification change proposals for unit premises or documents'),
      ],
    ),
  ];

  void _forwardDocument(DocumentItem document) {
    setState(() {
      document.status = 'forwarded';
    });
    _showMessageBox(context, 'Document Forwarded', '${document.title} has been forwarded.');
  }

  void _rejectDocument(DocumentItem document) {
    setState(() {
      document.status = 'rejected';
    });
    _showMessageBox(context, 'Document Rejected', '${document.title} has been rejected.');
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
      case 'forwarded':
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
      case 'forwarded':
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
        title: const Text('Document Upload Requests'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _documentCategories.length,
        itemBuilder: (context, categoryIndex) {
          final category = _documentCategories[categoryIndex];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(height: 20, thickness: 1),
                  ListView.builder(
                    shrinkWrap: true, // Important for nested ListView
                    physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                    itemCount: category.documents.length,
                    itemBuilder: (context, documentIndex) {
                      final document = category.documents[documentIndex];
                      return ListTile(
                        leading: Icon(_getStatusIcon(document.status), color: _getStatusColor(document.status)),
                        title: Text(
                          document.title,
                          style: TextStyle(
                            decoration: document.status == 'rejected' ? TextDecoration.lineThrough : TextDecoration.none,
                            color: document.status == 'rejected' ? Colors.grey : Colors.black,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check_circle, color: document.status == 'forwarded' ? Colors.green : Colors.grey),
                              onPressed: document.status == 'pending'
                                  ? () => _forwardDocument(document)
                                  : null, // Disable if already acted upon
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel, color: document.status == 'rejected' ? Colors.red : Colors.grey),
                              onPressed: document.status == 'pending'
                                  ? () => _rejectDocument(document)
                                  : null, // Disable if already acted upon
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

