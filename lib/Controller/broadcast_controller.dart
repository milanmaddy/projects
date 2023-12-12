import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Model/contact_us_model.dart';
import 'package:kawawa_motors/Model/my_broadcast_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Services/broadcast_services.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import '../Model/broadcast_type_model.dart';

class BroadcastController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    globalBroadcastScrollController();
    myBroadcastScrollController();
  }

  MeController meController = Get.put(MeController());
  ScrollController scrollController = Get.put(ScrollController());

  int pageNumberGB = 1;
  int pageNumberMB = 1;
  String pageType = '';

  var broadcastModel = BroadcastTypeModel().obs;
  var myBroadcastModel = MyBroadcastModel().obs;
  var contactModel = ContactUsModel().obs;

  Future<BroadcastTypeModel> getBroadcastListData({
    String type = 'all',
    bool showLoader = false
  }) async {
    pageNumberGB = 1;
    pageType = type;
    var data = await BroadcastService.getBroadcastList(
        type: type,
        pageName: pageNumberGB.toString(),
        showLoader: showLoader);
    if(data['statusCode'] == 200){
      meController.getMeData();
    }
    broadcastModel.value = BroadcastTypeModel.fromJson(data);
    pageNumberGB++;
    print('NOW TYPE: $pageType');
    update();
    return broadcastModel.value;
  }

  Future<BroadcastTypeModel> getBroadcastListDataForNextPage({
    String type = 'all',
    required String page,
    bool showLoader = true
  }) async {
    update();
    if(broadcastModel.value.data!.pagination!.lastPage! >= pageNumberGB){
      var data = await BroadcastService.getBroadcastList(
          type: type,
          pageName: pageNumberGB.toString(),
          showLoader: showLoader);
      if(data['statusCode'] == 200){
        meController.getMeData();
      }
      broadcastModel.value.data!.broadcasts!.addAll(BroadcastTypeModel.fromJson(data).data!.broadcasts!);
      print('NOW GLOBAL BROADCAST LIST LENGTH IS ${broadcastModel.value.data!.broadcasts!.length}');
      // if(broadcastModel.value.data!.pagination!.lastPage! <= pageNumberGB) {
      pageNumberGB++;
    }
    // }
    update();
    return broadcastModel.value;
  }

  globalBroadcastScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After GLOBAL BROADCAST Scroll Controller');
        // if(broadcastModel.value.data!.pagination!.lastPage! <= pageNumberGB) {
          getBroadcastListDataForNextPage(type: pageType, page: pageNumberGB.toString(), showLoader: true);
        // }
      }
    });
  }

  Future<MyBroadcastModel> getMyBroadcastListData({bool showLoader = false}) async {
    pageNumberMB = 1;
    var data = await BroadcastService.getMyBroadcastList(pageName: pageNumberMB.toString(), showLoader: showLoader);
    myBroadcastModel.value = MyBroadcastModel.fromJson(data);
    pageNumberMB++;
    update();
    return myBroadcastModel.value;
  }

  Future<MyBroadcastModel> getMyBroadcastListDataForNextPage({required String page, bool showLoader = false}) async {
    update();
    if(myBroadcastModel.value.data!.pagination!.lastPage! >= pageNumberMB){
      var data = await BroadcastService.getMyBroadcastList(pageName: pageNumberMB.toString(), showLoader: showLoader);
      myBroadcastModel.value.data!.broadcasts!.addAll(MyBroadcastModel.fromJson(data).data!.broadcasts!);
      print('NOW MY BROADCAST LIST LENGTH IS ${myBroadcastModel.value.data!.broadcasts!.length}');
      // {
      pageNumberMB++;
      // }
    }
    update();
    return myBroadcastModel.value;
  }

  myBroadcastScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After MY BROADCAST Scroll Controller');
        // if(myBroadcastModel.value.data!.pagination!.lastPage! <= pageNumberMB) {
          getMyBroadcastListDataForNextPage(page: pageNumberMB.toString(), showLoader: true);
        // }
      }
    });
  }

  Future deleteBroadcastData({required String bID})async{
    var data = await BroadcastService.deleteBroadcast(bID: bID);
    if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      getMyBroadcastListData();
      // Get.off(AppRoute.my)
      update();
    }
    update();
  }

  Future addBroadcastData({required String bText, required String bType})async{
    var data = await BroadcastService.addBroadcast(bText: bText, bType: bType);
    if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      Get.toNamed(AppRoute.dashBoard);
      update();
    }
    update();
  }

  contactUs({
    required String name,
    required String email,
    required String phone,
    required String message
  })async{
    var data = await BroadcastService.contactUs(
        name: name,
        email: email,
        phone: phone,
        message: message
    );
    if(data['statusCode'] == 201){
      Get.snackbar("SUCCESS", data['message'], borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      Get.toNamed(AppRoute.dashBoard);
    }
    update();
  }

  Future <ContactUsModel> contactUsDetails()async{
    var data = await BroadcastService.contactUSDetails();
    contactModel.value = ContactUsModel.fromJson(data);
    update();
    return contactModel.value;
  }

}