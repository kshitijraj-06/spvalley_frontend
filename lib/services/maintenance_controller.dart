import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:spvalley_frontend/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceService extends GetxController{
  var maintenanceList = <Map<String, dynamic>>[].obs;
  var amount = 0.0.obs;


  Future<void> fetchmaintenance() async{
    final supabase = Supabase.instance.client;
    final userid = supabase.auth.currentUser?.id;


    final response = await supabase
    .from('maintenance')
    .select()
    .eq('user_id', userid!);

    if (response != null) {
       maintenanceList.value = List<Map<String, dynamic>>.from(response);
       totalpending();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void onInit(){
    super.onInit();
    fetchmaintenance();
  }

  Future<void> generatePaidMaintenancePDF(List<Map<String, dynamic>> maintenanceList) async {
    final pdf = pw.Document();

    final paidList = maintenanceList.where((item) => item['status'] == 'paid').toList();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Paid Maintenance Report', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['Date', 'Amount', 'Status'],
              data: paidList.map((item) => [
                item['date'] ?? 'N/A',
                item['amount'].toString(),
                item['status']
              ]).toList(),
            ),
            pw.SizedBox(height: 20),
            // pw.Text(
            //   'Total Paid: ₹${paidList.fold(0, (sum, item) => sum + (item['amount'] ?? 0))}',
            //   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            // )
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  void totalpending(){
    amount.value = maintenanceList
        .where((item) => item['status'] == 'pending')
        .fold<double>(0.0, (sum, item){
          return sum + (double.tryParse(item['amount'].toString()) ?? 0.0);

    });
  }
}