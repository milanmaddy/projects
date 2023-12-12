import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';

class PRLoader{

  static Widget normalLoader(){
    return
    Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(ImageConst.loaderLogo, height: 25, width: 25),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorConst.label),
            strokeWidth: 3,
          )
        ],
      ),
    );
  }
  static Widget circleLoader(){
    return
      Center(
        child: CircularProgressIndicator()
      );
  }

  static show(){
    Get.dialog(Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
            child:SizedBox(height: 50, width: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(ImageConst.loaderLogo, fit: BoxFit.cover, height: 30, width: 30),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ColorConst.label),
                    strokeWidth: 2,
                  )
                ],
              ),
            )
        )),
        barrierDismissible: false);
  }

  static hide(){
    Get.back();
  }

  static LOADER_ON(){
    return AlertDialog( 
      content: Center(
          child:SizedBox(height: 50, width: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(ImageConst.loaderLogo, fit: BoxFit.cover, height: 30, width: 30),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(ColorConst.label),
                  strokeWidth: 2,
                )
              ],
            ),
          )
      )
    );
  }
}