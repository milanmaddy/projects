import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/splash_controller.dart';
import '../../Constraints/color_const.dart';
import 'package:get/get.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(ImageConst.backPng2,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConst.logoP,
                  height: 90, width: 350,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 260),
                const Text('Welcome to', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const Text('Kawawa Motors', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(bottom: 110),
                  child: Text('The leading open digital vehicle market where anyone\ncan buy and sell cars with ease. ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                ),

              ],
            ),
          )

        ],
      )
    );
  }
}