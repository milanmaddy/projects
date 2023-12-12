import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Controller/profile_controller.dart';
import 'package:kawawa_motors/Screen/PopUp/delete_account.dart';
import 'package:kawawa_motors/Screen/PopUp/logout_popup.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import '../../../Controller/broadcast_controller.dart';
import '../../../GlobalWidgets/appbar_withoutback.dart';
import '../../../Constraints/color_const.dart';
import '../../../Constraints/image_const.dart';
import '../../../Constraints/text_style.dart';
import '../../../GlobalWidgets/trim_name.dart';
import '../../../Routes/app_route.dart';

class MenuWithLogin extends StatelessWidget {
  MenuWithLogin({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  MeController meController = Get.put(MeController());
  ProfileController profileController = Get.put(ProfileController());
  BroadcastController broadcastController = Get.put(BroadcastController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(title: 'Menu'),
      body: RefreshIndicator(
        onRefresh: ()async{
          meController.getMeData();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0).copyWith(top: 15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  decoration: BoxDecoration(
                    color: ColorConst.skyBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(() =>
                          meController.meModel.value.data!.user!.businessAccount != null?
                          meController.meModel.value.data!.user!.businessAccount!.businessLogoUrl == ''?
                          meController.meModel.value.data!.user!.profileImageUrl == ''?
                          CircleAvatar(
                            radius: 40,
                            // backgroundColor: Colors.white,
                            // backgroundImage: AssetImage(ImageConst.man),
                            backgroundColor: Color(int.parse(meController.meModel.value.data!.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                            child: Center(
                              child: Text(TrimName.getInitials(meController.meModel.value.data!.user!.fullName!.toUpperCase()),
                                style: TextStyle(color: Color(int.parse(meController.meModel.value.data!.user!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                                    fontWeight: FontWeight.w600, fontSize: 27

                                ),
                              ),
                            ),
                          ):
                          // profileController.profileImage.value != ''?
                          CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              backgroundImage:CachedNetworkImageProvider(SharedPrefUtils.getProfilePic()!)
                          ):
                          CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              backgroundImage:CachedNetworkImageProvider(SharedPrefUtils.getBusinessLogo()!)
                          ):
                          meController.meModel.value.data!.user!.profileImageUrl == ''?
                          CircleAvatar(
                            radius: 40,
                            // backgroundColor: Colors.white,
                            // backgroundImage: AssetImage(ImageConst.man),
                            backgroundColor: Color(int.parse(meController.meModel.value.data!.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                            child: Center(
                              child: Text(TrimName.getInitials(meController.meModel.value.data!.user!.fullName!.toUpperCase()),
                                style: TextStyle(color: Color(int.parse(meController.meModel.value.data!.user!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                                    fontWeight: FontWeight.w600, fontSize: 27

                                ),
                              ),
                            ),
                          ):
                          // profileController.profileImage.value != ''?
                          CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              backgroundImage:CachedNetworkImageProvider(SharedPrefUtils.getBusinessLogo()!)
                          )
                          ),
                          const SizedBox(width: 15),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SharedPrefUtils.getName().toString(), style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 7),
                              SizedBox(width: 170,
                                child: Text(SharedPrefUtils.getEmail().toString(), style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
                              )
                            ],
                          )
                        ],
                      ),

                      GestureDetector(onTap: (){Get.bottomSheet(LogoutPopup());},
                        child: Container(padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: ColorConst.label, width: 1.5)
                          ),
                          child: Text('Logout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ColorConst.label),),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Text('My Account', style: AppTextStyle.bullet),
                const SizedBox(height: 10),
                ListTile(onTap: (){homeController.selectedIndex.value = 1;
                  },
                  leading: SvgPicture.asset(ImageConst.item, color: ColorConst.label,),
                  minLeadingWidth: 0,
                  title: Text('Sell', style: AppTextStyle.grey15_400,),
                  contentPadding: EdgeInsets.zero,
                ),
                ListTile(onTap: (){homeController.selectedIndex.value = 2;},
                  leading: SvgPicture.asset(ImageConst.heart, height: 20),
                  minLeadingWidth: 0,
                  title: Text('Favourites', style: AppTextStyle.grey15_400),
                  contentPadding: EdgeInsets.zero,
                ),
                ListTile(onTap: (){Get.toNamed(AppRoute.notification);},
                  leading: SvgPicture.asset(ImageConst.noti, height: 25,),
                  minLeadingWidth: 0,
                  title: Text('Notification',style: AppTextStyle.grey15_400),
                  contentPadding: EdgeInsets.zero,
                ),
                ListTile(onTap: (){
                  broadcastController.myBroadcastModel.value.data = null;
                  Get.toNamed(AppRoute.myBroadcast);
                  },
                  leading: SvgPicture.asset(ImageConst.myBroadcast, height: 20),
                  minLeadingWidth: 0,
                  title: Text('My Broadcasts',style: AppTextStyle.grey15_400),
                  contentPadding: EdgeInsets.zero,

                ),
                ListTile(onTap: (){Get.toNamed(AppRoute.createBroadcast);},
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
                ListTile(onTap: (){Get.toNamed(AppRoute.myEnquiry);},
                  leading: SvgPicture.asset(ImageConst.enquiry, height: 20),
                  minLeadingWidth: 0,
                  title: Text('My Enquiries', style: AppTextStyle.grey15_400),
                  contentPadding: EdgeInsets.zero,
                ),
                ListTile(onTap: (){Get.toNamed(AppRoute.getInTouch);},
                  leading: SvgPicture.asset(ImageConst.touch, height: 20),
                  minLeadingWidth: 0,
                  title: Text('Get in Touch', style: AppTextStyle.grey15_400),
                  contentPadding: EdgeInsets.zero,

                ),
                ListTile(onTap: (){Get.toNamed(AppRoute.liveChat);},
                  leading: SvgPicture.asset(ImageConst.chat, height: 20),
                  minLeadingWidth: 0,
                  title: Text('Live Chat', style: AppTextStyle.grey15_400),
                  contentPadding: EdgeInsets.zero,
                ),
                const Divider(height: 30),
                ListTile(onTap: (){Get.bottomSheet(DeleteAccount());},
                  leading: SvgPicture.asset(ImageConst.delete, height: 27),
                  minLeadingWidth: 0,
                  title: const Text('Delete Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.red)),
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
      ),
    );
  }
}
