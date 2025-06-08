import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ComplaintRequestController extends GetxController{
  final namecontroller = TextEditingController();
  final subjectcontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final blockcontroller = TextEditingController();
  final flatnumbercontroller = TextEditingController();

  final RxString selectedCategory = 'Select Category'.obs;

  final categories = ['Select Category','Water Issues', 'Cleanliness Issue', 'Security Issue', 'Other'];


  Future<void> submitComplaintRequest() async{
    final user = Supabase.instance.client.auth.currentUser!;

    final response = await Supabase.instance.client.from('complaints').insert({
      'name': namecontroller.text,
      'block': blockcontroller.text,
      'flat_number': flatnumbercontroller.text,
      'subject': subjectcontroller.text,
      'description': descriptioncontroller.text,
      'category': selectedCategory.value,
      'user_id': user.id
    });
  }
}