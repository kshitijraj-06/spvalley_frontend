import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../services/maintenance_controller.dart';

class MaintenanceScreen extends StatelessWidget {
  final MaintenanceService maintenanceService = Get.put(MaintenanceService());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bills & History'),
          bottom: TabBar(tabs: [Tab(text: 'Pending'), Tab(text: 'History')]),
        ),
        body: Obx(() {
          final data = maintenanceService.maintenanceList;

          final pending = data.where((e) => e['status'] == 'pending').toList();
          final paid = data.where((e) => e['status'] == 'paid').toList();

          return TabBarView(children: [_buildList(pending), _buildList(paid)]);
        }),
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return Center(child: Text('No data available'));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ListTile(
            leading:
                item['status'] == 'pending'
                    ? CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.house_outlined),
                    )
                    : CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.check_circle_outline),
                    ),
            title: Text('Maintenance', style: GoogleFonts.poppins()),
            subtitle: Text(
              'Month: ${item['month']}',
              style: GoogleFonts.poppins(),
            ),
            trailing:
                item['status'] == 'pending'
                    ? ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color(0xFF003AF5), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: Text(
                        'Pay Now',
                        style: GoogleFonts.poppins(color: Color(0xFF003AF5)),
                      ),
                    )
                    : Text(
                      'Paid',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
          ),
        );
      },
    );
  }
}
