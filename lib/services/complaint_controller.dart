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


  Future<void> submitComplaintRequest() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      final response = await supabase.from('complaints').insert({
        'user_id': user.id,
        'name': namecontroller.text,
        'block': blockcontroller.text,
        'flat_number': flatnumbercontroller.text,
        'subject': subjectcontroller.text,
        'description': descriptioncontroller.text,
        'category': selectedCategory.value, // assuming it's an RxString
      });

      Get.snackbar('Success', 'Your complaint has been submitted!');
      // You can also clear the controllers here if needed
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

}