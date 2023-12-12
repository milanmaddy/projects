import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/dropdown_popup.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field_2.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';

import '../../Controller/broadcast_controller.dart';
import '../../GlobalWidgets/dropdown.dart';
import '../../Model/static_type_model.dart';

class CreateBroadcast extends StatelessWidget {
  CreateBroadcast({Key? key}) : super(key: key);

  TextEditingController messageController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  BroadcastController broadcastController = Get.put(BroadcastController());
  final formKey = GlobalKey<FormState>();
  // var type = ''.obs;
  String bType = '';

  var charLength = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Create Broadcast'),
      backgroundColor: ColorConst.back,
      body: Column(
        children: [
          Container(padding: const EdgeInsets.symmetric(vertical: 12).copyWith(left: 30, bottom: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: const Offset(0, 2)
                )
              ]
            ),
            child: Row(
              children: [
                Text('What ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: ColorConst.grey3)),
                const SizedBox(width: 2),
                Text('Are You Looking For ?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: ColorConst.label)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Form(key: formKey,
              child: Column(
                children: [
                  CustomDropDownnn(
                    enablePopup: true,
                    labelText: 'Type',
                    controller: typeController,
                    titleList: ['Vehicles', 'Spare Parts', 'Garages'],
                    objectList: ['vehicle', 'spare-part', 'garage'],
                    validation: (type) => Validation.normalValidation(type),
                    function: (type){
                      bType = type;
                      print('type is: $bType');
                      // type = type;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomInputField2(controller: messageController, labelText: 'Type Your Message*', maxLine: 3, onChanged: (value){charLength.value = value.length;}, labelBackColor: ColorConst.back, iF: [LengthLimitingTextInputFormatter(100),],
                      validation: (message) => Validation.normalValidation(message)),
                  const SizedBox(height: 10),
                  Align(alignment: Alignment.centerRight,
                      child: Obx(() => Text('${charLength.value}/100',
                        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),))
                  ),
                  const SizedBox(height: 50),
                  Buttons.actionButtons(title: 'BROADCAST NOW', event: (){
                    if(formKey.currentState!.validate()){
                      broadcastController.addBroadcastData(
                          bText: messageController.text, bType: bType);
                    }
                  // print(typeController.text);
                  }
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
