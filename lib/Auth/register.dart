import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spvalley_frontend/services/loginController.dart';


class RegisterPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                _header(context),
                SizedBox(height: 20,),
                Text('Login to Your Account',
                  style: GoogleFonts.cairo(
                      fontSize: 20,
                      letterSpacing: 0
                  ),),
                SizedBox(height: 10,),
                _input(
                  label: 'Email',
                  isPassword: false,
                  controller: controller.emailController,
                  validator: controller.emailValidator,
                  loginController: controller,
                ),
                SizedBox(height: 10,),
                _input(
                  label: 'Password',
                  isPassword: true,
                  controller: controller.passwordController,
                  validator: controller.passwordValidator,
                  loginController: controller,
                ),
                _input(
                  label: 'Name',
                  isPassword: false,
                  controller: controller.namecontroller,
                  validator: controller.nameValidator,
                  loginController: controller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _input(
                        label: 'Block',
                        isPassword: false,
                        controller: controller.blockcontroller,
                        validator: controller.blockValidator,
                        loginController: controller,
                      ),
                    ),
                    Expanded(
                      child: _input(
                        label: 'Flat Number',
                        isPassword: false,
                        controller: controller.flat_numbercontroller,
                        validator: controller.flat_numberValidator,
                        loginController: controller,
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 13.0,top: 10, right: 13),
                  child: Divider(),
                ),
                ElevatedButton(
                  onPressed: () => Get.find<LoginController>().supabase_signup(),
                  child: Text("Login"),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 13.0,top: 10, right: 13),
                //   child: IconButton(
                //       onPressed: (){
                //         controller.googlesignin();
                //         Get.offAll(() => Dashboard());
                //       },
                //       icon: Icon(Icons.person)),
                // ),
              ]
          ),
        )
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.3,
          decoration: const BoxDecoration(color: Colors.lightGreen),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 3.3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spring Valley Phase - 1 ',
                  style: GoogleFonts.cairo(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Lalpur, Ranchi ',
                  style: GoogleFonts.cairo(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _input({
    required String label,
    required bool isPassword,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required LoginController loginController,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: isPassword
              ? Obx(() => IconButton(
            icon: Icon(
              loginController.obscurePassword.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              size: 20,
            ),
            onPressed: loginController.togglePasswordVisibility,
          ))
              : null,
        ),
        obscureText:
        isPassword ? loginController.obscurePassword.value : false,
        validator: validator,
      ),
    );
  }

}
