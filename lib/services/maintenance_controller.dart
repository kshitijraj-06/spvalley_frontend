import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  void totalpending(){
    amount.value = maintenanceList
        .where((item) => item['status'] == 'pending')
        .fold<double>(0.0, (sum, item){
          return sum + (double.tryParse(item['amount'].toString()) ?? 0.0);

    });
  }
}