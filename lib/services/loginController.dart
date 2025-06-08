import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  var obscurePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namecontroller = TextEditingController();
  final flat_numbercontroller = TextEditingController();
  final blockcontroller = TextEditingController();

  var display_name = ''.obs;
  var Block = ''.obs;
  var flat = ''.obs;


  get togglePasswordVisibility => null;

  void toggleObscure() {
    obscurePassword.value = !obscurePassword.value;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter email';
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter password';
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter Name';
    return null;
  }
  String? flat_numberValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter Flat number';
    return null;
  }

  String? blockValidator(String? value){
    if(value == null || value.isEmpty) return 'Please enter Block Number';
  }

  Future<void> supabase_signin() async {
    final supabase = Supabase.instance.client;
    try{
      final response = await supabase.auth.signInWithPassword(
          email: emailController.text,
          password: passwordController.text
      );

      final user = response.user;
      if (user != null) {
        final name = user.userMetadata?['display_name'] ?? 'User';
        final block = user.userMetadata?['block'] ?? 'No BLock';
        final flat_number = user.userMetadata?['flat_number'] ?? 'No Flat';
        display_name.value = name;
        Block.value = block;
        flat.value = flat_number;
        Get.snackbar('Logged In', 'Welcome back $display_name}');
        Get.offAllNamed('/dashboard');
      }else{
        print('eror');
      }
    }catch(e){
      print('error : $e');
    }
  }

  Future<void> supabase_signup() async{
    final supabase = Supabase.instance.client;

    try{
      final response = await supabase.auth.signUp(
          password: passwordController.text,
          email: emailController.text,
        data:{
            'display_name' : namecontroller.text,
          'flat_number' : flat_numbercontroller.text,
          'block' : blockcontroller.text,
        }
      );

      final user = response.user;
      if (user != null) {
        final name = user.userMetadata?['display_name'] ?? 'User';
        Get.snackbar('User Created', 'Welcome, $name');
        Get.offAllNamed('/dashboard');
        Get.snackbar('Signup Failed', 'No user returned from Supabase');
      }
    }catch(e){
      print('error : $e');
    }
  }
}
