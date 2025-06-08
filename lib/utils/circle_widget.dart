import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool add ;

  const CircleWidget({super.key, required this.title, required this.icon, required this.add});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                  color: add ? Color(0xFF003AF5) : Colors.black54,
                  width: 2)
          ),
          child: Icon(icon,size: 45,color: add ? Color(0xFF003AF5) : Colors.black54,),
        ),
        SizedBox(height: 5),
        Text(title,
          style: GoogleFonts.poppins(
              color: add ? Color(0xFF003AF5) : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15
          ),)
      ],
    );
  }

}