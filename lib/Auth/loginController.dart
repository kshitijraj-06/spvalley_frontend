import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var obscurePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> submit() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Login', 'Please fill in all fields');
      return;
    }

    try {
      print("🟡 Logging in with Firebase...");
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar('Firebase Login', 'Successfully logged in');

      final String? idToken = await userCredential.user?.getIdToken();

      if (idToken != null) {
        print("🟢 Firebase Token received: $idToken");
        await loginToBackend(idToken);
      } else {
        print("🔴 No Firebase token received");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Error', e.message ?? 'Unknown error');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  Future<void> loginToBackend(String idToken) async {
    try {
      print("🌐 Sending request to backend with token...");

      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/auth/login'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final user = json['data'];

        Get.snackbar("Backend Login", "Welcome ${user['displayName']}");
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar("Backend Login", "Error: ${response.statusCode}");
      }
    } catch (e) {
      print("🔴 Backend Error: $e");
      Get.snackbar("Backend Error", e.toString());
    }
  }


  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final idToken = await userCredential.user?.getIdToken();

      if (idToken != null) {
        await loginToBackend(idToken);
      }
    } catch (e) {
      Get.snackbar('Google Sign-In Error', e.toString());
    }
  }
}
