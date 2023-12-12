import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/authentication_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field.dart';
import 'package:kawawa_motors/GlobalWidgets/password_field.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';

import '../../../Constraints/color_const.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  AuthenticationController authController = Get.put(AuthenticationController());

  TextEditingController oldPController = TextEditingController();
  TextEditingController newPController = TextEditingController();
  TextEditingController confirmPController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Change Password'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 90),
          child: Form(key: formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPasswordField(controller: oldPController, hint: '', label: 'Old Password*',
                    validation: (password) => Validation.normalValidation(password), inputAction: TextInputAction.done),
                const SizedBox(height: 10),
                CustomPasswordField(controller: newPController, prefixIcon: '', hint: '', label: 'New Password*',
                  validation: (newP) => Validation.normalValidation(newP)
                ),
                const SizedBox(height: 10),
                CustomPasswordField(controller: confirmPController, prefixIcon: '', hint: '',label: 'Confirm New Password*',
                  validation: (confirm) => Validation.confirmPasswordValidation(confirm, newPController.text, '')),
                const SizedBox(height: 60),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Buttons.actionButtons(title: 'UPDATE PASSWORD', event: (){
                      authController.changePassword(
                          key: formKey,
                          oldPassword: oldPController.text,
                          newPassword: newPController.text,
                          confirmPassword: confirmPController.text
                      );
                    }),
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
