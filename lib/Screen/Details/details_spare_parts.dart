import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/chat_controller.dart';
import 'package:kawawa_motors/Controller/sp_controller.dart';
import 'package:kawawa_motors/Controller/wishlist_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/Details/rating.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/app_bar.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/loader.dart';
import '../PopUp/enquire_popup.dart';

class SPDetails extends StatelessWidget {
  SPDetails({Key? key}) : super(key: key);
  var aIndex = 0.obs;
  RxDouble rating = RxDouble(0);

  // int userRating = 5;

  String spId = Get.arguments;

  SparePartsController spController = Get.put(SparePartsController());
  WishListController wishListController = Get.put(WishListController());
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Spare Part Details'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        child: GetBuilder(
          init: spController,
            initState: (controller){
            spController.getSPDetailsData(spId: spId);
            },
            builder: (value){
              return spController.spModel.value.data == null?
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: PRLoader.normalLoader()),
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
                                autoPlay:false,
                                onPageChanged: (index, reason) {
                                  aIndex.value = index;
                                },
                              ),
                              itemCount: value.spModel.value.data!.sparePartImages!.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return Image.network(value.spModel.value.data!.sparePartImages![itemIndex].imageUrl!, fit: BoxFit.cover, width: MediaQuery.of(context).size.width,);
                                  // Image.asset(ImageConst.engine, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,);
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
                                count: value.spModel.value.data!.sparePartImages!.length,
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
                        padding: const EdgeInsets.all(30.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 200,
                                    child: Text('${value.spModel.value.data!.sparePart!.maker!.carMakerName!} - ${value.spModel.value.data!.sparePart!.model!.carModelName!}', style: AppTextStyle.black18_600, overflow: TextOverflow.ellipsis)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Obx(() =>  RatingBar.builder(
                                        initialRating: value.spModel.value.data!.sparePart!.averageRating != '' && value.spModel.value.data!.sparePart!.averageRating != null?
                                        double.parse(value.spModel.value.data!.sparePart!.averageRating.toString()):0,
                                        minRating: 1,
                                        ignoreGestures: true,
                                        itemSize: 25,
                                        direction: Axis.horizontal,
                                        // allowHalfRating: true,
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
                                      spController.spModel.value.data!.sparePart!.userId == SharedPrefUtils.getUserId().toString()?
                                      const SizedBox():
                                      value.spModel.value.data!.sparePart!.isRated == true?
                                      const SizedBox():
                                      GestureDetector(onTap: ()async{
                                        if(value.spModel.value.data!.sparePart!.isRated == true){
                                        }else{
                                          print(rating);
                                          spController.spModel.value.data == null;
                                          double finalRating = await Get.dialog(
                                            Dialog(insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent,
                                              child: Rating(ratingFrom: 'SP', productID: value.spModel.value.data!.sparePart!.sparePartId!),
                                            ),
                                            barrierDismissible: true);
                                          rating.value = finalRating;
                                        }
                                      },
                                        child: Container(width: 50, height: 17,
                                          decoration: BoxDecoration(
                                              color: value.spModel.value.data!.sparePart!.isRated == true?
                                                  Colors.grey.shade300:
                                              ColorConst.label,
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                          child: Center(
                                              child: value.spModel.value.data!.sparePart!.isRated == true?
                                              const Text('Rated', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black)):
                                              const Text('Rate Us', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                                              )),
                                        ),
                                      ): const SizedBox()
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SharedPrefUtils.isLoggedIn()?
                            Row(
                              children: [
                                spController.spModel.value.data!.sparePart!.userId == SharedPrefUtils.getUserId().toString()?
                                    const SizedBox():
                                Obx(() => spController.spModel.value.data!.sparePart!.isLiked.value?
                                GestureDetector(onTap: (){
                                  wishListController.getWishListSPData(
                                      spID: spId,
                                      userID: spController.spModel.value.data!.sparePart!.userId == SharedPrefUtils.getUserId()?
                                      '' : SharedPrefUtils.getUserId()!
                                  );
                                  spController.spModel.value.data!.sparePart!.isLiked.value =
                                  !spController.spModel.value.data!.sparePart!.isLiked.value;
                                },
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey.shade300,
                                    child: const Icon(Icons.favorite, size: 27,
                                        color: Colors.red),
                                  ),
                                ):
                                GestureDetector(onTap: (){
                                  wishListController.getWishListSPData(
                                      spID: spId,
                                      userID: spController.spModel.value.data!.sparePart!.userId == SharedPrefUtils.getUserId()?
                                      '' : SharedPrefUtils.getUserId()!
                                  );
                                  spController.spModel.value.data!.sparePart!.isLiked.value =
                                  !spController.spModel.value.data!.sparePart!.isLiked.value;
                                },
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey.shade300,
                                    child: const Icon(Icons.favorite, size: 27,
                                        color: Colors.white),
                                  ),
                                ),),
                                const SizedBox(width: 15),
                                spController.spModel.value.data!.sparePart!.user!.userId == SharedPrefUtils.getUserId()?
                                const SizedBox():
                                GestureDetector(onTap: (){
                                  // chatController.oneToOneChat(inboxID: spController.spModel.value.data!.sparePart!.user!.userId!);
                                  Get.toNamed(AppRoute.chatPage,
                                    arguments: [
                                      spController.spModel.value.data!.sparePart!.inboxId == ''?
                                      '0': spController.spModel.value.data!.sparePart!.inboxId,
                                      spController.spModel.value.data!.sparePart!.user!.profileImageUrl!,
                                      spController.spModel.value.data!.sparePart!.user!.businessAccount == null?
                                      spController.spModel.value.data!.sparePart!.user!.fullName:
                                      spController.spModel.value.data!.sparePart!.user!.businessAccount!.businessName,
                                      spController.spModel.value.data!.sparePart!.user!.userSettings!.isOnline,
                                      spController.spModel.value.data!.sparePart!.user!.userId!,
                                      spController.spModel.value.data!.sparePart!.user!.userColor!.userNameColorHexCode,
                                      spController.spModel.value.data!.sparePart!.user!.userColor!.backgroundHexCode,
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
                      Container(color: Colors.white,
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Contact Person:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Text(value.spModel.value.data!.sparePart!.user!.fullName!, style: AppTextStyle.grey15_600)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Model:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Text(value.spModel.value.data!.sparePart!.model!.carModelName!, style: AppTextStyle.grey15_600)),
                          ],
                        ),
                      ),
                      Container(color: Colors.white,
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Maker:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Text(value.spModel.value.data!.sparePart!.maker!.carMakerName!, style: AppTextStyle.grey15_600)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Condition:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Text(value.spModel.value.data!.sparePart!.condition!.carConditionName!, style: AppTextStyle.grey15_600)),
                          ],
                        ),
                      ),
                      Container(color: Colors.white,
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Category:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Text(value.spModel.value.data!.sparePart!.category!.categoryTitle!, style: AppTextStyle.grey15_600)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Subcategory:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Text(value.spModel.value.data!.sparePart!.subCategory!.subCategoryTitle!, style: AppTextStyle.grey15_600)),
                          ],
                        ),
                      ),
                      Container(color: Colors.white,
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Manufacture Year:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(value.spModel.value.data!.sparePart!.manufacturingYear!)), style: AppTextStyle.grey15_600)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Price:', style: AppTextStyle.black15_600_2)),
                            Expanded(child: Row(
                              children: [
                                Text('${value.spModel.value.data!.sparePart!.currency![value.spModel.value.data!.sparePart!.currency!.length - 1]} ', style: AppTextStyle.grey15_600),
                                Text(value.spModel.value.data!.sparePart!.price!, style: AppTextStyle.detailsOrange),
                              ],
                            )),
                          ],
                        ),
                      ),

                      // RichText(
                      //     text: TextSpan(
                      //         style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                      //         children: [
                      //           TextSpan(text:"K ", style: AppTextStyle.grey15_600),
                      //           TextSpan(text:"1000", style: AppTextStyle.detailsOrange),
                      //         ]
                      //     )
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Small Description', style: AppTextStyle.black18_600),
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
                                        child: SvgPicture.asset(ImageConst.mail, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Email ID', style: AppTextStyle.black16_600),
                                          const SizedBox(height: 5),
                                          Text(value.spModel.value.data!.sparePart!.user!.emailAddress!, style: AppTextStyle.grey12_400),
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
                                          Text(value.spModel.value.data!.sparePart!.user!.phoneNumber!, style: AppTextStyle.grey12_400),
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
                                          Text('${value.spModel.value.data!.sparePart!.city!.cityName}, ${value.spModel.value.data!.sparePart!.state!.stateName}, ${value.spModel.value.data!.sparePart!.country!.countryName}', style: AppTextStyle.grey12_400),
                                        ],
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
                                            Text(value.spModel.value.data!.sparePart!.description!, style: AppTextStyle.grey12_400),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SharedPrefUtils.isLoggedIn()?
                            spController.spModel.value.data!.sparePart!.userId == SharedPrefUtils.getUserId().toString()?
                            const SizedBox():
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Center(child: Buttons.actionButtons(title: 'ENQUIRE NOW', event: (){Get.bottomSheet(EnquirePopup(
                                enqFrom: 'sp',
                                productID: spId,
                                userID: spController.spModel.value.data!.sparePart!.userId,
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
