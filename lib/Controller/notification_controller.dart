import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Model/notification_list_model.dart';
import 'package:kawawa_motors/Services/notification_services.dart';

class NotificationController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    notiScrollController();
  }

  ScrollController scrollController = Get.put(ScrollController());

  var notificationModel = NotificationListModel().obs;
  MeController meController = Get.put(MeController());

  int pageNumber = 1;

  Future<NotificationListModel> getNotificationListData() async {
    update();
    pageNumber = 1;
    var data = await NotificationServices.notificationList(pageName: pageNumber.toString(), showLoader: false);
    notificationModel.value = NotificationListModel.fromJson(data);
    print('NOW NOTIFICATION LENGTH IS ${notificationModel.value.data!.notification!.length}');
    if(data['statusCode'] == 200){
      meController.getMeData();
    }
    pageNumber++;
    update();
    return notificationModel.value;
  }

  Future<NotificationListModel> getNotificationListDataForNextPage({required String page, bool showLoader = true}) async {
    update();
    if(notificationModel.value.data!.pagination!.lastPage! >= pageNumber){
      var data = await NotificationServices.notificationList(pageName: pageNumber.toString(), showLoader: true);
      notificationModel.value.data!.notification!.addAll(NotificationListModel.fromJson(data).data!.notification!);
      print('NOW NOTIFICATION LENGTH IS ${notificationModel.value.data!.notification!.length}');
      pageNumber++;
    }
    update();
    return notificationModel.value;
  }

  notiScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getNotificationListDataForNextPage(page: pageNumber.toString());
      }
    });
  }
}