import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/Services/update_services.dart';

import '../Model/vehicle_details_model.dart';
import '../Routes/app_route.dart';



class UpdateController extends GetxController{
  VehicleController vehicleController = Get.put(VehicleController());

  AddController addController = Get.put(AddController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // vehicleController.getVehicleDetailsData(vid: vid);

    // addController.carMakerID = vDetails.value.data!.vehicle!.maker!.carMakerId!;
    // carMakerName = vDetails.value.data!.vehicle!.maker!.carMakerName!;
    // addController.carModelID = vDetails.value.data!.vehicle!.model!.carModelId!;
    // carModelName = vDetails.value.data!.vehicle!.model!.carModelName!;
    // addController.vehicleTypeID = vDetails.value.data!.vehicle!.vehicleType!.carTypeId!;
    //
    // print(carMakerName);
    // print(carModelName);

  }

  var vDetails = VehicleDetailsModel().obs;
  var carMakerName = '';
  var carModelName = '';
  var vehicleTypeName = '';

  updateVehicleData({
    required String vehicleID,
    required String vehiclePrimaryImage,
    required List vehicleImages,
    required String carMakerId,
    required String carModelId,
    required String carTypeId,
    required String carConditionId,
    required String countryId,
    required String stateId,
    required String cityId,
    required String manufacturingYear,
    required String carFuelTypeId,
    required String carGearBoxId,
    required String carColorId,
    required String carEngineSizeId,
    required String description,
    required String mileage,
    required String currency,
    required String price,
    required String youtubeUrl,
    required String whenToStartId,
  }) async {
    if(vehiclePrimaryImage == ''){
      Get.snackbar("ERROR", 'Vehicle primary image is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carMakerId == ''){
      Get.snackbar("ERROR", 'Car maker id is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carModelId == ''){
      Get.snackbar("ERROR", 'Car model id is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carTypeId == ''){
      Get.snackbar("ERROR", 'Vehicle type is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carConditionId == ''){
      Get.snackbar("ERROR", 'Vehicle condition is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(countryId == ''){
      Get.snackbar("ERROR", 'Please select country',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(stateId == ''){
      Get.snackbar("ERROR", 'Please select state',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(cityId == ''){
      Get.snackbar("ERROR", 'Please select city',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(manufacturingYear == ''){
      Get.snackbar("ERROR", 'Manufacturing year is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carFuelTypeId == ''){
      Get.snackbar("ERROR", 'Please select fuel type',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carGearBoxId == ''){
      Get.snackbar("ERROR", 'Please select gear box type',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carColorId == ''){
      Get.snackbar("ERROR", 'Please select car color',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carEngineSizeId == ''){
      Get.snackbar("ERROR", 'Please select engine size',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(mileage == ''){
      Get.snackbar("ERROR", 'Mileage is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(price == ''){
      Get.snackbar("ERROR", 'Price is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else {
      var data = await UpdateServices.updateVehicle(
          vID: vehicleID,
          vehiclePrimaryImage: vehiclePrimaryImage,
          vehicleImages: vehicleImages,
          carMakerId: carMakerId,
          carModelId: carModelId,
          carTypeId: carTypeId,
          carConditionId: carConditionId,
          countryId: countryId,
          stateId: stateId,
          cityId: cityId,
          manufacturingYear: manufacturingYear,
          carFuelTypeId: carFuelTypeId,
          carGearBoxId: carGearBoxId,
          carColorId: carColorId,
          carEngineSizeId: carEngineSizeId,
          description: description,
          mileage: mileage,
          currency: currency,
          price: price,
          youtubeUrl: youtubeUrl,
          whenToStartId: whenToStartId
      );
      if(data["statusCode"]==200){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        Get.offAllNamed(AppRoute.dashBoard);
      }
      else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }

  updateSparePartsData({
    required String spID,
    required String sparePartPrimaryImage,
    required List sparePartImages,
    required String carMakerId,
    required String carModelId,
    required String carConditionId,
    required String countryId,
    required String stateId,
    required String cityId,
    required String manufacturingYear,
    required String spCategoryId,
    required String spSubCategoryId,
    required String title,
    required String description,
    required String currency,
    required String price,
  }) async {
    if(sparePartPrimaryImage == ''){
      Get.snackbar("ERROR", 'Vehicle primary image is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carMakerId == ''){
      Get.snackbar("ERROR", 'Car maker id is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carModelId == ''){
      Get.snackbar("ERROR", 'Car model id is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(spCategoryId == ''){
      Get.snackbar("ERROR", 'Please select category',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(carConditionId == ''){
      Get.snackbar("ERROR", 'Vehicle condition is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(countryId == ''){
      Get.snackbar("ERROR", 'Please select country',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(stateId == ''){
      Get.snackbar("ERROR", 'Please select state',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(cityId == ''){
      Get.snackbar("ERROR", 'Please select city',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(manufacturingYear == ''){
      Get.snackbar("ERROR", 'Manufacturing year is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(spSubCategoryId == ''){
      Get.snackbar("ERROR", 'Please select sub category',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(price == ''){
      Get.snackbar("ERROR", 'Price is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else {
      var data = await UpdateServices.updateSP(
          spID: spID,
          sparePartPrimaryImage: sparePartPrimaryImage,
          sparePartImages: sparePartImages,
          carMakerId: carMakerId,
          carModelId: carModelId,
          carConditionId: carConditionId,
          countryId: countryId,
          stateId: stateId,
          cityId: cityId,
          manufacturingYear: manufacturingYear,
          spCategoryId: spCategoryId,
          spSubCategoryId: spSubCategoryId,
          title: title,
          description: description,
          currency: currency,
          price: price
      );
      if(data["statusCode"]==200){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        Get.offAllNamed(AppRoute.dashBoard);
      }
      else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }

  updateGarageData({
    required String garageID,
    required String garagePrimaryImage,
    required String garageSecondaryImage,
    required List garageImages,
    required String countryId,
    required String stateId,
    required String cityId,
    required String garageName,
    required String garageStartTime,
    required String garageEndTime,
    required String personName,
    required String personEmail,
    required String personNumber,
    required String websiteUrl,
    required String services,
    required String description,
  }) async {
    if(garagePrimaryImage == ''){
      Get.snackbar("ERROR", 'Vehicle primary image is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    // else if(carMakerId == ''){
    //   Get.snackbar("ERROR", 'Car maker id is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    // else if(carModelId == ''){
    //   Get.snackbar("ERROR", 'Car model id is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    // else if(spCategoryId == ''){
    //   Get.snackbar("ERROR", 'Please select category',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    // else if(carConditionId == ''){
    //   Get.snackbar("ERROR", 'Vehicle condition is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(countryId == ''){
      Get.snackbar("ERROR", 'Please select country',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(stateId == ''){
      Get.snackbar("ERROR", 'Please select state',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(cityId == ''){
      Get.snackbar("ERROR", 'Please select city',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(garageName == ''){
      Get.snackbar("ERROR", 'Garage name is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(garageStartTime == ''){
      Get.snackbar("ERROR", 'Please enter start time',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if(garageEndTime == ''){
      Get.snackbar("ERROR", 'Please enter end time',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else {
      var data = await UpdateServices.updateGarage(
          garageId: garageID,
          garagePrimaryImage: garagePrimaryImage,
          garageSecondaryImage: garageSecondaryImage,
          garageImages: garageImages,
          countryId: countryId,
          stateId: stateId,
          cityId: cityId,
          garageName: garageName,
          garageStartTime: garageStartTime,
          garageEndTime: garageEndTime,
          personName: personName,
          personEmail: personEmail,
          personNumber: personNumber,
          websiteUrl: websiteUrl,
          services: services,
          description: description
      );
      if(data["statusCode"]==200){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        Get.offAllNamed(AppRoute.dashBoard);
      }
      else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }

}