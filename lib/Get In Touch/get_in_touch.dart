import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/broadcast_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';

import '../Constraints/color_const.dart';
import '../Constraints/text_style.dart';
import '../GlobalWidgets/input_field_2.dart';

class GetInTouch extends StatelessWidget {
  GetInTouch({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  BroadcastController broadcastController = Get.put(BroadcastController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Get In Touch'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        child: Column(
                children: [
                  Container(padding: const EdgeInsets.symmetric(vertical: 12).copyWith(left: 30, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: const Offset(0, 2)
                          )
                        ]
                    ),
                    child: Text('Please fill out this quick form and we will be in\ntouch with lightning speed', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: ColorConst.grey3)),
                  ),
                  GetBuilder(
                    init: broadcastController,
                      initState: (controller){
                      broadcastController.contactUsDetails();
                      },
                      builder: (value){
                        return broadcastController.contactModel.value.data == null?
                        SizedBox(
                          height: Get.height,
                          child: PRLoader.normalLoader(),
                        ):
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Form(key: formKey,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomInputField2(controller: nameController, labelText: 'Full Name*', labelBackColor: ColorConst.back, inputAction: TextInputAction.next, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                                    validation: (name) => Validation.nameValidation(name)),
                                const SizedBox(height: 17),
                                CustomInputField2(controller: emailController, labelText: 'Email Address*', labelBackColor: ColorConst.back, inputAction: TextInputAction.next, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z @.]"))],
                                    validation: (email) => Validation.emailValidation(email)),
                                const SizedBox(height: 17),
                                CustomInputField2(controller: mobileController, labelText: 'Mobile Number*', labelBackColor: ColorConst.back, inputAction: TextInputAction.next, type: TextInputType.number,
                                    validation: (mobile) => Validation.phoneValidation(mobile)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 25),
                                  child: Text('Detail', style: AppTextStyle.black18_600),
                                ),
                                CustomInputField2(controller: messageController, labelText: 'Type Your Message*', maxLine: 3, labelBackColor: ColorConst.back, inputAction: TextInputAction.done,
                                    validation: (message) => Validation.normalValidation(message)),
                                const SizedBox(height: 25),
                                Center(child: Text('For Support any question: Email us at\n${value.contactModel.value.data!.user!.emailAddress}', textAlign: TextAlign.center,
                                    style: AppTextStyle.grey15_400)),
                                const SizedBox(height: 35),
                                Center(child: Buttons.actionButtons(title: 'SUBMIT', event: (){
                                  if(formKey.currentState!.validate()){
                                    broadcastController.contactUs(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: mobileController.text,
                                        message: messageController.text
                                    );
                                  }
                                }))


                              ],
                            ),
                          ),
                        );
                      }
                  )
                ],
              ),
      ),
    );
  }
}
