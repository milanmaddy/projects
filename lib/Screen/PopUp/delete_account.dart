import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/authentication_controller.dart';

import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/buttons.dart';

class DeleteAccount extends StatelessWidget {
  DeleteAccount({Key? key}) : super(key: key);

  AuthenticationController authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Container(height: 320,
      padding: const EdgeInsets.all(15).copyWith(bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 35,),
              Text('Delete Profile', style: AppTextStyle.black18_700),
              IconButton(onPressed: (){Get.back();},
                  icon: const Icon(Icons.cancel_rounded, size: 42)
              )
            ],
          ),
          const SizedBox(height: 50),
          const Text('Are you sure the account will be\ndeleted permanently?', textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23)),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Buttons.popupButton2(title: 'No', event: (){Get.back();}, width: 250)),
                const SizedBox(width: 30),
                Expanded(child: Buttons.popupButton(title: 'Yes', event: (){authController.delete();}))
              ],
            ),
          )
        ],
      ),
    );
  }
}
