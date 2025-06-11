import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spvalley_frontend/services/view_visitors.dart';


class AllVisitorsScreen extends StatelessWidget {
  final visitorController = Get.put(GetVisitorsService());

  String formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return DateFormat.yMMMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Visitors')),
      body: Obx(() {
        if (visitorController.visitorsList.isEmpty) {
          return Center(child: Text('No visitors found'));
        }

        return ListView.builder(
          itemCount: visitorController.visitorsList.length,
          itemBuilder: (context, index) {
            final visitor = visitorController.visitorsList[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(visitor['name'] ?? 'Unknown'),
                subtitle: Text(
                    'Block ${visitor['block']}, Flat ${visitor['flat_number']}\n'
                        'Date: ${formatDate(visitor['visiting_date'])}\n'
                        'Time: ${visitor['visiting_time']}'),
              ),
            );
          },
        );
      }),
    );
  }
}
