import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/PopUp/country_popup.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import '../Constraints/image_const.dart';
import '../Controller/me_controller.dart';

class AppBarBack extends StatelessWidget implements PreferredSizeWidget{
  AppBarBack({Key? key, required this.title, this.actions}) : super(key: key);

  MeController meController = Get.put(MeController());

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);

  String title;
  // String title2;
  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(0).copyWith(),
      child: AppBar(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        elevation: 5,
        leading: const SizedBox(),
        leadingWidth: 30,
        toolbarHeight: 90,
        titleSpacing: 0,

        title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
        actions: [
          SharedPrefUtils.isLoggedIn()?
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 27),
            child: GestureDetector(onTap: (){Get.toNamed(AppRoute.myEnquiry);},
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
          ):
          const SizedBox(),
          SharedPrefUtils.isLoggedIn()?
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 27),
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
                      // CircleAvatar(child: SvgPicture.asset(ImageConst.speaker, height: 22),
                      //   backgroundColor: Colors.white,
                      //
                      // ),
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
          ):
          const SizedBox(),
          SharedPrefUtils.isLoggedIn()?
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 25, top: 27),
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
                      // CircleAvatar(child: SvgPicture.asset(ImageConst.speaker, height: 22),
                      //   backgroundColor: Colors.white,
                      //
                      // ),
                    ),
                    Obx(() => meController.meModel.value.data!.user!.notifications!.bellIconNotification == 0?
                    const SizedBox():
                    Positioned(right: 0,
                      child: CircleAvatar(
                        radius: 6.5,
                        backgroundColor: Colors.red,
                        child: Center(
                            child: Text('${meController.meModel.value.data!.user!.notifications!.bellIconNotification.toString()}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 7, fontFamily: 'SF'),)),
                      ),
                    ))
                  ],
                )
            ),
          ):
          const SizedBox(),
        ],
      ),
    );
  }
}
