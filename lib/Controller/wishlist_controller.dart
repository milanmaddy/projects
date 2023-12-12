import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kawawa_motors/Controller/sp_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/Model/car_wishlist_model.dart';
import 'package:kawawa_motors/Model/garage_wishlist_model.dart';
import 'package:kawawa_motors/Model/sp_wishlist_model.dart';
import 'package:kawawa_motors/Services/repair_garage_services.dart';
import 'package:kawawa_motors/Services/sp_services.dart';
import 'package:kawawa_motors/Services/vehicle_services.dart';
import 'package:kawawa_motors/Services/wishlist_services.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import 'garage_controller.dart';

class WishListController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    vehicleScrollController();
    spScrollController();
    garageScrollController();
  }
  ScrollController scrollController = Get.put(ScrollController());

  VehicleController vehicleController = Get.put(VehicleController());
  SparePartsController spController = Get.put(SparePartsController());
  GarageController garageController = Get.put(GarageController());

  var fabCarList = CarWishlistModel().obs;
  var fabSPList = SPWishlistModel().obs;
  var fabGarageList = GarageWishlistModel().obs;

  int pageNumberV = 1;
  int pageNumberSP = 1;
  int pageNumberG = 1;


  Future getWishListCarData({required String vID, required String userID})async{
    var data = await WishListServices.wishlistCar(vId: vID, userID: userID);
    // Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
    if(data['statusCode'] == 201){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      print('SUCCESS');
      getFavCarListData(showLoader: false);
      vehicleController.getVehicleDetailsData(vid: vID);
      getFavCarListData(showLoader: false);
      update();
    }else if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      getFavCarListData(showLoader: false);
      vehicleController.getVehicleDetailsData(vid: vID);
      update();
    }
    update();
  }

  Future getWishListSPData({required String spID, required String userID})async{
    var data = await WishListServices.wishlistSP(spID: spID, userID: userID);
    // Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
    if(data['statusCode'] == 201){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      print('SUCCESS');
      getFavSPListData();
      spController.getSPDetailsData(spId: spID);
      update();
    }else if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      getFavSPListData();
      spController.getSPDetailsData(spId: spID);
      update();
    }
    update();
  }

  Future getWishListGarageData({required String garageID, required String userID})async{
    var data = await WishListServices.wishlistGarage(
        garageID: garageID,
        userID: userID
    );
    if(data['statusCode'] == 201){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      getFavGarageListData();
      garageController.getGarageDetailsData(gid: garageID);
      update();
    }else if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      getFavGarageListData();
      garageController.getGarageDetailsData(gid: garageID);
      update();
    }
    update();
  }

  Future<CarWishlistModel> getFavCarListData({bool showLoader = false}) async {
    pageNumberV = 1;
    var data = await VehicleServices.getFavouriteCarList(pageName: pageNumberV.toString(), showLoader: showLoader);
      fabCarList.value = CarWishlistModel.fromJson(data);
    print('FAB CAR LENGTH IS: ${fabCarList.value.data!.likedVehicles!.length}');
      pageNumberV++;
    update();
    return fabCarList.value;
  }
  Future<CarWishlistModel> getFavCarListDataForNextPage({required String page, bool showLoader = true}) async {
    // update();
      if(fabCarList.value.data!.pagination!.lastPage! >= pageNumberV) {
        print('NOW PAGE First NUMBER IS: $pageNumberV');
        var data = await VehicleServices.getFavouriteCarList(pageName: pageNumberV.toString(), showLoader: showLoader);
        fabCarList.value.data!.likedVehicles!.addAll(CarWishlistModel.fromJson(data).data!.likedVehicles!);
        print('NOW FAB CAR LENGTH IS: ${fabCarList.value.data!.likedVehicles!.length}');
        print('=====');
        pageNumberV++;
        print('NOW PAGE Last NUMBER IS: $pageNumberV');
      }
    update();
    return fabCarList.value;
  }

  Future<SPWishlistModel> getFavSPListData({bool showLoader = false}) async {
    // update();
    pageNumberSP = 1;
    var data = await SparePartsServices.getFavouriteSPList(pageName: pageNumberSP.toString(), showLoader: showLoader);
      fabSPList.value = SPWishlistModel.fromJson(data);
      pageNumberSP++;
    update();
    return fabSPList.value;
  }

  Future<SPWishlistModel> getFavSPListDataForNextPage({required String page, required bool showLoader}) async {
    update();
    if(fabSPList.value.data!.pagination!.lastPage! >= pageNumberSP){
      var data = await SparePartsServices.getFavouriteSPList(pageName: pageNumberSP.toString(), showLoader: showLoader);
      fabSPList.value.data!.likedSpareParts!.addAll(SPWishlistModel.fromJson(data).data!.likedSpareParts!);
      print('NOW FAB SP LENGTH IS: ${fabSPList.value.data!.likedSpareParts!.length}');
      pageNumberSP++;
    }
    update();
    return fabSPList.value;
  }

  Future<GarageWishlistModel> getFavGarageListData() async {
    // update();
    pageNumberG = 1;
    var data = await RepairGarageServices.getFavouriteGarageList(pageName: pageNumberG.toString());
      fabGarageList.value = GarageWishlistModel.fromJson(data);
      pageNumberG++;
    update();
    return fabGarageList.value;
  }

  Future<GarageWishlistModel> getFavGarageListDataForNextPage({required String page}) async {
    update();
    var data = await RepairGarageServices.getFavouriteGarageList(pageName: pageNumberG.toString());
      fabGarageList.value.data!.likedGarages!.addAll(GarageWishlistModel.fromJson(data).data!.likedGarages!);
      pageNumberG++;
      // update();
    update();
    return fabGarageList.value;
  }


  vehicleScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After FAVOURITE VEHICLE Scroll Controller');
        // if(fabCarList.value.data!.pagination!.lastPage! <= pageNumberV) {
          getFavCarListDataForNextPage(page: pageNumberV.toString(), showLoader: true);
        // }
      }
    });
  }

  spScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After FAVOURITE SPARE PARTS Scroll Controller');
        getFavSPListDataForNextPage(page: pageNumberSP.toString(), showLoader: true);
      }
    });
  }

  garageScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After FAVOURITE GARAGE Scroll Controller');
        getFavGarageListDataForNextPage(page: pageNumberG.toString());
      }
    });
  }

}