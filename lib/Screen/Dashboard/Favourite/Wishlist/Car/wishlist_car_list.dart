import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/wishlist_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import '../../../../../Model/car_wishlist_model.dart';

class WishlistCarList extends StatelessWidget {
  WishlistCarList({Key? key, required this.likedVehicles}) : super(key: key);

  WishListController wishListController = Get.put(WishListController());
  LikedVehicles likedVehicles;
  String getFirstWords(String sentence, int wordCounts) {
    return sentence.split(" ").sublist(0, wordCounts).join(" ");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(onTap: (){Get.toNamed(AppRoute.carDetails, arguments: likedVehicles.vehicleId);},
          child: Container(
            // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                      child: Image.network(likedVehicles.vehiclePrimaryImageUrl!,
                        height: 115,
                        width: 130,
                        fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(ImageConst.noimage, height: 115, width: 130, fit: BoxFit.cover);
                          }
                      )),
                  const SizedBox(width: 15),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${likedVehicles.maker!.carMakerName!} - ${likedVehicles.model!.carModelName!}', style: AppTextStyle.header),
                      const SizedBox(height: 10),
                      Text('${likedVehicles.carFuelType!.carFuelTypeName!} | '
                          '${likedVehicles.engineSize!.carEngineSizeName!} | '
                          '${DateFormat('dd-MM-yyyy').format(DateTime.parse(likedVehicles.manufacturingYear!))} | '
                          '${likedVehicles.condition!.carConditionName!}', style: AppTextStyle.details),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                              children: [
                                TextSpan(text:"${likedVehicles.currency![likedVehicles.currency!.length - 1]} ", style: AppTextStyle.details),
                                TextSpan(text:"${likedVehicles.price}", style: AppTextStyle.detailsBlue),
                              ]
                          )
                      ),
                      // Row(
                      //   children: [
                      //     Text('K', style: AppTextStyle.details),
                      //     Text(' 12,000,000', style: AppTextStyle.detailsBlue),
                      //   ],
                      // ),
                      Text('Mileage : ${likedVehicles.mileage!} mph', style: AppTextStyle.details),
                      Text('${getFirstWords(likedVehicles.user!.role!.roleName!, 1)} Seller', style: AppTextStyle.details),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
        Positioned(right: 10, top: 10,
            child: GestureDetector(onTap: (){wishListController.getWishListCarData(
                vID: likedVehicles.vehicleId!,
              userID: likedVehicles.user!.userId == SharedPrefUtils.getUserId()?
                  '' : SharedPrefUtils.getUserId()!
            );},
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
