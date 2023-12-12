import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/enquiry_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field_2.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';
import '../../Constraints/color_const.dart';
import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/buttons.dart';

class EnquirePopup extends StatelessWidget {
  EnquirePopup({Key? key, this.enqFrom, this.userID, this.productID}) : super(key: key);

  String? enqFrom;
  String? userID;
  String? productID;

  TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  EnquiryController enqController = Get.put(EnquiryController());

  @override
  Widget build(BuildContext context) {
    return Container(height: 420,
      padding: const EdgeInsets.all(15).copyWith(bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))
      ),
      child: SingleChildScrollView(
        child: Form(key: formKey,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 85),
                    child: Text('ENQUIRE NOW', style: AppTextStyle.black18_700),
                  ),
                  IconButton(onPressed: (){Get.back();},
                      icon: const Icon(Icons.cancel_rounded, size: 42)
                  ),

                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      maxLines: 7,
                      controller: messageController,

                      // mouseCursor: MouseCursor.defer,
                      validator: (msg) => Validation.normalValidation(msg!),
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      // cursorColor: ColorConst.primary,
                      decoration:
                      InputDecoration(
                        // label: Text('Type your enquiry message'),
                        // labelText: name,
                        labelStyle: AppTextStyle.hintText,
                        floatingLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorConst.label),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.grey)),
                        errorStyle: const TextStyle(),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 20),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.grey)),
                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.grey)),
                        hintText: 'Type your enquiry message*',
                        hintStyle: AppTextStyle.hintText,
                      ),
                    ),
                    const SizedBox(height: 70),
                    Row(
                      children: [
                        Expanded(child: Buttons.popupButton2(title: 'CANCEL', event: (){Get.back();}, width: 250)),
                        const SizedBox(width: 30),
                        Expanded(child: Buttons.popupButton(title: 'SUBMIT', event: (){
                          print('enquiry');
                          if(formKey.currentState!.validate()){
                            Get.back();
                            if(enqFrom == 'vehicle'){
                              enqController.postEnquiryData(
                                  toUserId: userID!, productId: productID!, enquiryType: 'vehicle', enquiryText: messageController.text);
                            }
                            if(enqFrom == 'sp'){
                              enqController.postEnquiryData(
                                  toUserId: userID!, productId: productID!, enquiryType: 'spare-part', enquiryText: messageController.text);
                            }
                            if(enqFrom == 'garage'){
                              enqController.postEnquiryData(
                                  toUserId: userID!, productId: productID!, enquiryType: 'garage', enquiryText: messageController.text);
                            }
                          }
                        }))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
