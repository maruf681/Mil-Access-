import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:intl/intl.dart'; // For date formatting

class ReportGeneratorScreen extends StatefulWidget {
  const ReportGeneratorScreen({super.key});

  @override
  State<ReportGeneratorScreen> createState() => _ReportGeneratorScreenState();
}

class _ReportGeneratorScreenState extends State<ReportGeneratorScreen> {
  // Controllers for the report fields
  final TextEditingController _dutyOffrController = TextEditingController();
  final TextEditingController _dutyJCOController = TextEditingController();
  final TextEditingController _dutyNCOController = TextEditingController();
  final TextEditingController _dutyClkMorningController = TextEditingController();
  final TextEditingController _dutyClkEveningController = TextEditingController();
  final TextEditingController _dayEventsController = TextEditingController();
  final TextEditingController _niEventsController = TextEditingController();
  final TextEditingController _vehDetailedController = TextEditingController();
  final TextEditingController _ictSpController = TextEditingController();
  final TextEditingController _trgController = TextEditingController();
  final TextEditingController _dailyInOutStateController = TextEditingController();
  final TextEditingController _bnParadeStateController = TextEditingController();
  final TextEditingController _absentSummaryController = TextEditingController();
  final TextEditingController _presentSummaryController = TextEditingController();
  final TextEditingController _dailyPostingSummaryController = TextEditingController();
  final TextEditingController _totalAttsController = TextEditingController();

  String _generatedReport = '';
  bool _isLoading = false;

  // Placeholder for API Key. In a real app, manage this securely.
  // For Canvas environment, __api_key will be provided automatically if left empty.
  final String _apiKey = ""; // Leave empty for Canvas to provide

