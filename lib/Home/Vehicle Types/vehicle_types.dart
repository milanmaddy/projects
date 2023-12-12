import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';

import '../../Constraints/text_style.dart';

class VehicleType extends StatelessWidget {
  VehicleType({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Vehicle Types", style: AppTextStyle.bullet2),
        const SizedBox(height: 20),
        SizedBox(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.homeModel.value.data!.vehicleTypes!.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: GestureDetector(onTap: (){
                    Get.toNamed(
                        AppRoute.vType,
                        arguments: [
                          homeController.homeModel.value.data!.vehicleTypes![index].title!,
                          homeController.homeModel.value.data!.vehicleTypes![index].carTypeId]
                    );},
                    child: Container(color: Colors.transparent,
                      child: Column(
                        children: [
                          Image.network(homeController.homeModel.value.data!.vehicleTypes![index].image!, height: 45),
                          const SizedBox(height: 10),
                          Text(homeController.homeModel.value.data!.vehicleTypes![index].title!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: ColorConst.grey3, fontFamily: 'Nexa'),)
                        ],
                      ),
                    ),
                  )
                );
              }),
        )
      ],
    );
  }
}
