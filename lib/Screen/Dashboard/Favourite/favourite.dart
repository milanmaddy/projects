import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Routes/app_route.dart';

import '../../../GlobalWidgets/appbar_withoutback.dart';
import '../../../Constraints/color_const.dart';
import '../../../Constraints/image_const.dart';
import '../../../Constraints/text_style.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.back,
      appBar: AppBarBack(title: 'Favourite Service'),
      body: Padding(padding: const EdgeInsets.all(60).copyWith(top: 100),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap: (){Get.toNamed(AppRoute.wishlistCar);},
                  child: Container(height: 150, width: 161,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          Container(height: 75, width: 90,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: ColorConst.label, width: 2.5)
                            ),
                            child: SvgPicture.asset(ImageConst.car, height: 50),
                          ),
                          const SizedBox(height: 15),
                          Text('Vehicles', style: AppTextStyle.grid)

                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(onTap: (){Get.toNamed(AppRoute.wishlistSP);},
                  child: Container(height: 150, width: 161,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          Container(height: 75, width: 90,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: ColorConst.label, width: 2.5)
                            ),
                            child: SvgPicture.asset(ImageConst.sp, height: 50),
                          ),
                          const SizedBox(height: 15),
                          Text('Spare Parts', style: AppTextStyle.grid)

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap: (){Get.toNamed(AppRoute.wishlistGarage);},
                  child: Container(height: 150, width: 161,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          Container(height: 75, width: 90,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: ColorConst.label, width: 2.5)
                            ),
                            child: SvgPicture.asset(ImageConst.garage2, height: 50),
                          ),
                          const SizedBox(height: 15),
                          Text('Garages', style: AppTextStyle.grid)

                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(onTap: (){},
                  child: Container(height: 150, width: 161,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          Container(height: 75, width: 90,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: ColorConst.label, width: 2.5)
                            ),
                            child: SvgPicture.asset(ImageConst.rent, height: 50),
                          ),
                          const SizedBox(height: 15),
                          Text('Dealers', style: AppTextStyle.grid)

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
}
