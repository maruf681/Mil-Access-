import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatelessWidget {
  final String pdfAssetPath;

  const PDFViewerScreen({super.key, required this.pdfAssetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        backgroundColor: const Color(0xFF006400),
        foregroundColor: Colors.white,
      ),
      body: SfPdfViewer.asset(pdfAssetPath),
    );
  }
}
