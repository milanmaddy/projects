import 'package:flutter/material.dart';
import 'package:kawawa_motors/Controller/wishlist_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import '../../../../../Constraints/text_style.dart';
import 'package:get/get.dart';

import '../../../../../Model/sp_wishlist_model.dart';

class WishlistSPList extends StatelessWidget {
  WishlistSPList({Key? key, required this.spareParts}) : super(key: key);

  LikedSpareParts spareParts;
  WishListController wishListController = Get.put(WishListController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(onTap: (){Get.toNamed(AppRoute.spDetails, arguments: spareParts.sparePartId!);},
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
                      child: Image.network(spareParts.sparePartPrimaryImageUrl!,
                          height: 115,
                          width: 130,
                          fit: BoxFit.cover)),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('${spareParts.maker!.carMakerName} - ${spareParts.model!.carModelName}', style: AppTextStyle.header),
                        const SizedBox(height: 10),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'SF'), //style for all textspan
                                children: [
                                  TextSpan(text:"${spareParts.currency![spareParts.currency!.length - 1]} ", style: AppTextStyle.details),
                                  TextSpan(text:"${spareParts.price}", style: AppTextStyle.detailsBlue),
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                                children: [
                                  TextSpan(text:"Location: ", style: AppTextStyle.details),
                                  TextSpan(text:"${spareParts.city!.cityName}, ${spareParts.state!.stateName}, ${spareParts.country!.countryName}", style: AppTextStyle.details),
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                                children: [
                                  TextSpan(text:"Category: ", style: AppTextStyle.details),
                                  TextSpan(text:"${spareParts.category!.categoryTitle}", style: AppTextStyle.details),
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                                children: [
                                  TextSpan(text:"Sub Category: ", style: AppTextStyle.details),
                                  TextSpan(text:"${spareParts.subCategory!.subCategoryTitle}", style: AppTextStyle.details),
                                ]
                            )
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
        Positioned(right: 10, top: 10,
            child: GestureDetector(onTap: (){
              wishListController.getWishListSPData(
                  spID: spareParts.sparePartId!,
                userID: spareParts.user!.userId == SharedPrefUtils.getUserId()?
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
