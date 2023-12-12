import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/wishlist_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Screen/Dashboard/Favourite/Wishlist/Garage/wishlist_garage_list.dart';
import '../../../../../Constraints/image_const.dart';
import '../../../../../GlobalWidgets/app_bar.dart';

class WishlistGarage extends StatelessWidget {
  WishlistGarage({Key? key}) : super(key: key);

  WishListController wishListController = Get.put(WishListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConst.back,
        appBar: CustomAppBar(title: 'Favourite Garage'),
        body: Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: GetBuilder(
            init: wishListController,
            initState: (controller){
              wishListController.getFavGarageListData();
            },
            builder: (value){
              return wishListController.fabGarageList.value.data == null?
                  SizedBox(
                    height: Get.height,
                    child: PRLoader.normalLoader(),
                  ):
              wishListController.fabGarageList.value.data!.likedGarages!.isEmpty?
              Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child:
                  Stack(
                    children: [
                      SvgPicture.asset(ImageConst.noGarage, height: 350),
                      const Positioned(right: 0, left: 0, bottom: 30,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
                            // SizedBox(height: 5),
                            // Text("I can't find what you are looking", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                          ],
                        ),
                      )
                    ],
                  )
                // Text('No Data Found', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: ColorConst.label),),
              ):
              ListView.builder(
                  shrinkWrap: true,
                  physics:  const BouncingScrollPhysics(),
                  itemCount: wishListController.fabGarageList.value.data!.likedGarages!.length,
                  itemBuilder: (context, index){
                    return  Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: WishlistGarageList(garages: wishListController.fabGarageList.value.data!.likedGarages![index]),
                    );
                  }
              );
            },
          )


        )
    );
  }
}
