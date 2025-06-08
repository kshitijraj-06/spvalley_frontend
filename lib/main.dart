import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spvalley_frontend/services/loginController.dart';
import 'package:spvalley_frontend/services/maintenance_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Auth/login.dart';
import 'dashboard.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  await Firebase.initializeApp();
  Get.put(LoginController());
  Get.put(MaintenanceService());
  runApp(
      GetMaterialApp(
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => Login()),
      GetPage(name: '/dashboard', page: () => Dashboard()),
    ],
  ));
}