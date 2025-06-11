import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:spvalley_frontend/Screens/test.dart';
import 'package:spvalley_frontend/services/add_visitors.dart';

import '../utils/visitors_pass.dart';


class AddVisitors extends StatelessWidget{
  final AddVisitorsService addVisitorsService = Get.put(AddVisitorsService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visitor Entry')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildField(addVisitorsService.namecontroller, 'Visitor Name'),
            buildField(addVisitorsService.visitor_contactcontroller, 'Contact Number'),
            buildField(addVisitorsService.visitor_purposecontroller, 'Purpose'),
            buildField(addVisitorsService.visitor_blockcontroller, 'Block'),
            buildField(addVisitorsService.visitor_flat_numbercontroller, 'Flat Number'),
            buildField(addVisitorsService.visitor_time, 'Visiting Time (e.g., 14:00)'),
            Obx(() => ListTile(

              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2100),
                );
                print('date: $picked');
                if (picked != null) addVisitorsService.selectedDate.value = picked;
              },
              title: Text(
                addVisitorsService.selectedDate.value == null
                    ? 'Pick Visiting Date'
                    : 'Date: ${DateFormat.yMMMMd().format(addVisitorsService.selectedDate.value!)}',
                style: GoogleFonts.poppins(),
              )

            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                addVisitorsService.addvisitor();
               Future.delayed(Duration(seconds: 2), (){
                 _showVisitorPassDialog(context);
               });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: Text('Submit', style: GoogleFonts.poppins(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }

  void _showVisitorPassDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.transparent,
          child: VisitorPassCard(), // Use your custom widget here
        );
      },
    );
  }


  Widget buildField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}