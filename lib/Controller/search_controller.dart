import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Model/see_all_dealer_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Services/search_services.dart';

import '../Model/see_all_garage_model.dart';

class SearchDataController extends GetxController{

  var searchGarage = SeeAllGarageModel().obs;
  var searchDealer = SeeAllDealerModel().obs;

  String countryID = '';
  String stateID = '';
  String cityID = '';

  int pageNumber = 1;
  String pageCountryId = '';
  // String pageMakerId = '';
  // String pageModelId = '';
  String pageStateId = '';
  String pageCityId = '';
  // String pageBTypeId = '';

  Future<SeeAllGarageModel> getSearchedGarageData({
    required String countryId,
    required String stateId,
    required String cityId
  }) async {
    // searchGarage.value.data = null;
    // update();
    // garageScrollController();
    // pageNumber = 1;
    // pageCountryId = countryId;
    // pageStateId = stateId;
    // pageCityId = cityId;
    // if(countryId == ''){
    //   Get.snackbar("SUCCESS", 'Please select country',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.red);
    // }else if(stateId == ''){
    //   Get.snackbar("SUCCESS", 'Please select state',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.red);
    // }else if(cityId == ''){
    //   Get.snackbar("SUCCESS", 'Please select country',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.red);
    // }
    var data = await SearchServices.getSearchedGarageDetails(
        countryID: countryId,
        stateID: stateId,
        cityID: cityId,
      // pageNumber: pageNumber.toString()
    );
    if(data['statusCode'] == 200){
      Get.toNamed(AppRoute.searchedGarage, arguments: [
        countryId, stateId, cityId, 'search'
      ]);
    }
    searchGarage.value = SeeAllGarageModel.fromJson(data);
    // pageNumber++;
    // print('AFTER INCREMENTED, THE PAGE NUMBER IS $pageNumber FOR GARAGE');
    update();
    return searchGarage.value;
  }

}