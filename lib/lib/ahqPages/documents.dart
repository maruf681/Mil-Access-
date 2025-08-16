import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pdf_viewer.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  List<String> _savedDocuments = [];

  @override
  void initState() {
    super.initState();
    _loadSavedDocuments();
  }

  Future<void> _loadSavedDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedDocuments = prefs.getStringList('saved_documents') ?? [];
    });
  }

  void _openPDF(String path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerScreen(pdfAssetPath: path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Saved Documents'),
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _savedDocuments.length,
          itemBuilder: (context, index) {
            final doc = _savedDocuments[index];
            final title = doc.split('/').last.replaceAll('.pdf', '');
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Color(0xFF006400)),
                title: Text(title),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _openPDF(doc),
              ),
            );
          },
        ),
      ),
    );
  }

  static Future<void> saveDocument(String assetPath) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList('saved_documents') ?? [];
    if (!saved.contains(assetPath)) {
      saved.add(assetPath);
      await prefs.setStringList('saved_documents', saved);
    }
  }
}
