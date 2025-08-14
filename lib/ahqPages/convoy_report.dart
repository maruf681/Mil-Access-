import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class ConvoyReportPage extends StatefulWidget {
  const ConvoyReportPage({super.key});

  @override
  State<ConvoyReportPage> createState() => _ConvoyReportPageState();
}

class _ConvoyReportPageState extends State<ConvoyReportPage> {
  final _formKey = GlobalKey<FormState>();

  final destinationController = TextEditingController();
  final commanderNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final strengthController = TextEditingController();
  final itemsCarriedController = TextEditingController();
  final vehicleStateController = TextEditingController();
  final startTimeController = TextEditingController();
  final presentLocationController = TextEditingController();
  final commanderRankController = TextEditingController();
  final commanderDisplayNameController = TextEditingController();

  List<TextEditingController> routeControllers = [];

  String generatedReport = '';

  void addCheckpoint() {
    setState(() {
      routeControllers.add(TextEditingController());
    });
  }

  void generateReport() {
    if (_formKey.currentState!.validate()) {
      String route = routeControllers
          .where((c) => c.text.isNotEmpty)
          .map((c) => '• ${c.text}')
          .join('\n');

      setState(() {
        generatedReport = '''
Assalamu Alaikum sir, 

I, ${commanderRankController.text} ${commanderDisplayNameController.text}, have started for ${destinationController.text} at ${startTimeController.text} with fol under my disposal:

Total Strength: ${strengthController.text}  
Items Carried: ${itemsCarriedController.text}  
Vehicle State: ${vehicleStateController.text}  
Route:
$route
Present Location: ${presentLocationController.text}  

For your kind info, sir.

Regards  
${commanderRankController.text} ${commanderDisplayNameController.text}
''';
      });
    }
  }

  @override
  void dispose() {
    destinationController.dispose();
    commanderNameController.dispose();
    contactNumberController.dispose();
    strengthController.dispose();
    itemsCarriedController.dispose();
    vehicleStateController.dispose();
    startTimeController.dispose();
    presentLocationController.dispose();
    commanderRankController.dispose();
    commanderDisplayNameController.dispose();
    for (final controller in routeControllers) {
      controller.dispose();
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
        title: const Text('Mov Report',
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
                  'Generate Mov Report',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Text fields
                buildTextField('Destination', destinationController),
                buildTextField("Commander's Name", commanderNameController),
                buildTextField('Contact Number', contactNumberController,
                    keyboardType: TextInputType.phone),
                buildTextField('Total Strength', strengthController),
                buildTextField('Items Carried', itemsCarriedController),
                buildTextField('Vehicle State', vehicleStateController),
                buildTextField('Start Time', startTimeController),
                buildTextField('Present Location', presentLocationController),
                buildTextField('Commander Rank', commanderRankController),
                buildTextField('Commander Display Name', commanderDisplayNameController),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Route Checkpoints',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    IconButton(
                      onPressed: addCheckpoint,
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
