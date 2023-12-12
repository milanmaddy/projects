import 'dart:async';
import 'package:get/get.dart';
import 'package:kawawa_motors/Routes/app_route.dart';

import '../Shared Pref/sharedpref_utils.dart';

class SplashController extends GetxController{
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Timer(const Duration(seconds: 3), () async{
      if (SharedPrefUtils.readPrefStr("showIntroduction") == "true"){
        if(SharedPrefUtils.isLoggedIn()){
          Get.offAllNamed(AppRoute.dashBoard);
        }else{
          Get.offAllNamed(AppRoute.dashBoard);
        }
      }else{
        Get.offAllNamed(AppRoute.intro);
      }
    });






    // Timer(const Duration(seconds: 3), () async {
    //   Get.offAndToNamed(AppRoute.intro);
    // });
  }
}