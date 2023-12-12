import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../Controller/home_controller.dart';

class SparePartsTab extends StatelessWidget {
  SparePartsTab({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());

  @override
  Widget build(BuildContext context) {
    return homeController.homeModel.value.data!.spareParts!.isEmpty?
      const SizedBox():
      Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 170,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.homeModel.value.data!.spareParts!.length,
              itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(onTap: (){Get.toNamed(AppRoute.spDetails, arguments: homeController.homeModel.value.data!.spareParts![index].sparePartId);},
                      child: Container(//padding: const EdgeInsets.all(15),
                        width: 170,
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
                                      // CachedNetworkImage(
                                      //   imageUrl: homeController.homeModel.value.data!.spareParts![index].sparePartPrimaryImageUrl!,
                                      //   fit: BoxFit.cover,
                                      //   width: Get.width,
                                      //   placeholder: (context, url) {return SizedBox(
                                      //     height: Get.height, width: Get.width, child: const Center(child: CircularProgressIndicator()),
                                      //   );},
                                      // )
                                      Image.network(homeController.homeModel.value.data!.spareParts![index].sparePartPrimaryImageUrl!, fit: BoxFit.cover, width: Get.width,)
                                  )),
                              Padding(padding: EdgeInsets.all(10),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${homeController.homeModel.value.data!.spareParts![index].maker!.carMakerName!}-${homeController.homeModel.value.data!.spareParts![index].model!.carModelName!}', style: AppTextStyle.productTitle),
                                    const SizedBox(height: 3),
                                    Text('${homeController.homeModel.value.data!.spareParts![index].currency![homeController.homeModel.value.data!.spareParts![index].currency!.length - 1]} ${homeController.homeModel.value.data!.spareParts![index].price!}', style: AppTextStyle.productSubTitle),
                                  ],
                                ),
                              )
                              // Divider(height: 30, color: ColorConst.grey6),
                            ],
                          ),
                        ),
                      ),
                    )
                );
              }),
        ),
        homeController.homeModel.value.data!.spareParts!.length >= 7?
        Padding(
          padding: const EdgeInsets.only(right: 15, top: 20),
          child: GestureDetector(onTap: (){
            seeAllController.seeAllSparePart.value.data == null;
            seeAllController.searchedCarMakerID = '';
            seeAllController.searchedCarMakerName = '';
            seeAllController.searchedCarModelID = '';
            seeAllController.searchedCarModelName = '';
            Get.toNamed(AppRoute.seeAllSP, arguments: [homeController.newCountryID, '', '', '']);
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
