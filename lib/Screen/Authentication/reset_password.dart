import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Controller/authentication_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/password_field.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';
import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/buttons.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  
  AuthenticationController authController = Get.put(AuthenticationController());

  TextEditingController pass1Controller = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String email = Get.arguments;

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
            Center(
              child: Padding(padding: const EdgeInsets.all(30).copyWith(top: 70),
                child: Form(key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 47),
                      SvgPicture.asset(ImageConst.forgot, height: 290, fit: BoxFit.cover),
                      const SizedBox(height: 50),
                      Text("RESET YOUR PASSWORD", style: AppTextStyle.black20_600),
                      const SizedBox(height: 30),
                      CustomPasswordField(controller: pass1Controller, prefixIcon: '', hint: '', label: 'New Password*',
                      validation: (pass1) => Validation.passwordValidation(pass1),),
                      const SizedBox(height: 10),
                      CustomPasswordField(controller: pass2Controller, prefixIcon: '', hint: '', label: 'Confirm Password*',
                      validation: (pass2) => Validation.confirmPasswordValidation(pass2, pass1Controller.text, ''),),
                      const SizedBox(height: 50),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          oTPBox(context, otp1, isFirst: true),
                          oTPBox(context, otp2),
                          oTPBox(context, otp3),
                          oTPBox(context, otp4, isLast: true),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't Receive the OTP?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                          const SizedBox(width: 5),
                          GestureDetector(onTap: (){
                            otp1.clear();
                            otp2.clear();
                            otp3.clear();
                            otp4.clear();
                            authController.forgotPassWord(key: formKey, email: email, isSendAgain: true);
                          },
                            child: Text('Send again', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConst.button)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: Buttons.primaryButtons(title: 'RESET', event: (){
                          authController.resetPassWord(
                              key: formKey,
                              email: email,
                              password: pass1Controller.text,
                              confirmPassword: pass2Controller.text,
                              otp: otp1.text+otp2.text+otp3.text+otp4.text
                          );
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
  Widget oTPBox(BuildContext context, TextEditingController controller,
      {bool isFirst = false, bool isLast = false}) {
    return SizedBox(width: 87,
        child: TextFormField(
            controller: controller,
            // textInputAction: TextInputAction.done,
            validator: (value){
              return value!.isEmpty?"Empty Field":null;
            },
            // autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && !isLast) {
                FocusScope.of(context).nextFocus();
              }else if (value.isEmpty && !isFirst) {
                controller.text = '';
                FocusScope.of(context).previousFocus();
              }
            },

            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            // style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 23),
                border: OutlineInputBorder(borderRadius:BorderRadius.circular(10), borderSide: const BorderSide(width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey, width: 2)),
                counterText: '')
        )
    );
  }
}
