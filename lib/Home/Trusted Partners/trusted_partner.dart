import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/scroll_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/trim_name.dart';
import 'package:kawawa_motors/Routes/app_route.dart';

import '../../Constraints/color_const.dart';
import '../../Constraints/text_style.dart';

class TrustedPartner extends StatelessWidget {
  TrustedPartner({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());

  var aIndex = 0.obs;

  SlideController slideController = Get.put(SlideController());

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Trusted Partners ', style: AppTextStyle.bullet2),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(onTap: (){
                seeAllController.stateName = '';
                seeAllController.cityName = '';
                seeAllController.bTypeName = '';
                seeAllController.stateID = '';
                seeAllController.businessTypeID = '';
                seeAllController.cityID = '';
                Get.toNamed(AppRoute.seeAllDealer, arguments: [homeController.newCountryID, '', '', '', '']);
                },
                child: Row(
                  children: [
                    Text('Show all', style: AppTextStyle.grey15_600),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 12, color: ColorConst.grey3)
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: ListView.builder(
            controller: slideController.scrollController,
              padding: const EdgeInsets.only(bottom: 1),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.homeModel.value.data!.trustedPartners!.length,
              itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(onTap: (){Get.toNamed(AppRoute.dealerDetails, arguments: homeController.homeModel.value.data!.trustedPartners![index].userId);},
                      child: Container(padding: const EdgeInsets.all(8).copyWith(left: 15),
                        width: 210,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.2, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12)
                          // image: DecorationImage(image: AssetImage(ImageConst.classic1))
                        ),
                        child: Row(
                          children: [
                            homeController.homeModel.value.data!.trustedPartners![index].profileImageUrl! == ''?
                            CircleAvatar(
                              backgroundColor: Color(int.parse(homeController.homeModel.value.data!.trustedPartners![index].userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                              // backgroundImage: AssetImage(''),
                            radius: 25,
                              child: Center(
                                  child: Text(TrimName.getInitials(homeController.homeModel.value.data!.trustedPartners![index].fullName!.toUpperCase()),
                                    style: TextStyle(
                                        color: Color(int.parse(homeController.homeModel.value.data!.trustedPartners![index].userColor!.userNameColorHexCode!.replaceFirst('#', "0XFF"))),
                                    ),
                                  )
                              )):
                            CircleAvatar(
                                backgroundImage: AssetImage(homeController.homeModel.value.data!.trustedPartners![index].profileImageUrl!),
                                radius: 25),
                                // child:
                            const SizedBox(width: 10),
                            SizedBox(width: 120,
                                child: Text(homeController.homeModel.value.data!.trustedPartners![index].fullName!, style: AppTextStyle.bullet2, overflow: TextOverflow.ellipsis,)),
                          ],
                        ),
                      ),
                    )
                );
              }),
        ),
      ],

    );
  }

  // scrollToBottom() {
  //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
  // }
}
