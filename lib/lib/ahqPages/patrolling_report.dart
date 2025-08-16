import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';


class PatrollingReportPage extends StatefulWidget {
  const PatrollingReportPage({super.key});

  @override
  State<PatrollingReportPage> createState() => _PatrollingReportPageState();
}

class _PatrollingReportPageState extends State<PatrollingReportPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  final destinationController = TextEditingController();
  final purposeController = TextEditingController();
  final officerStrengthController = TextEditingController();
  final jcoStrengthController = TextEditingController();
  final ncoStrengthController = TextEditingController();
  final startTimeController = TextEditingController();
  final riflesController = TextEditingController();
  final lmgController = TextEditingController();
  final smgController = TextEditingController();
  final vehicleStateController = TextEditingController();
  final commanderRankController = TextEditingController();
  final commanderNameController = TextEditingController();

  List<TextEditingController> routeControllers = [];

  String generatedReport = '';

  void addRouteCheckpoint() {
    setState(() {
      routeControllers.add(TextEditingController());
    });
  }

  void generateReport() {
    if (_formKey.currentState!.validate()) {
      final formattedDate = selectedDate != null
          ? DateFormat('dd MMMM yyyy').format(selectedDate!)
          : 'Not selected';

      String routeText = routeControllers
          .where((c) => c.text.isNotEmpty)
          .map((c) => '• ${c.text}')
          .join('\n');

      setState(() {
        generatedReport = '''
Assalamu Alaikum sir, 

Date: $formattedDate  
Destination: ${destinationController.text}  
Purpose: ${purposeController.text}  
Total Strength: Officers - ${officerStrengthController.text}, JCOs - ${jcoStrengthController.text}, NCOs - ${ncoStrengthController.text}  
Rifles Carried: ${riflesController.text}  
LMG's Carried: ${lmgController.text}  
SMG's Carried: ${smgController.text}  
Vehicle State: ${vehicleStateController.text}  
Start Time: ${startTimeController.text}  
Route:
$routeText

After ptl, man and mat all correct, sir.  
For your kind info, sir.

Regards  
${commanderRankController.text} ${commanderNameController.text}
''';
      });
    }
  }

  @override
  void dispose() {
    destinationController.dispose();
    purposeController.dispose();
    officerStrengthController.dispose();
    jcoStrengthController.dispose();
    ncoStrengthController.dispose();
    startTimeController.dispose();
    riflesController.dispose();
    lmgController.dispose();
    smgController.dispose();
    vehicleStateController.dispose();
    commanderRankController.dispose();
    commanderNameController.dispose();
    for (final c in routeControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Patrolling Report',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Patrolling Report',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Date field
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Text(
                          selectedDate != null
                              ? DateFormat('dd MMM yyyy').format(selectedDate!)
                              : 'Select date',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(now.year + 5),
                        );
                        if (picked != null) {
                          setState(() => selectedDate = picked);
                        }
                      },
                      icon: const Icon(Icons.calendar_today, color: Color(0xFF006400)),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                buildTextField('Destination', destinationController),
                buildTextField('Purpose', purposeController),
                buildTextField('Officers Strength', officerStrengthController,
                    keyboardType: TextInputType.number),
                buildTextField('JCOs Strength', jcoStrengthController,
                    keyboardType: TextInputType.number),
                buildTextField('NCOs Strength', ncoStrengthController,
                    keyboardType: TextInputType.number),
                buildTextField('Start Time', startTimeController),
                buildTextField('Rifles Carried', riflesController),
                buildTextField("LMG's Carried", lmgController),
                buildTextField("SMG's Carried", smgController),
                buildTextField('Vehicle State', vehicleStateController),
                buildTextField('Commander Rank', commanderRankController),
                buildTextField('Commander Name', commanderNameController),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Route Checkpoints',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    IconButton(
                      onPressed: addRouteCheckpoint,
                      icon: const Icon(Icons.add_circle, color: Color(0xFF006400)),
                    ),
                  ],
                ),
                Column(
                  children: routeControllers
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        controller: entry.value,
                        decoration: InputDecoration(
                          labelText: 'Checkpoint ${entry.key + 1}',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: generateReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006400),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Generate Report',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                if (generatedReport.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => Share.share(generatedReport),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: const Text('Share', style: TextStyle(color: Colors.white)),
                  ),
                ],

                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Generated Report:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SelectableText(
                    generatedReport.isEmpty
                        ? 'No report yet.'
                        : generatedReport,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => value!.isEmpty ? 'Required' : null,
      ),
    );
  }
}
