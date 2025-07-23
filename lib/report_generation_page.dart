import 'package:flutter/material.dart';

class ReportGenerationPage extends StatelessWidget {
  const ReportGenerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 240, 197),
      appBar: AppBar(
        title: Text('Generate Report'),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Report Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Report Content',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: () {
                // Add save/generate logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Report submitted successfully!')),
                );
              },
              icon: Icon(Icons.send),
              label: Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}
