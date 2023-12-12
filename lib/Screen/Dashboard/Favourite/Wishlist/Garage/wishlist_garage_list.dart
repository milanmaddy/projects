import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/garage_controller.dart';
import 'package:kawawa_motors/Controller/wishlist_controller.dart';
import '../../../../../Constraints/text_style.dart';
import '../../../../../Model/garage_wishlist_model.dart';
import '../../../../../Routes/app_route.dart';
import '../../../../../Shared Pref/sharedpref_utils.dart';


class WishlistGarageList extends StatelessWidget {
  WishlistGarageList({Key? key, required this.garages}) : super(key: key);

  LikedGarages garages;

  WishListController wishListController = Get.put(WishListController());
  GarageController garageController = Get.put(GarageController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(onTap: (){
          Get.toNamed(AppRoute.garageDetails, arguments: garages.garageId!);
          garageController.garageModel.value.data = null;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  garages.garagePrimaryImageUrl == null?
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(int.parse(garages.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                  ):
                  CircleAvatar(
                      radius: 50,
                      // backgroundColor: Color(int.parse(garages.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                      backgroundImage: NetworkImage(garages.garagePrimaryImageUrl!)
                    // AssetImage(ImageConst.g1),
                  ),
                  VerticalDivider(width: 40, color: Colors.grey.shade300, thickness: 2, indent: 5, endIndent: 5),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(garages.garageName!, style: AppTextStyle.header),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConst.call),
                          const SizedBox(width: 7),
                          Text(garages.user!.phoneNumber!, style: AppTextStyle.details)
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConst.mail),
                          const SizedBox(width: 7),
                          Text(garages.user!.emailAddress!, style: AppTextStyle.details)
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConst.web),
                          const SizedBox(width: 7),
                          Text(garages.websiteUrl == null?
                          'N/A':garages.websiteUrl.toString(), style: AppTextStyle.details)
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConst.pin),
                          const SizedBox(width: 7),
                          Text('${garages.city!.cityName}, ${garages.state!.stateName}, ${garages.country!.countryName}', style: AppTextStyle.details)
                        ],
                      ),

                    ],
                  )

                ],
              ),
            ),
          ),
        ),
        Positioned(right: 10, top: 10,
            child: GestureDetector(onTap: (){
              wishListController.getWishListGarageData(
                  garageID: garages.garageId!,
                  userID: garages.user!.userId == SharedPrefUtils.getUserId()?
                  '' : SharedPrefUtils.getUserId()!
              );
            },
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey.shade400,
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite, size: 17, color: Colors.red,),
                ),
              ),
            )
        )
      ],
    );
  }
}
