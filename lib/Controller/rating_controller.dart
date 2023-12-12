import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/dealer_controller.dart';
import 'package:kawawa_motors/Controller/garage_controller.dart';
import 'package:kawawa_motors/Controller/sp_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/Services/rating_services.dart';

class RatingController extends GetxController{

  VehicleController vehicleController = Get.put(VehicleController());
  SparePartsController spController = Get.put(SparePartsController());
  GarageController garageController = Get.put(GarageController());
  DealerController dealerController = Get.put(DealerController());

  giveSPRating({required String sparePartID, required double rating}) async {
    try{
      var data = await RatingServices.ratingSpareParts(sparePartID: sparePartID, rating: rating);
      if(data['statusCode'] == 201){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green.shade600);
        spController.getSPDetailsData(spId: sparePartID.toString());
        update();
      }else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }catch(e){
      print(e);
    }
    // return garageModel.value;
  }

  giveVehicleRating({required String vID, required double rating}) async {
    try{
      var data = await RatingServices.ratingVehicle(vID: vID, rating: rating);
      if(data['statusCode'] == 201){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green.shade600);
        vehicleController.getVehicleDetailsData(vid: vID.toString());
        update();
      }else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }catch(e){
      print(e);
    }
    // return garageModel.value;
  }

  giveGarageRating({required String garageID, required double rating}) async {
    try{
      var data = await RatingServices.ratingGarage(garageID: garageID, rating: rating);
      if(data['statusCode'] == 201){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green.shade600);
        garageController.getGarageDetailsData(gid: garageID.toString());
        update();
      }else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }catch(e){
      print(e);
    }
    // return garageModel.value;
  }

  giveDealerRating({required String dealerID, required double rating}) async {
    try{
      var data = await RatingServices.ratingGarage(garageID: dealerID, rating: rating);
      if(data['statusCode'] == 201){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green.shade600);
        dealerController.getDealerDetailsData(dealerId: dealerID.toString());
        update();
      }else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }catch(e){
      print(e);
    }
    // return garageModel.value;
  }

}