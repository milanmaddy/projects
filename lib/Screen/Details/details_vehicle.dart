import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/Controller/chat_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/Controller/wishlist_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Screen/Details/rating.dart';
import 'package:kawawa_motors/Screen/PopUp/enquire_popup.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Constraints/color_const.dart';
import '../../Routes/app_route.dart';

class VehicleDetails extends StatelessWidget {
  VehicleDetails({Key? key}) : super(key: key);

  VehicleController vehicleController = Get.put(VehicleController());
  WishListController wishListController = Get.put(WishListController());
  ChatController chatController = Get.put(ChatController());

  String getFirstWords(String sentence, int wordCounts) {
    return sentence.split(" ").sublist(0, wordCounts).join(" ");
  }

  var aIndex = 0.obs;
  var heart = false.obs;
  RxDouble rating = RxDouble(0);

  String vehicleId = Get.arguments;

  // String accountType = vehicleController.vehicleModel.value.data!.vehicle!.user!.role!.roleName!.toString();


  @override
  Widget build(BuildContext context) {
    // print(vehicleController.vehicleModel.value.data!.vehicle!.country!.countryId);
    return Scaffold(
      backgroundColor: ColorConst.back,
      // backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Vehicle Details'),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: vehicleController,
          initState: (controller){
            vehicleController.getVehicleDetailsData(vid: vehicleId);
          },
            builder: (value){
              return value.vehicleModel.value.data == null?
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
                                autoPlay:true,
                                onPageChanged: (index, reason) {
                                  aIndex.value = index;
                                },
                              ),
                              itemCount: value.vehicleModel.value.data!.vehicleImages!.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return
                                  Image.network(value.vehicleModel.value.data!.vehicleImages![itemIndex].imageUrl!, fit: BoxFit.cover, width: MediaQuery.of(context).size.width,);
                                // Image.asset(ImageConst.vehicle, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,);
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
                                count: value.vehicleModel.value.data!.vehicleImages!.length,
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
                  // Adds(),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0).copyWith(bottom: 0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 280,
                                    child: Text('${value.vehicleModel.value.data!.vehicle!.maker!.carMakerName!} - ${value.vehicleModel.value.data!.vehicle!.model!.carModelName!}', style: AppTextStyle.black18_600, overflow: TextOverflow.ellipsis,)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Obx(() => RatingBar.builder(
                                        initialRating: value.vehicleModel.value.data!.vehicle!.averageRating != ''?
                                        double.parse(value.vehicleModel.value.data!.vehicle!.averageRating.toString()):0,
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
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),),
                                      const SizedBox(width: 20),
                                      SharedPrefUtils.isLoggedIn()?
                                      vehicleController.vehicleModel.value.data!.vehicle!.user!.userId == SharedPrefUtils.getUserId()?
                                      const SizedBox():
                                      value.vehicleModel.value.data!.vehicle!.isRated == true?
                                      const SizedBox():
                                      GestureDetector(onTap: ()async{
                                        if(value.vehicleModel.value.data!.vehicle!.isRated == true){

                                        }else{
                                          print(rating);
                                          final finalRating = await Get.dialog(Dialog(insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent,
                                              child: Rating(ratingFrom: 'V', productID: value.vehicleModel.value.data!.vehicle!.vehicleId!)),
                                            barrierDismissible: true, );

                                          if(finalRating != null){
                                            rating.value = finalRating;
                                          }
                                        }
                                      },
                                        child: Container(width: 50, height: 17,
                                          decoration: BoxDecoration(
                                              color: value.vehicleModel.value.data!.vehicle!.isRated == true?
                                              Colors.grey.shade300:
                                              ColorConst.label,
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                          child: Center(
                                            child: value.vehicleModel.value.data!.vehicle!.isRated == true?
                                            const Text('Rated', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black)):
                                            const Text('Rate Us', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                                          ),
                                        ),
                                      )): const SizedBox()
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SharedPrefUtils.isLoggedIn()?
                            Row(
                              children: [
                                vehicleController.vehicleModel.value.data!.vehicle!.user!.userId == SharedPrefUtils.getUserId()?
                                const SizedBox():
                                Obx(() => vehicleController.vehicleModel.value.data!.vehicle!.isLiked.value?
                                GestureDetector(onTap: (){
                                  wishListController.getWishListCarData(
                                      vID: vehicleId,
                                    userID: vehicleController.vehicleModel.value.data!.vehicle!.user!.userId == SharedPrefUtils.getUserId()?
                                        '' : SharedPrefUtils.getUserId()!
                                  );
                                  vehicleController.vehicleModel.value.data!.vehicle!.isLiked.value =
                                      !vehicleController.vehicleModel.value.data!.vehicle!.isLiked.value;
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
                                  wishListController.getWishListCarData(
                                      vID: vehicleId,
                                      userID : vehicleController.vehicleModel.value.data!.vehicle!.user!.userId == SharedPrefUtils.getUserId()?
                                      '' : SharedPrefUtils.getUserId()!
                                  );
                                  vehicleController.vehicleModel.value.data!.vehicle!.isLiked.value =
                                  !vehicleController.vehicleModel.value.data!.vehicle!.isLiked.value;
                                  // vehicleController.vehicleModel.value.data!.vehicle!.isLiked.value =
                                  //     !vehicleController.vehicleModel.value.data!.vehicle!.isLiked.value;
                                },
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey.shade300,
                                    child: const Icon(Icons.favorite, size: 27,
                                        color: Colors.white
                                    ),
                                  ),
                                )
                                ),
                                const SizedBox(width: 15),
                                vehicleController.vehicleModel.value.data!.vehicle!.user!.userId == SharedPrefUtils.getUserId()?
                                const SizedBox():
                                GestureDetector(onTap: (){
                                  Get.toNamed(AppRoute.chatPage,
                                      arguments: [
                                        vehicleController.vehicleModel.value.data!.vehicle!.inboxId == ''?
                                        '0': vehicleController.vehicleModel.value.data!.vehicle!.inboxId,
                                        vehicleController.vehicleModel.value.data!.vehicle!.user!.profileImageUrl!,
                                        vehicleController.vehicleModel.value.data!.vehicle!.user!.businessAccount == null?
                                        vehicleController.vehicleModel.value.data!.vehicle!.user!.fullName:
                                        vehicleController.vehicleModel.value.data!.vehicle!.user!.businessAccount!.businessName,
                                        vehicleController.vehicleModel.value.data!.vehicle!.user!.userSettings!.isOnline,
                                        vehicleController.vehicleModel.value.data!.vehicle!.user!.userId!,
                                        vehicleController.vehicleModel.value.data!.vehicle!.user!.userColor!.userNameColorHexCode,
                                        vehicleController.vehicleModel.value.data!.vehicle!.user!.userColor!.backgroundHexCode,
                                      ]
                                  );
                                  // chatController.oneToOneChat(inboxID: vehicleController.vehicleModel.value.data!.vehicle!.user!.userId!);
                                },
                                    child: SvgPicture.asset(ImageConst.chat2))
                              ],
                            ):
                            const SizedBox()
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Container(color: Colors.white,
                            padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                            child: Row(
                              children: [
                                Expanded(child: Text('Contact Person:', style: AppTextStyle.black15_600_2)),
                                Expanded(child: Text(value.vehicleModel.value.data!.vehicle!.user!.fullName!, style: AppTextStyle.grey15_600,)),
                                // Text('Contact Person:'),
                              ],
                            ),

                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                            child: Row(
                              children: [
                                Expanded(child: Text('Vehicle Type:', style: AppTextStyle.black15_600_2)),
                                Expanded(child: Text(value.vehicleModel.value.data!.vehicle!.vehicleType!.carTypeName!, style: AppTextStyle.grey15_600,)),
                                // Text('Contact Person:'),
                              ],
                            ),

                          ),
                          Container(color: Colors.white,
                            padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                            child: Row(
                              children: [
                                Expanded(child: Text('Engine Size:', style: AppTextStyle.black15_600_2)),
                                Expanded(child: Text(value.vehicleModel.value.data!.vehicle!.engineSize!.carEngineSizeName!, style: AppTextStyle.grey15_600,)),
                                // Text('Contact Person:'),
                              ],
                            ),

                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                            child: Row(
                              children: [
                                Expanded(child: Text('Manufacture Year:', style: AppTextStyle.black15_600_2)),
                                Expanded(child: Text('${DateFormat('yyyy').format(DateTime.parse(value.vehicleModel.value.data!.vehicle!.manufacturingYear!))}', style: AppTextStyle.grey15_600,)),
                                // Text('Contact Person:'),
                              ],
                            ),
                          ),
                          Container(color: Colors.white,
                            padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                            child: Row(
                              children: [
                                Expanded(child: Text('Price:', style: AppTextStyle.black15_600_2)),
                                Expanded(child: Row(
                                  children: [
                                    Text('${value.vehicleModel.value.data!.vehicle!.currency![value.vehicleModel.value.data!.vehicle!.currency!.length - 1]} ', style: AppTextStyle.grey15_600,),
                                    Text('${value.vehicleModel.value.data!.vehicle!.price}', style: AppTextStyle.detailsOrange,),
                                  ],
                                )),
                                // Text('Contact Person:'),
                              ],
                            ),

                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                            child: Row(
                              children: [
                                Expanded(child: Text('Mileage:', style: AppTextStyle.black15_600_2)),
                                Expanded(child: Text('${value.vehicleModel.value.data!.vehicle!.mileage} mph', style: AppTextStyle.grey15_600,)),
                              ],
                            ),

                          ),
                          Container(color: Colors.white,
                            padding: const EdgeInsets.only(left: 30, top: 3, bottom: 3),
                            child: Row(
                              children: [
                                Expanded(child: Text('Seller Type:', style: AppTextStyle.black15_600_2)),
                                Expanded(child: Text('${getFirstWords(vehicleController.vehicleModel.value.data!.vehicle!.user!.role!.roleName!, 1)} Seller', style: AppTextStyle.grey15_600,)),
                                // Text('Contact Person:'),
                              ],
                            ),

                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Divider(
                            //   height: 50, thickness: 2, color: Colors.grey.shade300,
                            // ),
                            Text('Overview', style: AppTextStyle.black18_600),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.calender, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Text('${DateFormat('yyyy').format(DateTime.parse(value.vehicleModel.value.data!.vehicle!.manufacturingYear!))}', style: AppTextStyle.black16_600)
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(13),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.mil, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Text('${value.vehicleModel.value.data!.vehicle!.mileage} Mileage', style: AppTextStyle.black16_600)
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.fue, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(value.vehicleModel.value.data!.vehicle!.carFuelType!.carFuelTypeName!, style: AppTextStyle.black16_600)
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(11),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.nn, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(value.vehicleModel.value.data!.vehicle!.condition!.carConditionName!, style: AppTextStyle.black16_600)
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.gear, color: ColorConst.label,),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(value.vehicleModel.value.data!.vehicle!.gearBox!.carGearBoxName!, style: AppTextStyle.black16_600)
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(13),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.info2),
                                      ),
                                      const SizedBox(width: 15),
                                      Text('Private Seller', style: AppTextStyle.black16_600)
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.ff),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(value.vehicleModel.value.data!.vehicle!.engineSize!.carEngineSizeName!, style: AppTextStyle.black16_600)
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                            const SizedBox(height: 10),
                            Text(value.vehicleModel.value.data!.vehicle!.description == null?
                              'N/A':'${value.vehicleModel.value.data!.vehicle!.description}',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorConst.grey3),),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(12),
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
                                          Text('${value.vehicleModel.value.data!.vehicle!.city!.cityName}, ${value.vehicleModel.value.data!.vehicle!.state!.stateName}, ${value.vehicleModel.value.data!.vehicle!.country!.countryName}', style: AppTextStyle.grey12_400),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(12),
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
                                          Text(value.vehicleModel.value.data!.vehicle!.youtubeVideoUrl == ""?
                                              'N/A':'${value.vehicleModel.value.data!.vehicle!.youtubeVideoUrl}',
                                          style: AppTextStyle.grey12_400),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.mail2, height: 20,),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Email ID', style: AppTextStyle.black16_600),
                                          const SizedBox(height: 5),
                                          Text('${value.vehicleModel.value.data!.vehicle!.user!.emailAddress}', style: AppTextStyle.grey12_400),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(height: 30,),
                                  Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: ColorConst.grey5,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: SvgPicture.asset(ImageConst.call2),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Mobile No', style: AppTextStyle.black16_600),
                                          const SizedBox(height: 5),
                                          Text(value.vehicleModel.value.data!.vehicle!.user!.phoneNumber!, style: AppTextStyle.grey12_400),
                                        ],
                                      )
                                    ],
                                  )

                                ],
                              ),
                            ),
                            SharedPrefUtils.isLoggedIn()?
                            vehicleController.vehicleModel.value.data!.vehicle!.user!.userId == SharedPrefUtils.getUserId()?
                            const SizedBox():
                            Center(child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Buttons.actionButtons(title: 'ENQUIRE NOW', event: (){
                                Get.bottomSheet(EnquirePopup(
                                enqFrom: 'vehicle',
                                userID: vehicleController.vehicleModel.value.data!.vehicle!.user!.userId,
                                productID: vehicleId,
                              ));
                              }),
                            )):const SizedBox()
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
