import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Controller/authentication_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  AuthenticationController authController = Get.put(AuthenticationController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            // Positioned(top: 25, left: 15,
            //     child: IconButton(onPressed: (){Get.back();},
            //         icon: Icon(Icons.arrow_back_rounded, size: 45)
            //     )),
            Form(key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30).copyWith(top: 70),
                  child: Column(
                    children: [
                      Align(alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: GestureDetector(onTap: (){Get.back();},
                              child: Container(padding: EdgeInsets.all(10),
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
                                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF455A64), size: 22)
                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 5),
                      SvgPicture.asset(ImageConst.forgot, height: 290, fit: BoxFit.cover),
                      const SizedBox(height: 150),
                      Text("FORGOT PASSWORD", style: AppTextStyle.black20_600),
                      const SizedBox(height: 15),
                      Text("We will email you an OTP to reset\nyour password",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey.shade600), textAlign: TextAlign.center),
                      const SizedBox(height: 70),
                      CustomInputField(controller: emailController, prefixIcon: '', inputAction: TextInputAction.done, label: 'Enter your email*',
                      validation: (email) => Validation.emailValidation(email)
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: Buttons.primaryButtons(title: 'SEND', event: (){
                          authController.forgotPassWord(key: formKey, email: emailController.text);

                          // formKey.currentState!.validate();
                          // Get.toNamed(AppRoute.resetPass);
                        }),
                      )
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
