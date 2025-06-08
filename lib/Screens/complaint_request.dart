import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spvalley_frontend/services/complaint_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ComplaintRequestForm extends StatelessWidget{
  final ComplaintRequestController complaintRequestController = Get.put(ComplaintRequestController());
  final user = Supabase.instance.client.auth.currentUser!;

  @override
  Widget build(BuildContext context) {
    complaintRequestController.namecontroller.text = user.userMetadata!['display_name'];
    complaintRequestController.blockcontroller.text = user.userMetadata?['block'] ?? 'No BLock';
    complaintRequestController.flatnumbercontroller.text = user.userMetadata?['flat_number'] ?? 'No Flat';
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints Form',
        style: GoogleFonts.poppins(),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            Text('Raise a Complaint', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            _buildLabel('Your Name'),
            SizedBox(height: 10,),
            TextField(
              controller: complaintRequestController.namecontroller,
              readOnly: true,
              decoration: _inputDecoration('Name'),
            ),
            SizedBox(height: 16),
            _buildLabel('Block'),
            SizedBox(height: 10,),
            TextField(
              controller: complaintRequestController.blockcontroller,
              readOnly: true,
              decoration: _inputDecoration('Block'),
            ),
            SizedBox(height: 16),
            _buildLabel('Flat Number'),
            SizedBox(height: 10,),
            TextField(
              controller: complaintRequestController.flatnumbercontroller,
              readOnly: true,
              decoration: _inputDecoration('Name'),
            ),

            SizedBox(height: 16),

            _buildLabel('Subject'),
            SizedBox(height: 10,),
            TextField(
              controller: complaintRequestController.subjectcontroller,
              decoration: _inputDecoration('Subject'),
            ),
            SizedBox(height: 16),

            _buildLabel('Category'),
            SizedBox(height: 10,),
            Obx(() => DropdownButtonFormField<String>(
              value: complaintRequestController.selectedCategory.value,
              items: complaintRequestController.categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (val) => complaintRequestController.selectedCategory.value = val!,
              decoration: _inputDecoration('Select Category'),
            )),
            SizedBox(height: 16),

            _buildLabel('Description'),
            SizedBox(height: 10,),
            TextField(
              controller: complaintRequestController.descriptioncontroller,
              maxLines: 5,
              decoration: _inputDecoration('Describe your issue'),
            ),
            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                // You can call your controller method here
                Get.snackbar('Submitted', 'Your complaint has been sent!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003AF5),
                padding: EdgeInsets.symmetric(vertical: 14),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              child: Text('Submit', style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20
              )),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildLabel(String text) {
    return Text(text, style: GoogleFonts.poppins(fontWeight: FontWeight.w500));
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF003AF5)),
      ),
    );
  }

}