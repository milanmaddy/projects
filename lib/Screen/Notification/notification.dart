import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Controller/notification_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Screen/Notification/notification_list.dart';

class Notificationn extends StatelessWidget {
  Notificationn({Key? key}) : super(key: key);

  NotificationController notiController = Get.put(NotificationController());
  // MeController meController = Get.put(MeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications'),
      backgroundColor: ColorConst.grey2,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: notiController.scrollController,
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: GetBuilder(
              init: notiController,
              initState: (controller){
                notiController.getNotificationListData();
              },
              builder: (value){
                return notiController.notificationModel.value.data == null?
                    SizedBox(
                      height: Get.height,
                      child: PRLoader.normalLoader(),
                    ):
                    notiController.notificationModel.value.data!.notification!.isEmpty?
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(child: Text('No notifications to show', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
                    ):
                ListView.builder(
                    shrinkWrap: true,
                    physics:  const NeverScrollableScrollPhysics(),
                    // controller: notiController.scrollController,
                    itemCount: notiController.notificationModel.value.data!.notification!.length,
                    itemBuilder: (context, index){
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: NotificationList(notification: notiController.notificationModel.value.data!.notification![index])
                      );
                    }
                );
              },
            )
          ),
      ),
  );
  }
}
