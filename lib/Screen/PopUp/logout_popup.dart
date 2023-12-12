import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/authentication_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/buttons.dart';

class LogoutPopup extends StatelessWidget {
  LogoutPopup({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  AuthenticationController authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Container(height: 260,
      padding: const EdgeInsets.all(15).copyWith(bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end ,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // SizedBox(width: 35,),
              // Text('Logout', style: AppTextStyle.black18_700),
              IconButton(onPressed: (){Get.back();},
                  icon: const Icon(Icons.cancel_rounded, size: 42)
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text('Are you sure\nyou want to logout?', textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23)),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Buttons.popupButton2(title: 'Cancel', event: (){Get.back();}, width: 250)),
                const SizedBox(width: 30),
                Expanded(child: Buttons.popupButton(title: 'Logout', event: (){
                  // SharedPrefUtils.logOut();
                  // // homeController.selectedIndex.value = 4;
                  // Get.offAllNamed(AppRoute.login);
                  Get.back();
                  authController.logout();
                }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
