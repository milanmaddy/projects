import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/wishlist_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Screen/Dashboard/Favourite/Wishlist/Spare%20Parts/wishlist_sp_list.dart';
import '../../../../../Constraints/color_const.dart';
import '../../../../../GlobalWidgets/app_bar.dart';
import '../Car/wishlist_car_list.dart';

class WishListSP extends StatelessWidget {
  WishListSP({Key? key}) : super(key: key);

  WishListController wishListController = Get.put(WishListController());

  // final List img = [
  //   ImageConst.light,
  //   ImageConst.backlight,
  //   ImageConst.wheel,
  //   ImageConst.bmw,
  //   ImageConst.audi,
  // ];
  //
  // final List title = [
  //   'Audi A6 Back Light',
  //   'Audi A6 Back Light',
  //   'Audi A6 Back Light',
  //   'BMW Transmission',
  //   'Audi Transmission',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConst.back,
        appBar: CustomAppBar(title: 'Favourite Spare Parts'),
        body: Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child:
              GetBuilder(
                init: wishListController,
                initState: (controller){
                  wishListController.getFavSPListData();
                },
                  builder: (value){
                    return wishListController.fabSPList.value.data == null?
                        SizedBox(
                          height: Get.height,
                          child: PRLoader.normalLoader(),
                        ):
                        wishListController.fabSPList.value.data!.likedSpareParts!.isEmpty?
                    Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child:
                        Stack(
                          children: [
                            SvgPicture.asset(ImageConst.noSP, height: 350),
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
                        controller: wishListController.scrollController,
                        physics:  const BouncingScrollPhysics(),
                        itemCount: wishListController.fabSPList.value.data!.likedSpareParts!.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: WishlistSPList(spareParts: wishListController.fabSPList.value.data!.likedSpareParts![index]),
                          );
                        }
                    );
                  }
              )

        )
    );
  }
}
