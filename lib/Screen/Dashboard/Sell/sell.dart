import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../../GlobalWidgets/appbar_withoutback.dart';
import '../../../Constraints/color_const.dart';
import '../../../Constraints/image_const.dart';

class Sell extends StatelessWidget {
   Sell({Key? key}) : super(key: key);

   MeController meController = Get.put(MeController());
   HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.back,
      appBar: AppBarBack(title: 'Add Your Sale'),
      body: RefreshIndicator(
        onRefresh: ()async{
          meController.getMeData();
        },
        child: Padding(padding: const EdgeInsets.all(60).copyWith(top: 100),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: (){Get.toNamed(AppRoute.sellCar);},
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

                  GestureDetector(onTap: (){Get.toNamed(AppRoute.sellSP);},
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
                  GestureDetector(onTap: (){Get.toNamed(AppRoute.sellGarage);},
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

                  GestureDetector(onTap: (){
                    // Get.toNamed(AppRoute.seeAllDealer, arguments: [homeController.newCountryID, '', '', '', '']);
                    },
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
      ),
    );
  }
}
