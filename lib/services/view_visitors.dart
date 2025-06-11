import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetVisitorsService extends GetxController{
  var visitorsList = <Map<String, dynamic>>[].obs;


  @override
  void onInit(){
    super.onInit();
    fetchvisitors();
  }

  Future<void> fetchvisitors() async{
    final supabase = Supabase.instance.client;
    final userid = supabase.auth.currentUser?.id;

    try{
      final response = await supabase
          .from('visitors')
          .select()
          .eq('user_id', userid!);

      if(response != null){
        visitorsList.value = List<Map<String, dynamic>>.from(response);
        print(response);
      }else {
        throw Exception('Failed to fetch data');
      }
    }catch(e){}
  }
}