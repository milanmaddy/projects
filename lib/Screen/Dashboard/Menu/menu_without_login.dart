import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../../GlobalWidgets/appbar_withoutback.dart';
import '../../../Constraints/image_const.dart';

class MenuWithoutLogin extends StatelessWidget {
  MenuWithoutLogin({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  MeController meController = Get.put(MeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(title: 'Menu'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0).copyWith(top: 15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: ColorConst.skyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConst.blue3)),
                        Text('Sign in with your account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorConst.blue3)),
                      ],
                    ),

                    GestureDetector(onTap: (){Get.toNamed(AppRoute.login);},
                      child: Container(padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: ColorConst.label, width: 1.5)
                        ),
                        child: Text('Login/Register', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ColorConst.label),),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Text('My Account', style: AppTextStyle.bullet),
              const SizedBox(height: 10),
              ListTile(onTap: (){Get.toNamed(AppRoute.login);},
                leading: SvgPicture.asset(ImageConst.item, color: ColorConst.label,),
                minLeadingWidth: 0,
                title: Text('Sell', style: AppTextStyle.grey15_400,),
                contentPadding: EdgeInsets.zero,
              ),
              ListTile(onTap: (){Get.toNamed(AppRoute.login);},
                leading: SvgPicture.asset(ImageConst.heart, height: 20),
                minLeadingWidth: 0,
                title: Text('Favourites', style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,
              ),
              ListTile(onTap: (){Get.toNamed(AppRoute.login);},
                leading: SvgPicture.asset(ImageConst.noti, height: 25,),
                minLeadingWidth: 0,
                title: Text('Notification',style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,
              ),
              ListTile(onTap: (){Get.toNamed(AppRoute.login);},
                leading: SvgPicture.asset(ImageConst.myBroadcast, height: 20),
                minLeadingWidth: 0,
                title: Text('My Broadcasts',style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,
              ),
              ListTile(onTap: (){Get.toNamed(AppRoute.login);},
                leading: SvgPicture.asset(ImageConst.createBroadcast, height: 20,),
                minLeadingWidth: 0,
                title: Text('Create Broadcast', style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,
              ),
              const Divider(height: 30),
              Text('Company Terms', style: AppTextStyle.bullet),
              const SizedBox(height: 10),
              ListTile(onTap: (){Get.toNamed(AppRoute.aboutUs);},
                  leading: SvgPicture.asset(ImageConst.info, height: 20,),
                minLeadingWidth: 0,
                title: Text('About Us', style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,
              ),
              ListTile(onTap: (){Get.toNamed(AppRoute.termsCondition);},
                leading: SvgPicture.asset(ImageConst.terms, height: 20),
                minLeadingWidth: 0,
                title: Text('Terms & Conditions', style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,

              ),
              ListTile(onTap: (){Get.toNamed(AppRoute.privacyPolicy);},
                leading: SvgPicture.asset(ImageConst.privacy, height: 20),
                minLeadingWidth: 0,
                title: Text('Privacy Policy', style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,
              ),
              const Divider(height: 30),
              Text('Help & Support', style: AppTextStyle.bullet),
              const SizedBox(height: 10),
              ListTile(onTap: (){Get.toNamed(AppRoute.login);},
                leading: SvgPicture.asset(ImageConst.enquiry, height: 20),
                minLeadingWidth: 0,
                title: Text('My Enquiries', style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,
              ),
              ListTile(onTap: (){Get.toNamed(AppRoute.login);},
                leading: SvgPicture.asset(ImageConst.touch, height: 20),
                minLeadingWidth: 0,
                title: Text('Get in Touch', style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,

              ),
              ListTile(onTap: (){Get.toNamed(AppRoute.login);},
                leading: SvgPicture.asset(ImageConst.chat, height: 20),
                minLeadingWidth: 0,
                title: Text('Live Chat', style: AppTextStyle.grey15_400),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 140),
              Align(alignment: Alignment.center,
                  child: Text('Kawawa Motors', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500, color: ColorConst.kawawa),)),
              const SizedBox(height: 5),
              Align(alignment: Alignment.center,
                  child: Text('V1.00.01', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade600),)),

            ],
          ),
        ),
      ),
    );
  }
}
