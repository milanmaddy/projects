import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import '../../Constraints/text_style.dart';
import '../../Controller/authentication_controller.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/password_field.dart';
import '../Authentication/validation.dart';

class ChangePasswordPopup extends StatelessWidget {
  ChangePasswordPopup({Key? key}) : super(key: key);

  AuthenticationController authController = Get.put(AuthenticationController());

  TextEditingController newPController = TextEditingController();
  TextEditingController confirmPController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(height: 460,
      padding: const EdgeInsets.all(15).copyWith(bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))
      ),
      child: SingleChildScrollView(
        child: Form(key: formKey,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 40),
                  Text('change password'.toUpperCase(), style: AppTextStyle.black18_700),
                  IconButton(onPressed: (){Get.back();},
                      icon: const Icon(Icons.cancel_rounded, size: 42)
                  )
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomPasswordField(controller: newPController, prefixIcon: '', hint: '', label: 'New Password*',
                    validation: (newP) => Validation.normalValidation(newP)
                ),
              ),
              const SizedBox(height: 10),
              // const Text('Confirm New Password*', style: TextStyle(
              //     fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey
              // )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomPasswordField(controller: confirmPController, prefixIcon: '', hint: '',label: 'Confirm New Password*',
                    validation: (confirm) => Validation.confirmPasswordValidation(confirm, newPController.text, '')),
              ),
              const SizedBox(height: 60),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Buttons.popupButton(title: 'UPDATE PASSWORD', event: (){
                  authController.changePassword(
                      key: formKey,
                      oldPassword: SharedPrefUtils.getPassword().toString(),
                      newPassword: newPController.text,
                      confirmPassword: confirmPController.text
                  );
                })//authController.delete();})
              )
            ],
          ),
        ),
      ),
    );
  }
}
