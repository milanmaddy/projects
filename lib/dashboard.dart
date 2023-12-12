import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/authentication_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/appbar_withoutback.dart';
import 'package:kawawa_motors/Home/home.dart';
import 'package:kawawa_motors/Model/login_model.dart';
import 'package:kawawa_motors/Screen/Dashboard/Private%20Profile/profile.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/sell.dart';
import 'package:kawawa_motors/Screen/Dashboard/business_profile.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import 'Constraints/color_const.dart';
import 'Constraints/image_const.dart';
import 'Controller/home_controller.dart';
import 'Routes/app_route.dart';
import 'Screen/Dashboard/Favourite/favourite.dart';
import 'Screen/Dashboard/Menu/menu_with_login.dart';
import 'Screen/Dashboard/Menu/menu_without_login.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key){
    _widgetOptions = [
    Home(),

    Sell(),

    Favourite(),

    SharedPrefUtils.getAccountType() == 'Business'?
    BusinessProfile():
    PrivateProfile(),

    SharedPrefUtils.isLoggedIn()?
    MenuWithLogin():
    MenuWithoutLogin()
  ];

  }

  HomeController homeController = Get.put(HomeController());
  MeController meController = Get.put(MeController());
  AuthenticationController authController = Get.put(AuthenticationController());

  var loginM = LoginModel().obs;

  // final _selectedIndex = 0.obs;
  // int index = 0;

  late final List _widgetOptions;

  void _onItemTapped(int index) {
    if (index == 3) {
      if (SharedPrefUtils.isLoggedIn()) {
        homeController.selectedIndex.value = index;
      } else {
        Get.toNamed(AppRoute.login);
      }
    }else
    if (index == 2) {
      if (SharedPrefUtils.isLoggedIn()) {
        homeController.selectedIndex.value = index;
      } else {
        Get.toNamed(AppRoute.login);
      }
    }else
    if (index == 1) {
      if (SharedPrefUtils.isLoggedIn()) {
        homeController.selectedIndex.value = index;
      } else {
        Get.toNamed(AppRoute.login);
      }
    }


    else {
      homeController.selectedIndex.value = index;
    }
  }



  @override
  Widget build(BuildContext context) {
    meController.getMeData();
    return Scaffold(
        // key: _key,
        // backgroundColor: ColorConst.background,
        body: Obx(() => Center(
          child: _widgetOptions.elementAt(homeController.selectedIndex.value),
        ),
        ),
        // appBar:  AppBar(title: Text("Hello")),

        // drawer: MyDrawer(globalKey: _key),

        bottomNavigationBar: Obx(() => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(-3, -5)
                ),
              ]
          ),
          child: ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: BottomNavigationBar(
              unselectedFontSize: 12,
              backgroundColor: Colors.white,
              iconSize: 15,
              selectedFontSize: 12,
              selectedLabelStyle: TextStyle(color: ColorConst.label, fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [homeController.selectedIndex.value==0? SvgPicture.asset(ImageConst.bar):const SizedBox(),
                        homeController.selectedIndex.value==0?
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(ImageConst.home, color: ColorConst.label,),
                          ],
                        ):
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(ImageConst.home),
                          ],
                        ),const SizedBox(height: 5,)],
                    ),label: "Home"
                ),
                BottomNavigationBarItem(
                    icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [homeController.selectedIndex.value==1? SvgPicture.asset(ImageConst.bar):const SizedBox(),
                        homeController.selectedIndex.value==1?
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(ImageConst.item, color: ColorConst.label,),
                          ],
                        ):
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(ImageConst.item),
                          ],
                        ),const SizedBox(height: 5)],
                    ),label: "Sell"
                ),
                BottomNavigationBarItem(
                    icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [homeController.selectedIndex.value==2? SvgPicture.asset(ImageConst.bar):const SizedBox(),
                        homeController.selectedIndex.value==2?
                        Column(
                          children: [
                            const SizedBox(height: 5,),
                            SvgPicture.asset(ImageConst.fav, color: ColorConst.label,),
                          ],
                        ):
                        Column(
                          children: [
                            const SizedBox(height: 5,),
                            SvgPicture.asset(ImageConst.fav),
                          ],
                        ),const SizedBox()],
                    ),label: "Favorited"
                ),
                BottomNavigationBarItem(
                    icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [homeController.selectedIndex.value==3? SvgPicture.asset(ImageConst.bar):const SizedBox(),
                        homeController.selectedIndex.value==3?
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(ImageConst.profile, color: ColorConst.label),
                          ],
                        ):
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(ImageConst.profile),
                          ],
                        ),const SizedBox(height: 5)],
                    ),label: "Profile"
                ),
                BottomNavigationBarItem(
                    icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [homeController.selectedIndex.value==4? SvgPicture.asset(ImageConst.bar):const SizedBox(),
                        homeController.selectedIndex.value==4?
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(ImageConst.menu, color: ColorConst.label),
                          ],
                        ):
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(ImageConst.menu),
                          ],
                        ),const SizedBox(height: 5)],
                    ),label: "Menu"
                ),
              ],

              type: BottomNavigationBarType.fixed,
              currentIndex: homeController.selectedIndex.value,
              selectedItemColor: Colors.black,
              onTap: _onItemTapped,

              elevation: 0,
            ),
          ),
        ))
    );
  }
}
