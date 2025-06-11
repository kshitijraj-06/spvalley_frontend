import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PaidMaintenancePDFViewer extends StatelessWidget {
  final List<Map<String, dynamic>> paidList;

  PaidMaintenancePDFViewer({required this.paidList});

  Future<Uint8List> _buildPdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Paid Maintenance Report', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Month', 'Amount', 'Status'],
                data: paidList.map((item) => [
                  item['month'] ?? 'N/A',
                  item['amount'].toString(),
                  item['status'] ?? '',
                ]).toList(),
              ),
              pw.SizedBox(height: 20),
              // pw.Text(
              //   'Total Paid: ₹${paidList.fold(0, (sum, item) => sum + (item['amount'] ?? 0))}',
              //   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              // ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preview PDF')),
      body: PdfPreview(
        build: (format) => _buildPdf(format),
      ),
    );
  }
}
