import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spvalley_frontend/Auth/login.dart';
import 'package:spvalley_frontend/Auth/register.dart';
import 'package:spvalley_frontend/Screens/complaint_request.dart';
import 'package:spvalley_frontend/Screens/maintenance.dart';
import 'package:spvalley_frontend/services/loginController.dart';
import 'package:spvalley_frontend/services/maintenance_controller.dart';
import 'package:spvalley_frontend/utils/circle_widget.dart';

class Dashboard extends StatelessWidget{
  final LoginController loginController = Get.find<LoginController>();
  final MaintenanceService maintenanceService = Get.put(MaintenanceService());

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFEFF0F2),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xFFEFF0F2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loginController.display_name.value,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    )),
                    Text('${loginController.Block.value} - ${loginController.flat.value}',
                        style: GoogleFonts.poppins(
                          fontSize: 20
                        )),
                  ],
                ),
              ],
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined,
            size: 30,))
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                        'Due Amount: ₹${maintenanceService.amount.value.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,

                        ),
                      )),
                      ElevatedButton(
                          onPressed: (){
                            Get.to(MaintenanceScreen());
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF003AF5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          fixedSize: Size(120,50)
                        ),
                          child: Text('Pay Now',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Visitors',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 28
                  ),),
                  InkWell(
                    onTap: (){

                    },
                    child: Text('View All',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF003AF5),
                          fontSize: 15
                      ),),
                  )
                ],
              ), // Visitors(TEXT)
              SizedBox(height: 10,),
              CircleWidget(title: 'Add', icon: Icons.add, add: true,),
              SizedBox(height: 10,),
              Text('Announcements & Events',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 28
                ),),
              SizedBox(height: 10,),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      elevation: 4,
                      child: Container(
                        width: 260,
                        padding: EdgeInsets.all(16),
                        child: Center(child: Text('Card #$index')),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
              Text('Complaints & Requests',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 28
                ),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(onTap: (){Get.to(ComplaintRequestForm());},child: CircleWidget(title: 'Add', icon: Icons.add, add: true,)),
                  CircleWidget(title: 'Helper', icon: Icons.house_outlined, add: false,),
                  CircleWidget(title: 'Pest Control', icon: Icons.pest_control_outlined, add: false,),
                  CircleWidget(title: 'Laundry', icon: Icons.local_laundry_service_outlined, add: false,),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        shape: CircularNotchedRectangle(),
        color: Colors.transparent,
        notchMargin: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home, size: 40,), onPressed: () {}),
            IconButton(icon: Icon(Icons.sports_tennis_outlined, size: 40,), onPressed: () {}),
            IconButton(icon: Icon(Icons.home_work_outlined, size: 40), onPressed: (){},),
            IconButton(icon: Icon(Icons.money, size: 40), onPressed: (){ Get.to(MaintenanceScreen());},)
          ],
        ),
      )
      ,
    );
  }
}