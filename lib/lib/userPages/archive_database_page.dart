import 'package:flutter/material.dart';

class ArchiveDatabasePage extends StatefulWidget {
  const ArchiveDatabasePage({super.key});

  @override
  ArchiveDatabasePageState createState() => ArchiveDatabasePageState();
}

class ArchiveDatabasePageState extends State<ArchiveDatabasePage> {
  String selectedCategory = 'All';
  String searchQuery = '';

  final List<String> categories = [
    'All',
    'Personnel Records',
    'Training Certificates',
    'Mission Reports',
    'Equipment Manuals',
    'Policy Documents',
    'Medical Records',
    'IPFT Documents',
    'Firing Results',
  ];

  List<Map<String, dynamic>> documents = [
    {
      'title': 'Annual Training Certificate',
      'category': 'Training Certificates',
      'date': '2024-12-15',
      'size': '2.3 MB',
      'type': 'PDF',
      'isImportant': true,
      'content':
          'ANNUAL TRAINING CERTIFICATE\n\nThis is to certify that the personnel has successfully completed the annual training program as required by military standards.\n\nTraining Details:\n- Physical Fitness Training\n- Weapons Handling\n- Safety Protocols\n- Emergency Procedures\n\nCompleted on: December 15, 2024\nValid until: December 15, 2025\n\nAuthorized by: Training Command',
    },
    {
      'title': 'Mission Report - Operation Alpha',
      'category': 'Mission Reports',
      'date': '2024-12-10',
      'size': '1.8 MB',
      'type': 'DOC',
      'isImportant': true,
      'content':
          'MISSION REPORT - OPERATION ALPHA\n\nMission Date: December 10, 2024\nObjective: Reconnaissance and Intelligence Gathering\nStatus: COMPLETED\n\nMission Summary:\nThe operation was executed successfully with all objectives met. Personnel demonstrated excellent coordination and tactical awareness.\n\nKey Findings:\n- Area secured without incident\n- Intelligence gathered as per mission requirements\n- All personnel returned safely\n\nRecommendations:\nContinue current training protocols and maintain readiness levels.',
    },
    {
      'title': 'Personnel File - John Doe',
      'category': 'Personnel Records',
      'date': '2024-12-08',
      'size': '854 KB',
      'type': 'PDF',
      'isImportant': false,
      'content':
          'PERSONNEL FILE\n\nName: John Doe\nRank: Sergeant\nService Number: 12345678\nUnit: Alpha Company\n\nPersonal Information:\n- Date of Birth: January 15, 1990\n- Place of Birth: New York, USA\n- Emergency Contact: Jane Doe (Spouse)\n\nService Record:\n- Enlisted: 2010\n- Current Rank Since: 2020\n- Commendations: 3\n- Disciplinary Actions: None\n\nMedical Status: Fit for Duty\nSecurity Clearance: Secret',
    },
    {
      'title': 'Equipment Manual - Radio System',
      'category': 'Equipment Manuals',
      'date': '2024-12-05',
      'size': '5.2 MB',
      'type': 'PDF',
      'isImportant': false,
      'content':
          'EQUIPMENT MANUAL - RADIO COMMUNICATION SYSTEM\n\nModel: MIL-RADIO-2024\nManufacturer: Defense Communications Inc.\n\nOperating Instructions:\n1. Power on the device using the main switch\n2. Select appropriate frequency channel\n3. Adjust volume and clarity controls\n4. Test communication with base station\n\nMaintenance Schedule:\n- Daily: Battery check and antenna inspection\n- Weekly: Full system diagnostic\n- Monthly: Professional calibration\n\nTroubleshooting:\n- No signal: Check antenna connections\n- Poor audio: Clean microphone and speakers\n- Battery issues: Replace with authorized batteries only',
    },
    {
      'title': 'Safety Policy Update',
      'category': 'Policy Documents',
      'date': '2024-12-01',
      'size': '1.1 MB',
      'type': 'PDF',
      'isImportant': true,
      'content':
          'SAFETY POLICY UPDATE - DECEMBER 2024\n\nEffective Date: December 1, 2024\n\nNew Safety Protocols:\n1. Enhanced protective equipment requirements\n2. Updated emergency evacuation procedures\n3. Revised chemical handling guidelines\n\nKey Changes:\n- Mandatory safety briefings increased to weekly\n- New incident reporting system implemented\n- Additional safety officer assignments\n\nCompliance:\nAll personnel must acknowledge receipt and understanding of these updated policies within 30 days.\n\nFor questions, contact Safety Department at ext. 2456.',
    },
    {
      'title': 'Medical Clearance Form',
      'category': 'Medical Records',
      'date': '2024-11-28',
      'size': '456 KB',
      'type': 'PDF',
      'isImportant': false,
      'content':
          'MEDICAL CLEARANCE FORM\n\nPatient: [Name Redacted for Privacy]\nDate of Examination: November 28, 2024\nExamining Physician: Dr. Smith, MD\n\nMedical Assessment:\n- Physical Condition: Excellent\n- Mental Health: Stable\n- Vision: 20/20 (corrected)\n- Hearing: Normal range\n\nClearance Status: APPROVED\nValid for: All duty assignments\nRestrictions: None\nNext Examination Due: November 28, 2025\n\nPhysician Signature: Dr. Smith, MD\nMedical Officer Approval: Col. Johnson',
    },
    {
      'title': 'IPFT Scorecard - Q4 2024',
      'category': 'IPFT Documents',
      'date': '2024-12-20',
      'size': '324 KB',
      'type': 'PDF',
      'isImportant': true,
      'content':
          'INDIVIDUAL PHYSICAL FITNESS TEST (IPFT)\nQ4 2024 SCORECARD\n\nTest Date: December 20, 2024\nWeather Conditions: Clear, 72°F\n\nTest Results:\n1. Push-ups (2 min): 65 reps - EXCELLENT\n2. Sit-ups (2 min): 70 reps - EXCELLENT  \n3. 2-mile run: 13:45 - GOOD\n\nOverall Score: 285/300 - PASS\nFitness Category: EXCELLENT\n\nRecommendations:\n- Continue current fitness routine\n- Focus on cardiovascular endurance\n- Schedule next test: March 2025\n\nTesting Officer: SSG Martinez\nUnit: Bravo Company',
    },
    {
      'title': 'Physical Fitness Standards',
      'category': 'IPFT Documents',
      'date': '2024-12-18',
      'size': '1.2 MB',
      'type': 'PDF',
      'isImportant': false,
      'content':
          'PHYSICAL FITNESS STANDARDS\nUpdated December 2024\n\nAge Group Standards (20-29 years):\n\nMINIMUM REQUIREMENTS:\n- Push-ups: 42 reps (2 min)\n- Sit-ups: 53 reps (2 min)\n- 2-mile run: 15:54\n\nEXCELLENT STANDARDS:\n- Push-ups: 71+ reps\n- Sit-ups: 78+ reps  \n- 2-mile run: 13:00 or better\n\nScoring System:\n- 300 points maximum\n- 180 points minimum to pass\n- Each event worth 100 points\n\nTest Frequency:\n- Active duty: Semi-annually\n- Reserve: Annually\n\nFailure Consequences:\n- Remedial PT program\n- Retest within 90 days',
    },
    {
      'title': 'Rifle Qualification - December 2024',
      'category': 'Firing Results',
      'date': '2024-12-22',
      'size': '892 KB',
      'type': 'PDF',
      'isImportant': true,
      'content':
          'RIFLE QUALIFICATION RECORD\nDecember 2024\n\nWeapon: M4 Carbine\nAmmunition: 5.56mm NATO\nRange: 25m Zeroing, 300m Qualification\nDate: December 22, 2024\n\nScoring Results:\n300m Targets:\n- Prone Supported: 8/10 hits\n- Prone Unsupported: 7/10 hits  \n- Kneeling: 6/10 hits\n- Standing: 7/10 hits\n\nTotal Score: 28/40\nQualification Level: SHARPSHOOTER\n\nRange Safety Officer: MSG Johnson\nScorer: CPL Williams\nWeather: Clear, light wind\n\nNext Qualification Due: June 2025',
    },
    {
      'title': 'Pistol Range Results',
      'category': 'Firing Results',
      'date': '2024-12-19',
      'size': '654 KB',
      'type': 'PDF',
      'isImportant': false,
      'content':
          'PISTOL QUALIFICATION RECORD\nDecember 2024\n\nWeapon: M9 Beretta\nAmmunition: 9mm Parabellum\nRange Distance: 25m\nDate: December 19, 2024\n\nFiring Positions:\n- Standing (7m): 6/6 hits\n- Standing (15m): 5/6 hits\n- Standing (25m): 4/6 hits\n- Kneeling (25m): 5/6 hits\n\nTotal Score: 20/24\nQualification Level: EXPERT\n\nRange Master: SFC Davis\nAmmo Expended: 30 rounds\nMalfunctions: None\n\nRemarks: Excellent accuracy and weapon handling\nNext Qualification: December 2025',
    },
  ];

