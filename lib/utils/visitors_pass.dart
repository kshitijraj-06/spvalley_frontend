import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spvalley_frontend/services/add_visitors.dart';
import 'package:get/get.dart';// For QR code generation


class VisitorPassCard extends StatelessWidget {
  final AddVisitorsService addVisitorsService = Get.put(AddVisitorsService());

  @override
  Widget build(BuildContext context) {
    // Sample data for the pass
    final visitor_id = addVisitorsService.visitor_id.value;
    final visitorName = addVisitorsService.namecontroller.text;
    final date = DateFormat.yMMMMd().format(addVisitorsService.selectedDate.value!);
    final time = addVisitorsService.visitor_time.text;
    final issuedBy = "Issued by Susan Taylor";
    final block = addVisitorsService.visitor_blockcontroller.text;
    final flat = addVisitorsService.visitor_flat_numbercontroller.text;
    final passId = "$visitorName-$block/$flat";
    final status = true;

    final data = ({
      'visitor_id' : visitor_id,
      'status' : status,
    });

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row: Name and Download Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  visitorName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 6),

            // Date, Time, Issued By and Room
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$date   $time",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),

            SizedBox(height: 20),
            Text('Visitor ID: $visitor_id ', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // QR Code
            QrImageView(
              data: jsonEncode(data),
              version: QrVersions.auto,
              size: 180,
              gapless: false,
            ),

            SizedBox(height: 10),

            // Pass ID
            Text(
              "Pass ID: $passId",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 20),

            // Icons with text row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Car icon + text
                Column(
                  children: [
                    Icon(Icons.directions_car_outlined, size: 30),
                    SizedBox(height: 6),
                    //Text(car),
                  ],
                ),
                // Persons icon + text
                Column(
                  children: [
                    Icon(Icons.group_outlined, size: 30),
                    SizedBox(height: 6),
                    //Text(persons),
                  ],
                ),
              ],
            ),

            SizedBox(height: 30),

            // Success button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  "Pass Issued Successfully",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
