import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AddVisitorsService extends GetxController{
  final namecontroller = TextEditingController();
  final visitor_namecontroller = TextEditingController();
  final visitor_blockcontroller = TextEditingController();
  final visitor_contactcontroller = TextEditingController();
  final visitor_flat_numbercontroller = TextEditingController();
  final visitor_purposecontroller = TextEditingController();

  final visitor_time = TextEditingController();

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  var visitor_id = ''.obs;

  Future<void> addvisitor() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if(user == null){
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      final response = await supabase.from('visitors').insert({
        'user_id': user.id,
        'name': namecontroller.text,
        'contact': visitor_contactcontroller.text,
        'purpose': visitor_purposecontroller.text,
        'block': visitor_blockcontroller.text,
        'flat_number': visitor_flat_numbercontroller.text,
        'visiting_date': selectedDate.value?.toIso8601String() ??
            DateTime.now().toIso8601String(),
        'visiting_time': visitor_time.text,
        'status' : false,
      })
      .select()
      .single();

      visitor_id.value = response['visitor_id'].toString();
      print(visitor_id);
      Get.snackbar('Success', 'Visitor added successfully');
    }catch(e){
      print(e);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateVisitorStatus(String visitorId, bool status) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      final response = await supabase.from('visitors').update({
        'status': status,
      }).eq('id', visitorId);
      Get.snackbar('Success', 'Visitor status updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }

  }

}