  // Controllers for add document dialog
  final TextEditingController _titleController = TextEditingController();
  String? _selectedCategoryForAdd;

  List<Map<String, dynamic>> get filteredDocuments {
    return documents.where((doc) {
      final matchesCategory =
          selectedCategory == 'All' || doc['category'] == selectedCategory;
      final matchesSearch = doc['title'].toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Archive Database',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green[800],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showAddDocumentDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search documents...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.green),
                  ),
                ),
              ),
            ),

            // Category Filter
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.green[800],
                      backgroundColor: Colors.white,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Documents List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  final document = filteredDocuments[index];
                  return _buildDocumentCard(document);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDocumentDialog(context);
        },
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    IconData typeIcon;
    Color typeColor;

    switch (document['type']) {
      case 'PDF':
        typeIcon = Icons.picture_as_pdf;
        typeColor = Colors.red;
        break;
      case 'DOC':
        typeIcon = Icons.description;
        typeColor = Colors.blue;
        break;
      default:
        typeIcon = Icons.insert_drive_file;
        typeColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          _showDocumentDetails(document);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // File Type Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(typeIcon, color: typeColor, size: 30),
              ),

              const SizedBox(width: 16),

              // Document Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            document['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (document['isImportant'])
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      document['category'],
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          document['date'],
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.folder, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          document['size'],
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view',
                    child: Row(
                      children: [
                        Icon(Icons.visibility, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('View'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'download',
                    child: Row(
                      children: [
                        Icon(Icons.download, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Download'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'share',
                    child: Row(
                      children: [
                        Icon(Icons.share, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Share'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  _handleMenuAction(value.toString(), document);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDocumentDetails(Map<String, dynamic> document) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(document['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Category', document['category']),
            _buildDetailRow('Date', document['date']),
            _buildDetailRow('Size', document['size']),
            _buildDetailRow('Type', document['type']),
            _buildDetailRow(
              'Important',
              document['isImportant'] ? 'Yes' : 'No',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Show document content
              _showDocumentContent(document);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }

  // NEW METHOD: Show document content when "Open" is clicked
  void _showDocumentContent(Map<String, dynamic> document) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    document['type'] == 'PDF'
                        ? Icons.picture_as_pdf
                        : Icons.description,
                    color: document['type'] == 'PDF' ? Colors.red : Colors.blue,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      document['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              // Document content
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      document['content'] ??
                          'No content available for this document.',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Downloading ${document['title']}'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Printing ${document['title']}'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.print),
                    label: const Text('Print'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showAddDocumentDialog(BuildContext context) {
    // Reset form
    _titleController.clear();
    _selectedCategoryForAdd = null;

    // Additional controllers for new fields
    final TextEditingController descriptionController =
        TextEditingController();
    final TextEditingController authorController = TextEditingController();
    final TextEditingController versionController = TextEditingController();
    String? selectedFileType = 'PDF';
    String? selectedClassification = 'Unclassified';
    bool isImportant = false;

    final List<String> fileTypes = [
      'PDF',
      'DOC',
      'DOCX',
      'XLS',
      'XLSX',
      'TXT',
      'JPG',
      'PNG',
    ];
    final List<String> classifications = [
      'Unclassified',
      'Confidential',
      'Secret',
      'Top Secret',
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.add_circle_outline, color: Colors.green[800]),
              const SizedBox(width: 8),
              const Text('Add New Document'),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Document Title
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Document Title *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Category *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category),
                    ),
                    value: _selectedCategoryForAdd,
                    items: categories.skip(1).map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setDialogState(() {
                        _selectedCategoryForAdd = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Description
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                      hintText: 'Brief description of the document...',
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Author and Version Row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: authorController,
                          decoration: const InputDecoration(
                            labelText: 'Author/Creator',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: versionController,
                          decoration: const InputDecoration(
                            labelText: 'Version',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.layers),
                            hintText: 'v1.0',
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // File Type and Classification Row
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'File Type',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.insert_drive_file),
                          ),
                          value: selectedFileType,
                          items: fileTypes.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Row(
                                children: [
                                  Icon(
                                    type == 'PDF'
                                        ? Icons.picture_as_pdf
                                        : type.startsWith('DOC')
                                        ? Icons.description
                                        : type.startsWith('XLS')
                                        ? Icons.table_chart
                                        : type == 'TXT'
                                        ? Icons.text_snippet
                                        : Icons.image,
                                    size: 16,
                                    color: type == 'PDF'
                                        ? Colors.red
                                        : type.startsWith('DOC')
                                        ? Colors.blue
                                        : type.startsWith('XLS')
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(type),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedFileType = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Classification',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.security),
                          ),
                          value: selectedClassification,
                          items: classifications.map((classification) {
                            return DropdownMenuItem(
                              value: classification,
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: classification == 'Unclassified'
                                          ? Colors.green
                                          : classification == 'Confidential'
                                          ? Colors.yellow
                                          : classification == 'Secret'
                                          ? Colors.orange
                                          : Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(classification),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedClassification = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // File Upload Simulation
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Simulate file picker
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('File picker would open here'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload,
                            color: Colors.green[800],
                            size: 24,
                          ),
                          Text(
                            'Click to upload file or drag & drop',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Important Document Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isImportant,
                        onChanged: (value) {
                          setDialogState(() {
                            isImportant = value ?? false;
                          });
                        },
                        activeColor: Colors.green[800],
                      ),
                      const Text('Mark as Important Document'),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Required fields note
                  Text(
                    '* Required fields',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Dispose controllers
                descriptionController.dispose();
                authorController.dispose();
                versionController.dispose();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _selectedCategoryForAdd != null) {
                  // Add new document to the list with enhanced data
                  setState(() {
                    documents.insert(0, {
                      'title': _titleController.text,
                      'category': _selectedCategoryForAdd!,
                      'date': DateTime.now().toString().substring(0, 10),
                      'size':
                          '${(1 + (documents.length * 0.3)).toStringAsFixed(1)} MB',
                      'type': selectedFileType ?? 'PDF',
                      'isImportant': isImportant,
                      'author': authorController.text.isNotEmpty
                          ? authorController.text
                          : 'Unknown',
                      'version': versionController.text.isNotEmpty
                          ? versionController.text
                          : 'v1.0',
                      'description': descriptionController.text.isNotEmpty
                          ? descriptionController.text
                          : 'No description available',
                      'classification':
                          selectedClassification ?? 'Unclassified',
                      'content':
                          'DOCUMENT: ${_titleController.text}\n\n'
                          'CATEGORY: $_selectedCategoryForAdd\n'
                          'AUTHOR: ${authorController.text.isNotEmpty ? authorController.text : 'Unknown'}\n'
                          'VERSION: ${versionController.text.isNotEmpty ? versionController.text : 'v1.0'}\n'
                          'CLASSIFICATION: ${selectedClassification ?? 'Unclassified'}\n'
                          'DATE CREATED: ${DateTime.now().toString().substring(0, 10)}\n\n'
                          'DESCRIPTION:\n${descriptionController.text.isNotEmpty ? descriptionController.text : 'No description available'}\n\n'
                          'This document was added through the MILBOT Archive Database system.\n'
                          'Document content will be populated when the actual file is processed and indexed.\n\n'
                          'For more information about this document, please contact the document author or your system administrator.',
                    });
                  });

                  // Dispose controllers
                  descriptionController.dispose();
                  authorController.dispose();
                  versionController.dispose();

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Document "${_titleController.text}" added successfully',
                      ),
                      backgroundColor: Colors.green[800],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all required fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 16),
                  SizedBox(width: 4),
                  Text('Add Document'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(String action, Map<String, dynamic> document) {
    switch (action) {
      case 'view':
        // View document content
        _showDocumentContent(document);
        break;
      case 'download':
        // Download document logic
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Downloading ${document['title']}')),
        );
        break;
      case 'share':
        // Share document logic
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sharing ${document['title']}')));
        break;
      case 'delete':
        // Delete document logic
        _showDeleteConfirmation(document);
        break;
    }
  }

  void _showDeleteConfirmation(Map<String, dynamic> document) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: Text(
          'Are you sure you want to delete "${document['title']}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                documents.remove(document);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${document['title']} deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
