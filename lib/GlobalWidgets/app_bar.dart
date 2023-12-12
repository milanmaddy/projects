import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Constraints/color_const.dart';
import '../Constraints/image_const.dart';
import '../Constraints/text_style.dart';
import '../Controller/me_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  CustomAppBar({Key? key,required this.title,this.actions}) : super(key: key);

  MeController meController = Get.put(MeController());

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
  String title;
  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      elevation: 5,
      leading: GestureDetector(
        onTap: (){
          // meController.getMeData();
          Get.back();
          },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: const Offset(0,2)
                  )
                ]
              ),
              child: const Center(child: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF455A64), size: 22))),
        ),
      ),
      leadingWidth: 80,
      toolbarHeight: 80,
      titleSpacing: 0,

      title: Text(title,style: AppTextStyle.appbar),
      actions:actions ,
    );
  }



}

class CustomAppBarCross extends StatelessWidget implements PreferredSizeWidget{
  CustomAppBarCross({Key? key,this.actions, required this.title}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
  // String title;
  List<Widget>? actions;
  String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      elevation: 5,
      leading: GestureDetector(
        onTap: (){Get.back();},
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 3,
                        spreadRadius: 2,
                        offset: const Offset(0,2)
                    )
                  ]
              ),
              child: Center(child: SvgPicture.asset(ImageConst.cross, color: ColorConst.blue2, height: 35,))),
        ),
      ),
      leadingWidth: 75,
      toolbarHeight: 80,
      titleSpacing: 15,

      title: Text('More Filters of $title',style: AppTextStyle.appbar),
      actions:actions ,
    );
  }



}

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget{
  SimpleAppBar({Key? key,required this.title,this.actions}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
  String title;
  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      elevation: 0,
      leading: GestureDetector(
        onTap: (){Get.back();},
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 3,
                        spreadRadius: 2,
                        offset: const Offset(0,2)
                    )
                  ]
              ),
              child: const Center(child: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF455A64), size: 25,))),
        ),
      ),
      leadingWidth: 70,
      toolbarHeight: 80,
      titleSpacing: 25,
      title: Text(title,style: AppTextStyle.appbar),
      actions:actions ,
    );
  }



}