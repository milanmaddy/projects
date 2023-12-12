import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/item_available_controller.dart';
import 'package:kawawa_motors/Controller/socket_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Home/Tab%20Page/tab_page.dart';
import 'package:kawawa_motors/Home/Vehicle%20Types/vehicle_types.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/PopUp/country_popup.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import 'package:kawawa_motors/Socket/socket.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Constraints/image_const.dart';
import '../Controller/me_controller.dart';
import 'Trusted Partners/trusted_partner.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var aIndex = 0.obs;

  HomeController homeController = Get.put(HomeController());
  MeController meController = Get.put(MeController());
  ItemAvailableController itemController = Get.put(ItemAvailableController());
  // SocketController socketController = Get.put(SocketController());
  // String newCountryID = '13414701-f899-41cd-815b-093e21ceffed';
  // String newCountryFlag = 'https://www.kawawamotorsapi.acelance.com:8020//storage/images/7d722b823d8d7f0adcd28a189de543d283a2.png';
  // DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // initCallingSocket();
    // socketController.initSocket();
    return Scaffold(
      backgroundColor: ColorConst.back,
      body: RefreshIndicator(
        onRefresh: ()async{
          // homeController.getHomePageData(
          //   countryID: homeController.newCountryID,
          //   date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
          // );
          meController.getMeData();
        },
        child: SingleChildScrollView(
          child:
          GetBuilder(
            init: homeController,
            initState: (controller){
              // itemController.getItemData();
              homeController.getHomePageData(
                countryID: homeController.newCountryID,
                date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
              );
              meController.getMeData();
            },
            builder: (value){
              return value.homeModel.value.data == null?
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PRLoader.normalLoader()
              ):
                  meController.meModel.value.data == null?
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: PRLoader.normalLoader()
                  ):
              Column(mainAxisSize: MainAxisSize.max,
                children: [
                  Container(padding: const EdgeInsets.all(20).copyWith(top: 72, left: 30),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,

                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // SvgPicture.asset(ImageConst.logo, height: 40, color: Colors.red,),
                                Image.asset(ImageConst.logoP, height:40),
                                const SizedBox(width: 10),
                                GestureDetector(onTap: ()async{
                                  final result = await Get.bottomSheet(CountryPopup());
                                  if(result == null){print('== NULL ==');}
                                  else{
                                    homeController.newCountryID = result[0];
                                    homeController.newCountryFlag = result[1];
                                    homeController.newCountryName = result[2];
                                    print(homeController.newCountryID);
                                    print(homeController.newCountryFlag);
                                    print(homeController.newCountryName);
                                  }
                                },
                                  child: Container(height: 26, width: 26,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade600,
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 1)
                                          )
                                        ],
                                      image: DecorationImage(
                                          image: NetworkImage(homeController.newCountryFlag
                                              // itemController.itemModel.value.data!.countries![1].countryFlagUrl!
                                          ), fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SharedPrefUtils.isLoggedIn()?
                            Row(
                              children: [
                                GestureDetector(onTap: (){Get.toNamed(AppRoute.myEnquiry);},
                                    child: Stack(
                                      children: [
                                        Container(width: 35, height: 35,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                // borderRadius: BorderRadius.circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey.shade500,
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      offset: const Offset(0, 2)
                                                  )
                                                ]
                                            ),
                                            child: Image.asset(ImageConst.que)
                                          // CircleAvatar(child: SvgPicture.asset(ImageConst.speaker, height: 22),
                                          //   backgroundColor: Colors.white,
                                          //
                                          // ),
                                        ),
                                        Obx(() => meController.meModel.value.data!.user!.notifications!.enquires == 0?
                                        const SizedBox():
                                        Positioned(right: 0,
                                          child: CircleAvatar(
                                            radius: 6.5,
                                            backgroundColor: Colors.red,
                                            child: Center(
                                                child: Text(meController.meModel.value.data!.user!.notifications!.enquires.toString(),
                                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 7, fontFamily: 'SF'),)),
                                          ),
                                        ))
                                      ],
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: GestureDetector(onTap: (){Get.toNamed(AppRoute.broadcast);},
                                      child: Stack(
                                        children: [
                                          Container(width: 35, height: 35,
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  // borderRadius: BorderRadius.circular(50),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.shade500,
                                                        spreadRadius: 1,
                                                        blurRadius: 2,
                                                        offset: const Offset(0, 2)
                                                    )
                                                  ]
                                              ),
                                              child: SvgPicture.asset(ImageConst.speaker, height: 18)
                                          ),
                                          Obx(() => meController.meModel.value.data!.user!.notifications!.broadcasts == 0?
                                          const SizedBox():
                                          Positioned(right: 0,
                                            child: CircleAvatar(
                                              radius: 6.5,
                                              backgroundColor: Colors.red,
                                              child: Center(
                                                  child: Text(meController.meModel.value.data!.user!.notifications!.broadcasts.toString(),
                                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 7, fontFamily: 'SF'),)),
                                            ),
                                          ))
                                        ],
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: GestureDetector(onTap: (){Get.toNamed(AppRoute.notification);},
                                    child: Stack(
                                      children: [
                                        Container(width: 35, height: 35,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey.shade500,
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      offset: const Offset(0, 2)
                                                  )
                                                ]
                                            ),
                                            child: SvgPicture.asset(ImageConst.bell, height: 18)
                                        ),
                                        Obx(() => meController.meModel.value.data!.user!.notifications!.bellIconNotification == 0?
                                          const SizedBox():
                                          Positioned(right: 0,
                                            child: CircleAvatar(
                                              radius: 6.5,
                                              backgroundColor: Colors.red,
                                              child: Center(
                                                child: Text(meController.meModel.value.data!.user!.notifications!.bellIconNotification.toString(),
                                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 7, fontFamily: 'SF'),)),
                                          ),)
                                        )
                                      ],
                                    ),
                                  )

                                ),
                              ],
                            ):SizedBox()

                          ],
                        ),
                        const SizedBox(height: 15),
                        // Text(meController.meModel.value.data!.user!.country!.countryId.toString()),
                        TextField(
                          readOnly: true,
                          onTap: (){Get.toNamed(AppRoute.search);},
                          decoration: InputDecoration(
                            hintText: 'Search',
                            contentPadding: const EdgeInsets.all(15),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(ImageConst.glass),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                          ),

                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width,
                        child: CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay:true,
                              onPageChanged: (index, reason) {
                                aIndex.value = index;
                              },
                            ),
                            itemCount: value.homeModel.value.data!.advertisements!.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              return
                              //   CachedNetworkImage(
                              //   imageUrl: value.homeModel.value.data!.advertisements![itemIndex].imageUrl!,
                              //   fit: BoxFit.cover,
                              //   placeholder: (context, url) {return SizedBox(
                              //     height: Get.height, width: Get.width, child: const Center(child: CircularProgressIndicator()),
                              //   );},
                              //   errorWidget: (context, url, error) {return const Icon(Icons.error);}
                              // );
                                Image.network(value.homeModel.value.data!.advertisements![itemIndex].imageUrl!, fit: BoxFit.cover);
                                // Image.asset(ImageConst.audi2, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,);
                            }),
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
                                count: value.homeModel.value.data!.advertisements!.length,
                                effect: const WormEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    spacing: 5,
                                    activeDotColor: Colors.blue,
                                    dotColor: Colors.white),
                              ))
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(top: 0, left: 20, bottom: 50),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(value.homeModel.value.data!.vehicleTypes!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: VehicleType(),
                        ),
                        // const SizedBox(height: 30),
                        if(value.homeModel.value.data!.trustedPartners!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 10),
                          child: TrustedPartner(),
                        ),
                        const SizedBox(height: 10),
                        if(
                        value.homeModel.value.data!.vehicles!.isNotEmpty ||
                        value.homeModel.value.data!.spareParts!.isNotEmpty ||
                        value.homeModel.value.data!.garages!.isNotEmpty
                        )
                        TabPage()
                      ],
                    ),
                  )
                  // SizedBox(height: 25),
                  // Text('Vehicle Types', style: AppTextStyle.bullet2)
                ],
              );

            },
          )
        ),
      ),
    );
  }
}
