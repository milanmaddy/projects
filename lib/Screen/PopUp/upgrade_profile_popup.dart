import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/Routes/app_route.dart';

class UpgradeProfile extends StatelessWidget {
  const UpgradeProfile({Key? key}) : super(key: key);

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
              Text('UPGRADE PROFILE', style: AppTextStyle.black18_700),
              IconButton(onPressed: (){Get.back();},
                  icon: const Icon(Icons.cancel_rounded, size: 42)
              )
            ],
          ),
          const SizedBox(height: 50),
          const Text('Are you sure you want to upgrade to\nbusiness profile?', textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23)),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Buttons.popupButton2(title: 'No', event: (){Get.back();}, width: 250)),
                const SizedBox(width: 30),
                Expanded(child: Buttons.popupButton(title: 'Yes', event: (){Get.back(); Get.toNamed(AppRoute.businessProfile);}))
              ],
            ),
          )
        ],
      ),
    );
  }
}
