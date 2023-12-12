import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../Controller/home_controller.dart';
import '../../Routes/app_route.dart';

class RepairGarageTab extends StatelessWidget {
  RepairGarageTab({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());

  @override
  Widget build(BuildContext context) {
    return homeController.homeModel.value.data!.garages!.isEmpty?
      const  SizedBox():
      Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.homeModel.value.data!.garages!.length,
              itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(onTap: (){Get.toNamed(AppRoute.garageDetails, arguments: homeController.homeModel.value.data!.garages![index].garageId);},
                      child: Container(padding: const EdgeInsets.all(15),
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 0.2, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12)
                          // image: DecorationImage(image: AssetImage(ImageConst.classic1))
                        ),
                        child: IntrinsicWidth(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child:
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(homeController.homeModel.value.data!.garages![index].garagePrimaryImageUrl!)
                                  // NetworkImage(homeController.homeModel.value.data!.garages![index].garagePrimaryImageUrl!),
                                ),
                              ),
                              Divider(height: 30, color: ColorConst.grey6),
                              Text(homeController.homeModel.value.data!.garages![index].garageName!, style: AppTextStyle.productTitle),
                              const SizedBox(height: 5),
                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(ImageConst.call),
                                  const SizedBox(width: 3),
                                  Text(homeController.homeModel.value.data!.garages![index].contactPersonNumber!, style: AppTextStyle.productSubTitle),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                );
              }),
        ),
        homeController.homeModel.value.data!.garages!.length >= 7?
        Padding(
          padding: const EdgeInsets.only(right: 15, top: 20),
          child: GestureDetector(onTap: (){
            seeAllController.seeAllGarage.value.data = null;
            seeAllController.stateName = '';
            seeAllController.stateID = '';
            seeAllController.cityName = '';
            seeAllController.cityID = '';
            Get.toNamed(AppRoute.seeAllRG, arguments: [homeController.newCountryID, '', '', '']);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Show all', style: AppTextStyle.grey15_600),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 12, color: ColorConst.grey3, )
              ],
            ),
          ),
        ):
        const SizedBox(),
      ],
    );
  }
}