  Future<void> _generateReport() async {
    setState(() {
      _isLoading = true;
      _generatedReport = ''; // Clear previous report
    });

    final String currentDate = DateFormat('dd MMM yyyy(EEEE)').format(DateTime.now()); // Full day name

    // Construct the prompt with all user inputs
    final String prompt = """
    Generate a detailed report based on the following inputs for the Commanding Officer to GOC.
    The report should follow this exact structure and content, using the provided information:

    Assalamu Alaikum Sir,

    SUBJ: ADMIN MATTERS AND TOMORROW'S CMT ($currentDate).

    1. Duty Tomorrow.
        a. Duty Offr: ${_dutyOffrController.text.isNotEmpty ? _dutyOffrController.text : 'N/A'}
        b. Duty JCO: ${_dutyJCOController.text.isNotEmpty ? _dutyJCOController.text : 'N/A'}
        c. Duty NCO: ${_dutyNCOController.text.isNotEmpty ? _dutyNCOController.text : 'N/A'}
        d. Duty Clk:
            (1) Snk (Clk) Faridul-Morning. ${_dutyClkMorningController.text.isNotEmpty ? _dutyClkMorningController.text : 'N/A'}
            (2) Snk (Clk) Mostafiz-Evening. ${_dutyClkEveningController.text.isNotEmpty ? _dutyClkEveningController.text : 'N/A'}

    2. Maj Events Tomorrow.
        a. Day Event.
        ${_dayEventsController.text.isNotEmpty ? _dayEventsController.text : 'Nil.'}

        b. Ni Event. ${_niEventsController.text.isNotEmpty ? _niEventsController.text : 'Nil.'}

        c. Veh Detailed.
        ${_vehDetailedController.text.isNotEmpty ? _vehDetailedController.text : 'Nil.'}

    3. ICT Sp.
    ${_ictSpController.text.isNotEmpty ? _ictSpController.text : 'Nil.'}

    4. Trg.
    ${_trgController.text.isNotEmpty ? _trgController.text : 'Nil.'}

    5. Admin Matters.
        a. Summary of Daily In/Out State.
        ${_dailyInOutStateController.text.isNotEmpty ? _dailyInOutStateController.text : 'Nil.'}

        b. Summary of Bn Parade State.
        ${_bnParadeStateController.text.isNotEmpty ? _bnParadeStateController.text : 'Nil.'}

        c. Absent ${_absentSummaryController.text.isNotEmpty ? _absentSummaryController.text : '00'}.

        d. Present ${_presentSummaryController.text.isNotEmpty ? _presentSummaryController.text : '00'}.

        e. Daily Posting Summary In/Out: ${_dailyPostingSummaryController.text.isNotEmpty ? _dailyPostingSummaryController.text : '00'}.

        f. Total Atts- ${_totalAttsController.text.isNotEmpty ? _totalAttsController.text : '00'}.

    For your kind info pl.
    Regards

    Ensure the output is only the report text, without any additional conversational text or markdown formatting (like ```).
    If any section is left blank, use 'Nil.' or '00' as appropriate for numerical fields.
    """;

    try {
      final List<Map<String, dynamic>> chatHistory = [
        {"role": "user", "parts": [{"text": prompt}]}
      ];

      final Map<String, dynamic> payload = {
        "contents": chatHistory,
      };

      final String apiUrl = "[https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey](https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey)";

      print('Sending request to: $apiUrl'); // Debugging print
      print('Request payload: ${json.encode(payload)}'); // Debugging print

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print('Response status code: ${response.statusCode}'); // Debugging print
      print('Response body: ${response.body}'); // Debugging print

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        String generatedText = 'Failed to generate report: Unexpected response structure or empty content.'; // Default error message

        if (result['candidates'] != null &&
            result['candidates'].isNotEmpty &&
            result['candidates'][0]['content'] != null &&
            result['candidates'][0]['content']['parts'] != null &&
            result['candidates'][0]['content']['parts'].isNotEmpty) {
          generatedText = result['candidates'][0]['content']['parts'][0]['text'];
          if (generatedText.trim().isEmpty) {
            generatedText = 'LLM generated an empty report. Please try again with more detailed inputs.';
          }
        }
        setState(() {
          _generatedReport = generatedText;
        });
      } else {
        setState(() {
          _generatedReport = 'Failed to generate report: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _generatedReport = 'Error generating report: $e';
      }
      );
      print('Exception during report generation: $e'); // Debugging print
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _dutyOffrController.dispose();
    _dutyJCOController.dispose();
    _dutyNCOController.dispose();
    _dutyClkMorningController.dispose();
    _dutyClkEveningController.dispose();
    _dayEventsController.dispose();
    _niEventsController.dispose();
    _vehDetailedController.dispose();
    _ictSpController.dispose();
    _trgController.dispose();
    _dailyInOutStateController.dispose();
    _bnParadeStateController.dispose();
    _absentSummaryController.dispose();
    _presentSummaryController.dispose();
    _dailyPostingSummaryController.dispose();
    _totalAttsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Matters Report'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please provide details for the "Admin Matters and Tomorrow\'s CMT" Report:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),

            _buildSectionHeader('1. Duty Tomorrow.'),
            _buildQuestionField(_dutyOffrController, 'a. Duty Offr:'),
            _buildQuestionField(_dutyJCOController, 'b. Duty JCO:'),
            _buildQuestionField(_dutyNCOController, 'c. Duty NCO:'),
            _buildQuestionField(_dutyClkMorningController, 'd. Duty Clk (1) Snk (Clk) Faridul-Morning:'),
            _buildQuestionField(_dutyClkEveningController, 'd. Duty Clk (2) Snk (Clk) Mostafiz-Evening:'),
            const SizedBox(height: 20),

            _buildSectionHeader('2. Maj Events Tomorrow.'),
            _buildMultiLineQuestionField(_dayEventsController, 'a. Day Event (e.g., (1) Flag Staff House Gd Duty...):'),
            _buildQuestionField(_niEventsController, 'b. Ni Event:'),
            _buildMultiLineQuestionField(_vehDetailedController, 'c. Veh Detailed (e.g., (1) 1×Jeep (Lcpl Emran)...):'),
            const SizedBox(height: 20),

            _buildSectionHeader('3. ICT Sp.'),
            _buildMultiLineQuestionField(_ictSpController, 'ICT Support Details (e.g., a. VTC, Army WAN: Nil...):'),
            const SizedBox(height: 20),

            _buildSectionHeader('4. Trg.'),
            _buildMultiLineQuestionField(_trgController, 'Training Details (e.g., a. Regt Prog of Newly Commissioned Offr...):'),
            const SizedBox(height: 20),

            _buildSectionHeader('5. Admin Matters.'),
            _buildMultiLineQuestionField(_dailyInOutStateController, 'a. Summary of Daily In/Out State (e.g., (1) Lve Ive In- 09...):'),
            _buildMultiLineQuestionField(_bnParadeStateController, 'b. Summary of Bn Parade State (e.g., (1) Total Str: 734...):'),
            _buildQuestionField(_absentSummaryController, 'c. Absent (e.g., 399):'),
            _buildQuestionField(_presentSummaryController, 'd. Present (e.g., 335):'),
            _buildQuestionField(_dailyPostingSummaryController, 'e. Daily Posting Summary In/Out (e.g., 00):'),
            _buildQuestionField(_totalAttsController, 'f. Total Atts (e.g., 60):'),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _isLoading ? null : _generateReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Generate Report',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
            const SizedBox(height: 30),
            if (_generatedReport.isNotEmpty) // This condition now ensures a message is always displayed if the report isn't empty
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Generated Admin Matters Report:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _generatedReport,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildQuestionField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: 1, // Single line for these specific fields
          decoration: InputDecoration(
            hintText: 'Enter ${label.toLowerCase().replaceAll(':', '')}',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildMultiLineQuestionField(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: null, // Unlimited lines
          minLines: 3, // Start with 3 lines
          decoration: InputDecoration(
            hintText: 'Enter details for ${label.toLowerCase().replaceAll(':', '')}',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

