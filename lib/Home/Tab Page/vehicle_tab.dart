import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/item_available_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';

class VehicleTab extends StatelessWidget {
  VehicleTab({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());

  @override
  Widget build(BuildContext context) {
    return homeController.homeModel.value.data!.vehicles!.isEmpty?
      const SizedBox():
      Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 160,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.homeModel.value.data!.vehicles!.length,
              itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(onTap: (){
                      Get.toNamed(
                          AppRoute.carDetails,
                          arguments: homeController.homeModel.value.data!.vehicles![index].vehicleId
                      );
                      },
                      child: Container(//padding: const EdgeInsets.all(10),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 0.2, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12)
                          // image: DecorationImage(image: AssetImage(ImageConst.classic1))
                        ),
                        child: IntrinsicWidth(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                  child: SizedBox(height: 90,
                                      child:
                                      Image.network(homeController.homeModel.value.data!.vehicles![index].vehiclePrimaryImageUrl!, fit: BoxFit.cover, width: Get.width,)
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${homeController.homeModel.value.data!.vehicles![index].maker!.carMakerName!}-${homeController.homeModel.value.data!.vehicles![index].model!.carModelName!}', style: AppTextStyle.productTitle),
                                    const SizedBox(height: 3),
                                    Text('${homeController.homeModel.value.data!.vehicles![index].currency![homeController.homeModel.value.data!.vehicles![index].currency!.length - 1]} ${homeController.homeModel.value.data!.vehicles![index].price}', style: AppTextStyle.productSubTitle),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    )
                );
              }),
        ),
        homeController.homeModel.value.data!.vehicles!.length >= 7?
        Padding(
          padding: const EdgeInsets.only(right: 15, top: 20),
          child: GestureDetector(onTap: (){
            seeAllController.seeAllVehicle.value.data = null;
            seeAllController.searchedCarMakerID = '';
            seeAllController.searchedCarMakerName = '';
            seeAllController.searchedCarModelID = '';
            seeAllController.searchedCarModelName = '';
            Get.toNamed(AppRoute.seeAllVehicle, arguments: [homeController.newCountryID, '', '', '']);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Show all', style: AppTextStyle.grey15_600),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 12, color: ColorConst.grey3)
              ],
            ),
          ),
        ):
        const SizedBox(),
      ],
    );
  }
}
