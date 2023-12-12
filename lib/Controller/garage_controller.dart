import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Model/image_model.dart';
import 'package:kawawa_motors/Model/repair_garage_details_model.dart';
import 'package:kawawa_motors/Services/repair_garage_services.dart';

class GarageController extends GetxController{
  var garageModel = RepairGarageDetailsModel().obs;

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController personController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController garageController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  AddController addController = Get.put(AddController());

  Future getGarageDetailsData({required String gid}) async {
    var data = await RepairGarageServices.getGarageDetails(gid);
    // try {
      if(data['statusCode'] == 200){
        garageModel.value = RepairGarageDetailsModel.fromJson(data);
        for (var element in garageModel.value.data!.garage!.images!) {
                  addController.selectedImages.add(ImageModel(
                      imageUrl: element.imageUrl,
                      imageID: element.garageImageId)
                  );}
        addController.selectedImages.removeAt(0);
        garageController.text = garageModel.value.data!.garage!.garageName!;
        startTimeController.text = garageModel.value.data!.garage!.garageStartTime!;
        endTimeController.text = garageModel.value.data!.garage!.garageEndTime!;
        personController.text = garageModel.value.data!.garage!.contactPersonName!;
        emailController.text = garageModel.value.data!.garage!.contactPersonEmail!;
        contactController.text = garageModel.value.data!.garage!.contactPersonNumber!;
        countryController.text = garageModel.value.data!.garage!.country!.countryName!;
        regionController.text = garageModel.value.data!.garage!.state!.stateName!;
        cityController.text = garageModel.value.data!.garage!.city!.cityName!;
        websiteController.text = garageModel.value.data!.garage!.websiteUrl!;
        serviceController.text = garageModel.value.data!.garage!.services!;
        descController.text = garageModel.value.data!.garage!.description!;
        addController.uploadedLogo.value = garageModel.value.data!.garage!.garagePrimaryImageUrl!;
        addController.uploadedPicture.value = garageModel.value.data!.garage!.garageSecondaryImageUrl!;
        addController.countryID = garageModel.value.data!.garage!.country!.countryId!;
        addController.stateID = garageModel.value.data!.garage!.state!.stateId!;
        addController.cityID = garageModel.value.data!.garage!.city!.cityId!;
        if(addController.countryID != ''){
          await seeAllController.getStateListData(countryID: addController.countryID, showLoader: false);
          // update();
          print('NOW STATE LIST FETCHED');
        }
        if(addController.stateID != ''){
          await seeAllController.getCityListData(stateID: addController.stateID, showLoader: false);
          update();
          print('NOW CITY LIST FETCHED');

        }
        update();
      }
    // } catch (e) {
    //   print(e);
    // }
    update();
    return garageModel.value;
  }

  Future deleteGarage({required String garageID})async{
    var data = await RepairGarageServices.deleteGarage(garageID: garageID);
    if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      seeAllController.getMyGarageListData();
    }else{
      Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
    }
  }

  Future deleteGarageImage({required String garageImgID})async {
    var data = await RepairGarageServices.deleteGarageImage(garageImgID: garageImgID);
    if (data['statusCode'] == 200) {
      Get.snackbar("SUCCESS", data['message'], borderRadius: 5,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.black);
      for (var element in addController.selectedImages) {
        if(element.imageID == garageImgID){
          addController.selectedImages.remove(element);
          addController.update();
          break;
        }
      }
      // getGarageDetailsData(gid: gid);
    }else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
}