import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService extends GetxController{
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var block = ''.obs;
  var flat = ''.obs;

  @override
  void onInit(){
    super.onInit();
    fetchprofile();
  }

  Future<void> fetchprofile()async{
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser!;

    final name = user?.userMetadata!['display_name'];
    final email = user?.userMetadata!['email'];
    final phone = user?.userMetadata!['phone'];
    final block = user?.userMetadata!['block'];
    final flat = user?.userMetadata!['flat'];

    name.value = name;
    email.value = email;
    phone.value = phone;
    block.value = block;
    flat.value = flat;

  }
}