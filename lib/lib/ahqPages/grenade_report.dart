import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';


class GrenadeReportPage extends StatefulWidget {
  const GrenadeReportPage({super.key});

  @override
  State<GrenadeReportPage> createState() => _GrenadeReportPageState();
}

class _GrenadeReportPageState extends State<GrenadeReportPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  final unitController = TextEditingController();
  final officerStrengthController = TextEditingController();
  final jcoStrengthController = TextEditingController();
  final ncoStrengthController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final grenadesCarriedController = TextEditingController();
  final grenadesFiredController = TextEditingController();
  final vehicleStateController = TextEditingController();
  final commanderRankController = TextEditingController();
  final commanderNameController = TextEditingController();

  String generatedReport = '';

  Future<void> pickDate() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void generateReport() {
    if (_formKey.currentState!.validate()) {
      final formattedDate = selectedDate != null
          ? DateFormat('dd MMMM yyyy').format(selectedDate!)
          : 'Not selected';

      setState(() {
        generatedReport = '''
Assalamu Alaikum sir, 

Date: $formattedDate  
Unit: ${unitController.text}  
Total Strength: Officers - ${officerStrengthController.text}, JCOs - ${jcoStrengthController.text}, NCOs - ${ncoStrengthController.text}  
Grenades Carried: ${grenadesCarriedController.text}  
Grenades Fired: ${grenadesFiredController.text}  
Vehicle State: ${vehicleStateController.text}  
Start Time: ${startTimeController.text}  
End Time: ${endTimeController.text}  

After gren firing, man and mat all correct, sir.  
For your kind info, sir.

Regards  
${commanderRankController.text} ${commanderNameController.text}
''';
      });
    }
  }

  @override
  void dispose() {
    unitController.dispose();
    officerStrengthController.dispose();
    jcoStrengthController.dispose();
    ncoStrengthController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    grenadesCarriedController.dispose();
    grenadesFiredController.dispose();
    vehicleStateController.dispose();
    commanderRankController.dispose();
    commanderNameController.dispose();
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
        title: const Text('Gren Firing Report',
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
                  'Generate Gren Firing Report',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Date
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
                      onPressed: pickDate,
                      icon: const Icon(Icons.calendar_today, color: Color(0xFF006400)),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                buildTextField('Unit Name', unitController),
                buildTextField('Officers Strength', officerStrengthController,
                    keyboardType: TextInputType.number),
                buildTextField('JCOs Strength', jcoStrengthController,
                    keyboardType: TextInputType.number),
                buildTextField('NCOs Strength', ncoStrengthController,
                    keyboardType: TextInputType.number),
                buildTextField('Start Time', startTimeController),
                buildTextField('End Time', endTimeController),
                buildTextField('Grenades Carried', grenadesCarriedController),
                buildTextField('Grenades Fired', grenadesFiredController),
                buildTextField('Vehicle State', vehicleStateController),
                buildTextField('Commander Rank', commanderRankController),
                buildTextField('Commander Name', commanderNameController),

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
