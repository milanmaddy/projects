import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/Controller/authentication_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field.dart';
import 'package:kawawa_motors/GlobalWidgets/password_field.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';

import '../../Constraints/image_const.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  AuthenticationController authController = Get.put(AuthenticationController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // emailController.text = 'milanmandi35@gmail.com';
    // passwordController.text = '11111111';
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
          Image.asset(
            ImageConst.backPng2,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
            Padding(
              padding: const EdgeInsets.all(30).copyWith(top: 70),
              child: Form(key: formKey,
                child: Center(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: GestureDetector(onTap: (){Get.back();},
                              child: Container(padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 3,
                                            spreadRadius: 2,
                                            offset: const Offset(0,2)
                                        )
                                      ]
                                  ),
                                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF455A64), size: 22)
                              ),
                            )
                        ),
                      ),
                      const SizedBox(height: 5),
                      Image.asset(ImageConst.logoP),
                      const SizedBox(height: 20),
                      Text("SIGN IN", style: AppTextStyle.black20_600),
                      const SizedBox(height: 80),
                      const Align(alignment: Alignment.centerLeft,
                          child: Text("Welcome,", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500))),
                      const SizedBox(height: 10),
                      const Align(alignment: Alignment.centerLeft,
                          child: Text("Sign in with your account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))),
                      const SizedBox(height: 10),

                      // Align(alignment: Alignment.centerLeft,
                      //     child: Text('Email*', style: AppTextStyle.label)),
                      CustomInputField(controller: emailController, prefixIcon: '', label: 'Email*',
                        validation: (email) => Validation.emailValidation(email), inputAction: TextInputAction.next),
                      const SizedBox(height: 10),
                      // Align(alignment: Alignment.centerLeft,
                      //     child: Text('Password*', style: AppTextStyle.label)),
                      CustomPasswordField(controller: passwordController, hint: '', label: 'Password*',
                      validation: (password) => Validation.normalValidation(password), inputAction: TextInputAction.done),
                      const SizedBox(height: 30),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Forgot your password?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                          const SizedBox(width: 5),
                          GestureDetector(onTap: (){
                            Get.toNamed(AppRoute.forgotPass);
                            emailController.clear();
                            passwordController.clear();
                            },
                            child: Text('Reset here', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConst.button)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: Buttons.primaryButtons(title: 'SIGN IN', event: (){
                          // formKey.currentState!.validate(); print('gg');
                          // Get.toNamed(AppRoute.dashBoard);
                          authController.login(
                              key: formKey,
                              email: emailController.text,
                              password: passwordController.text);
                        }),
                      ),
                      const SizedBox(height: 150),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                          const SizedBox(width: 5),
                          GestureDetector(onTap: (){Get.toNamed(AppRoute.register);},
                            child: Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConst.button)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
