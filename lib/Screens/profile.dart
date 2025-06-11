import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spvalley_frontend/services/profile_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget{
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
         //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 120,
            ),
            SizedBox(height: 30,),
            Text('Name: ${user.userMetadata!['display_name']}',
            style: GoogleFonts.poppins(
              fontSize: 30
            ),),
            SizedBox(height: 20,),
            Text("Block : ${user.userMetadata!['block']} - ${user.userMetadata!['flat_number']}",
              style: GoogleFonts.poppins(
                  fontSize: 27
              ),),
          ],
        ),
      )
    );
  }
}