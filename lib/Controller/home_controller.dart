import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Services/dashboard_service.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import '../Model/dashboard_model.dart';
import 'item_available_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeController extends GetxController{
  late FocusNode focusNode = FocusNode();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    focusNode.requestFocus();
    // meController.getMeData();
  }

  ItemAvailableController itemController = Get.put(ItemAvailableController());
  // MeController meController = Get.put(MeController());
  final selectedIndex = 0.obs;

  var homeModel = HomePageModel().obs;

  String newCountryID = '13414701-f899-41cd-815b-093e21ceffed';
  String newCountryFlag = 'https://www.kawawamotorsapi.acelance.com:8020//storage/images/7d722b823d8d7f0adcd28a189de543d283a2.png';
  String newCountryName = 'Malawi';

  Future<HomePageModel> getHomePageData({required String date, required String countryID}) async {
    var data = await HomePageServices.getHomePageData(date: date, countryID: countryID);
    try {
      homeModel.value = HomePageModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    update();
    return homeModel.value;
  }

}