import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';

import '../Model/image_model.dart';
import '../Model/spare_part_details_model.dart';
import '../Services/sp_services.dart';

class SparePartsController extends GetxController{

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  AddController addController = Get.put(AddController());

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());

  var spModel = SparePartDetailsModel().obs;

  Future<SparePartDetailsModel> getSPDetailsData({required String spId}) async {
    var data = await SparePartsServices.getSparePartsDetails(spId);
    // try {
      if(data['statusCode'] == 200){
        spModel.value = SparePartDetailsModel.fromJson(data);
        for (var element in spModel.value.data!.sparePartImages!) {
          addController.selectedImages.add(ImageModel(
              imageUrl: element.imageUrl,
              imageID: element.sparePartImageId
          ));
        }
        addController.selectedImages.removeAt(0);
        makeController.text = spModel.value.data!.sparePart!.maker!.carMakerName!;
        modelController.text = spModel.value.data!.sparePart!.model!.carModelName!;
        conditionController.text = spModel.value.data!.sparePart!.condition!.carConditionName!;
        countryController.text = spModel.value.data!.sparePart!.country!.countryName!;
        regionController.text = spModel.value.data!.sparePart!.state!.stateName!;
        cityController.text = spModel.value.data!.sparePart!.city!.cityName!;
        dateController.text = spModel.value.data!.sparePart!.manufacturingYear!;
        categoryController.text = spModel.value.data!.sparePart!.category!.categoryTitle!;
        subCategoryController.text = spModel.value.data!.sparePart!.subCategory!.subCategoryTitle!;
        titleController.text = spModel.value.data!.sparePart!.title!;
        descController.text = spModel.value.data!.sparePart!.description!;
        currencyController.text = spModel.value.data!.sparePart!.currency!;
        priceController.text = spModel.value.data!.sparePart!.price!;

        addController.uploadedPicture.value = spModel.value.data!.sparePart!.sparePartPrimaryImageUrl!;
        addController.carMakerID = spModel.value.data!.sparePart!.maker!.carMakerId!;
        addController.carModelID = spModel.value.data!.sparePart!.model!.carModelId!;
        addController.conditionID = spModel.value.data!.sparePart!.condition!.carConditionId!;
        addController.countryID = spModel.value.data!.sparePart!.country!.countryId!;
        addController.stateID = spModel.value.data!.sparePart!.state!.stateId!;
        addController.cityID = spModel.value.data!.sparePart!.city!.cityId!;
        addController.spCategoryID = spModel.value.data!.sparePart!.category!.categoryId!;
        addController.spSubCategoryID = spModel.value.data!.sparePart!.subCategory!.subCategoryId!;
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
      }
    // } catch (e) {
    //   print(e);
    // }
    update();
    return spModel.value;
  }

  Future deleteSparePart({required String spID})async{
    var data = await SparePartsServices.deleteSpareParts(spID: spID);
    if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      seeAllController.getMySparePartsListData();
    }else{
      Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
    }
  }

  Future deleteSPImage({required String spImgID})async {
    var data = await SparePartsServices.deleteSPImage(spImgID: spImgID);
    if (data['statusCode'] == 200) {
      Get.snackbar("SUCCESS", data['message'], borderRadius: 5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.black);
      for (var element in addController.selectedImages) {
        if(element.imageID == spImgID){
          addController.selectedImages.remove(element);
          addController.update();
          break;
        }
      }
    }else{
      Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
    }
  }
}