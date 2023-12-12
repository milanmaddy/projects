import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/garage_controller.dart';
import 'package:kawawa_motors/Controller/wishlist_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/Screen/Details/rating.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../Controller/chat_controller.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/loader.dart';
import '../../Routes/app_route.dart';
import '../PopUp/enquire_popup.dart';

class GarageDetails extends StatelessWidget {
  GarageDetails({Key? key}) : super(key: key);

  GarageController garageController = Get.put(GarageController());
  WishListController wishListController = Get.put(WishListController());
  ChatController chatController = Get.put(ChatController());

  String gid = Get.arguments;

  var aIndex = 0.obs;
  RxDouble rating = RxDouble(0);

  // List thumbnail = [];
  // thumbnail.insert(index, element)

  String getFirstWords(String sentence, int wordCounts) {
    return sentence.split(" ").sublist(0, wordCounts).join(" ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Garage Details'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        child: GetBuilder(
          init: garageController,
            initState: (controller){
            garageController.getGarageDetailsData(gid: gid);
            },
            builder: (value){
              return garageController.garageModel.value.data == null?
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: PRLoader.normalLoader())
              ):
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
                        child: SizedBox(width: MediaQuery.of(context).size.height,
                          child: CarouselSlider.builder(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                autoPlay:true,
                                onPageChanged: (index, reason) {
                                  aIndex.value = index;
                                },
                              ),
                              itemCount: value.garageModel.value.data!.garage!.images!.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return Image.network(value.garageModel.value.data!.garage!.images![itemIndex].imageUrl!,
                                    fit: BoxFit.cover, width: MediaQuery.of(context).size.width);
                              }),
                        ),
                      ),

                      Positioned(
                        bottom: 8,
                        right: 0.0,
                        left: 0.0,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:Obx(() =>  AnimatedSmoothIndicator(
                                activeIndex: aIndex.value,
                                count: value.garageModel.value.data!.garage!.images!.length,
                                effect: WormEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    spacing: 5,
                                    activeDotColor: ColorConst.button,
                                    dotColor: Colors.white),
                              ))
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0).copyWith(bottom: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value.garageModel.value.data!.garage!.garageName!, style: AppTextStyle.black18_600),
                                const SizedBox(height: 10),
                                Row(crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Obx(() => RatingBar.builder(
                                      initialRating: value.garageModel.value.data!.garage!.averageRating != ''?
                                      double.parse(value.garageModel.value.data!.garage!.averageRating.toString()):0,
                                      minRating: 1,
                                      ignoreGestures: true,
                                      itemSize: 25,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      itemBuilder: (context, _){
                                        return const Icon(Icons.star, color: Colors.amber);
                                      },
                                      onRatingUpdate: (value) {
                                        print(value);
                                      },
                                    )),
                                    const SizedBox(width: 20),
                                    SharedPrefUtils.isLoggedIn()?
                                    garageController.garageModel.value.data!.garage!.userId == SharedPrefUtils.getUserId().toString()?
                                    const SizedBox():
                                    value.garageModel.value.data!.garage!.isRated == true?
                                    const SizedBox():
                                    GestureDetector(onTap: ()async{
                                      if(value.garageModel.value.data!.garage!.isRated == true){

                                      }else{
                                        print(rating);
                                        final finalRating = await Get.dialog(Dialog(insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent,
                                            child: Rating(ratingFrom: 'G', productID: value.garageModel.value.data!.garage!.garageId!)),
                                          barrierDismissible: true, );

                                        if(finalRating != null){
                                          rating.value = finalRating;
                                        }
                                      }
                                    },
                                      child: Container(width: 50, height: 17,
                                        decoration: BoxDecoration(
                                            color: value.garageModel.value.data!.garage!.isRated == true?
                                            Colors.grey.shade300:
                                            ColorConst.label,
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Center(
                                          child: value.garageModel.value.data!.garage!.isRated == true?
                                          const Text('Rated', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black)):
                                          const Text('Rate Us', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ): const SizedBox()
                                  ],
                                ),

                              ],
                            ),
                            SharedPrefUtils.isLoggedIn()?
                            Row(
                              children: [
                                garageController.garageModel.value.data!.garage!.userId == SharedPrefUtils.getUserId().toString()?
                                const SizedBox():
                                garageController.garageModel.value.data!.garage!.isLiked.value?
                                GestureDetector(onTap: (){
                                  wishListController.getWishListGarageData(
                                      garageID: gid,
                                    userID: garageController.garageModel.value.data!.garage!.userId == SharedPrefUtils.getUserId()?
                                        '' : SharedPrefUtils.getUserId()!
                                  );
                                  garageController.garageModel.value.data!.garage!.isLiked.value =
                                  !garageController.garageModel.value.data!.garage!.isLiked.value;
                                },
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey.shade300,
                                    child: const Icon(Icons.favorite, size: 27,
                                        color: Colors.red
                                    ),
                                  ),
                                ):
                                GestureDetector(onTap: (){
                                  wishListController.getWishListGarageData(
                                      garageID: gid,
                                      userID: garageController.garageModel.value.data!.garage!.userId == SharedPrefUtils.getUserId()?
                                      '' : SharedPrefUtils.getUserId()!
                                  );
                                  garageController.garageModel.value.data!.garage!.isLiked.value =
                                  !garageController.garageModel.value.data!.garage!.isLiked.value;
                                },
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey.shade300,
                                    child: const Icon(Icons.favorite, size: 27,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                GestureDetector(onTap: (){
                                  Get.toNamed(AppRoute.chatPage,
                                      arguments: [
                                        garageController.garageModel.value.data!.garage!.inboxId == ''?
                                        '0': garageController.garageModel.value.data!.garage!.inboxId,
                                        garageController.garageModel.value.data!.garage!.user!.profileImageUrl!,
                                        garageController.garageModel.value.data!.garage!.user!.businessAccount == null?
                                        garageController.garageModel.value.data!.garage!.user!.fullName:
                                        garageController.garageModel.value.data!.garage!.user!.businessAccount!.businessName,
                                        garageController.garageModel.value.data!.garage!.user!.userSettings!.isOnline,
                                        garageController.garageModel.value.data!.garage!.user!.userId!,
                                        garageController.garageModel.value.data!.garage!.user!.userColor!.userNameColorHexCode,
                                        garageController.garageModel.value.data!.garage!.user!.userColor!.backgroundHexCode,
                                      ]
                                  );
                                },
                                    child: SvgPicture.asset(ImageConst.chat2)
                                ),
                              ],
                            ):
                            const SizedBox()
                          ],
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // Text('Contact person: Mr Paresh Mamtora', style: AppTextStyle.grey15_600),
                      // Divider(
                      //   height: 50, thickness: 2, color: Colors.grey.shade300,
                      // ),
                      Container(color: Colors.white,
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Contact Person:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Text(value.garageModel.value.data!.garage!.contactPersonName!, style: AppTextStyle.grey15_600)),
                          ],
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Information', style: AppTextStyle.black18_600),
                                const SizedBox(width: 5),
                                Text('Since ${value.garageModel.value.data!.garage!.updatedAt!.substring(0,4)}',
                                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 20)),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(height: 45, width: 45,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.web2, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Website', style: AppTextStyle.black16_600),
                                          const SizedBox(height: 5),
                                          SizedBox(width: 300,
                                            child: Text(value.garageModel.value.data!.garage!.websiteUrl == ""?
                                                'N/A': value.garageModel.value.data!.garage!.websiteUrl.toString()
                                                , style: AppTextStyle.grey12_400, overflow: TextOverflow.ellipsis),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(height: 30),
                                  Row(
                                    children: [
                                      Container(height: 45, width: 45,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.mail, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Email ID', style: AppTextStyle.black16_600),
                                          const SizedBox(height: 5),
                                          Text(value.garageModel.value.data!.garage!.contactPersonEmail!, style: AppTextStyle.grey12_400),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(height: 30),
                                  Row(
                                    children: [
                                      Container(height: 45, width: 45,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.call, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Mobile No', style: AppTextStyle.black16_600),
                                          const SizedBox(height: 5),
                                          Text(value.garageModel.value.data!.garage!.contactPersonNumber!, style: AppTextStyle.grey12_400),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(height: 45, width: 45,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.office, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Address', style: AppTextStyle.black16_600),
                                          const SizedBox(height: 5),
                                          Text('${value.garageModel.value.data!.garage!.city!.cityName}, ${value.garageModel.value.data!.garage!.state!.stateName}, ${value.garageModel.value.data!.garage!.country!.countryName}', style: AppTextStyle.grey12_400),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(height: 30),
                                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(height: 45, width: 45,
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.service, color: ColorConst.label),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Services', style: AppTextStyle.black16_600),
                                            const SizedBox(height: 5),
                                            Text(value.garageModel.value.data!.garage!.services!, style: AppTextStyle.grey12_400),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(height: 30),
                                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(height: 45, width: 45,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.doc, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Flexible(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Description', style: AppTextStyle.black16_600),
                                            const SizedBox(height: 5),
                                            Text(
                                                value.garageModel.value.data!.garage!.description == ''?
                                                'N/A':
                                                value.garageModel.value.data!.garage!.description!,
                                                style: AppTextStyle.grey12_400),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(height: 30),
                                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(height: 45, width: 45,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.clock, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Flexible(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Time', style: AppTextStyle.black16_600),
                                            const SizedBox(height: 5),
                                            Text('${value.garageModel.value.data!.garage!.garageStartTime} - ${value.garageModel.value.data!.garage!.garageEndTime}',
                                                style: AppTextStyle.grey12_400),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SharedPrefUtils.isLoggedIn()?
                            garageController.garageModel.value.data!.garage!.userId == SharedPrefUtils.getUserId().toString()?
                            const SizedBox():
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Center(child: Buttons.actionButtons(title: 'ENQUIRE NOW', event: (){Get.bottomSheet(EnquirePopup(
                                enqFrom: 'garage',
                                userID: garageController.garageModel.value.data!.garage!.userId,
                                productID: gid,
                              ));})),
                            ):
                            const SizedBox()
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            }
        )
      ),
    );
  }
}
