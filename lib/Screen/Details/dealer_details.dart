import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/chat_controller.dart';
import 'package:kawawa_motors/Controller/dealer_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/trim_name.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/Details/rating.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/loader.dart';
import '../PopUp/enquire_popup.dart';

class DealerDetails extends StatelessWidget {
  DealerDetails({Key? key}) : super(key: key);

  DealerController dealerController = Get.put(DealerController());
  VehicleController vehicle = Get.put(VehicleController());
  ChatController chatController = Get.put(ChatController());
  String dealerId = Get.arguments;

  // Color background = Color(int.parse("0x${vehicle.vehicleModel.value.data!.vehicle!.user!.userColor!.background!.substring(6)}"));

  RxDouble rating = RxDouble(0);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Dealer's Details"),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: GetBuilder(
            init: dealerController,
              initState: (controller){
              dealerController.getDealerDetailsData(dealerId: dealerId);
              },
              builder: (value){
                return dealerController.dealerModel.value.data == null?
                SizedBox(height: Get.height,
                    child: PRLoader.normalLoader()):
                Column(
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        value.dealerModel.value.data!.business!.businessAccount!.businessLogoUrl == ''?
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: //Colors.red,
                          Color(int.parse(value.dealerModel.value.data!.business!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                          child: Center(
                            child: Text(TrimName.getInitials(value.dealerModel.value.data!.business!.businessAccount!.businessName!.toUpperCase()),
                              style: TextStyle(color: Color(int.parse(value.dealerModel.value.data!.business!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                                  fontWeight: FontWeight.w600, fontSize: 32

                              ),
                            ),
                          ),
                        ):
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(value.dealerModel.value.data!.business!.businessAccount!.businessLogoUrl!),
                        ),
                        // Image.asset(ImageConst.dealer, height: 100, width: 100),
                        const SizedBox(width: 30),
                        Flexible(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.dealerModel.value.data!.business!.businessAccount!.businessName!, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 20)),
                              const SizedBox(height: 3),
                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(() => RatingBar.builder(
                                    initialRating: rating.value,
                                    minRating: 1,
                                    ignoreGestures: true,
                                    itemSize: 25,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
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
                                  value.dealerModel.value.data!.business!.userId == SharedPrefUtils.getUserId()?
                                  const SizedBox():
                                  value.dealerModel.value.data!.business!.isRated == true?
                                  const SizedBox():
                                  GestureDetector(onTap: ()async{
                                    if(value.dealerModel.value.data!.business!.isRated == true){

                                    }else{
                                      print(rating);
                                      final finalRating = await Get.dialog(Dialog(insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent,
                                          child: Rating(productID: value.dealerModel.value.data!.business!.userId, ratingFrom: 'D',)),
                                        barrierDismissible: true, );

                                      if(finalRating != null){
                                        rating.value = finalRating;
                                      }
                                    }
                                  },
                                    child: Container(width: 50, height: 17,
                                      decoration: BoxDecoration(
                                          color: ColorConst.label,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Center(
                                        child: value.dealerModel.value.data!.business!.isRated == true?
                                        const Text('Rated', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black)):
                                        const Text('Rate Us', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ): const SizedBox()
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(value.dealerModel.value.data!.business!.businessAccount!.businessType!.title!,
                                style: TextStyle(fontSize: 17, color: ColorConst.blue1),
                              ),
                              // SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SharedPrefUtils.isLoggedIn()?
                                  dealerController.dealerModel.value.data!.business!.userId == SharedPrefUtils.getUserId()?
                                  const SizedBox():
                                  GestureDetector(onTap: (){
                                    Get.toNamed(AppRoute.dealerService,
                                        arguments: [
                                          value.dealerModel.value.data!.business!.businessAccount!.businessName,
                                          value.dealerModel.value.data!.business!.userId
                                        ]);
                                    },
                                    child: Container(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                                      decoration: BoxDecoration(
                                          color: ColorConst.button,
                                          borderRadius: BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade300,
                                                // spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0, 3)
                                            )
                                          ]
                                      ),
                                      child: const Text('View Services', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),),
                                    ),
                                  ): const SizedBox(),
                                  SharedPrefUtils.isLoggedIn()?
                                  GestureDetector(onTap: (){
                                    Get.toNamed(AppRoute.chatPage,
                                        arguments: [
                                          dealerController.dealerModel.value.data!.business!.inboxId == ''?
                                          '0': dealerController.dealerModel.value.data!.business!.inboxId,
                                          dealerController.dealerModel.value.data!.business!.profileImageUrl!,
                                          dealerController.dealerModel.value.data!.business!.businessAccount == null?
                                          dealerController.dealerModel.value.data!.business!.fullName:
                                          dealerController.dealerModel.value.data!.business!.businessAccount!.businessName,
                                          dealerController.dealerModel.value.data!.business!.userSettings!.isOnline,
                                          dealerController.dealerModel.value.data!.business!.userId!,
                                          dealerController.dealerModel.value.data!.business!.userColor!.userNameColorHexCode,
                                          dealerController.dealerModel.value.data!.business!.userColor!.backgroundHexCode,
                                        ]
                                    );
                                  },
                                      child: SvgPicture.asset(ImageConst.chat2)
                                    // const CircleAvatar(
                                    //   backgroundColor: Color(0xFF00A66C),
                                    //   radius: 26,
                                    //   child: Icon(Icons.chat, color: Colors.white),
                                    // ),
                                  ):
                                  const SizedBox()
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          Container(height: 45, width: 45,
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                                color: ColorConst.grey5,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: SvgPicture.asset(ImageConst.office, color: ColorConst.label),
                          ),
                          const SizedBox(width: 15),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Company Name', style: AppTextStyle.black16_600),
                              const SizedBox(height: 5),
                              Text(value.dealerModel.value.data!.business!.businessAccount!.businessName!, style: AppTextStyle.grey12_400),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          Container(height: 45, width: 45,
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: ColorConst.grey5,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: SvgPicture.asset(ImageConst.person, color: ColorConst.label),
                          ),
                          const SizedBox(width: 15),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Contact Person', style: AppTextStyle.black16_600),
                              const SizedBox(height: 5),
                              Text(dealerController.dealerModel.value.data!.business!.fullName!, style: AppTextStyle.grey12_400),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          Container(height: 45, width: 45,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: ColorConst.grey5,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: SvgPicture.asset(ImageConst.mail, color: ColorConst.label),
                          ),
                          const SizedBox(width: 15),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email ID', style: AppTextStyle.black16_600),
                              const SizedBox(height: 5),
                              Text(value.dealerModel.value.data!.business!.emailAddress!, style: AppTextStyle.grey12_400),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          Container(height: 45, width: 45,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: ColorConst.grey5,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: SvgPicture.asset(ImageConst.call, color: ColorConst.label),
                          ),
                          const SizedBox(width: 15),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mobile No', style: AppTextStyle.black16_600),
                              const SizedBox(height: 5),
                              Text(value.dealerModel.value.data!.business!.phoneNumber!, style: AppTextStyle.grey12_400),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          Container(height: 45, width: 45,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: ColorConst.grey5,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: SvgPicture.asset(ImageConst.web),
                          ),
                          const SizedBox(width: 15),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Website', style: AppTextStyle.black16_600),
                              const SizedBox(height: 5),
                              SizedBox(width: 310,
                                child: Text(value.dealerModel.value.data!.business!.businessAccount!.websiteUrl == null?
                                'N/A':value.dealerModel.value.data!.business!.businessAccount!.websiteUrl.toString(),
                                    style: AppTextStyle.grey12_400, overflow: TextOverflow.ellipsis),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          Container(height: 45, width: 45,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                color: ColorConst.grey5,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: SvgPicture.asset(ImageConst.info2, color: ColorConst.label),
                          ),
                          const SizedBox(width: 15),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Speciality', style: AppTextStyle.black16_600),
                              const SizedBox(height: 5),
                              Text(value.dealerModel.value.data!.business!.businessAccount!.businessType!.title!, style: AppTextStyle.grey12_400),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          Container(height: 45, width: 45,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: ColorConst.grey5,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: SvgPicture.asset(ImageConst.lp, color: ColorConst.label),
                          ),
                          const SizedBox(width: 15),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address', style: AppTextStyle.black16_600),
                              const SizedBox(height: 5),
                              Text('${value.dealerModel.value.data!.business!.city!.cityName}, ${value.dealerModel.value.data!.business!.state!.stateName}, ${value.dealerModel.value.data!.business!.country!.countryName}', style: AppTextStyle.grey12_400),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                );
              }
          )
        ),
      ),
    );
  }
}
