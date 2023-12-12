import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kawawa_motors/Model/image_model.dart';
import 'package:kawawa_motors/Services/add_services.dart';

import '../Routes/app_route.dart';

class AddController extends GetxController{

  String carMakerID = '';
  String carModelID = '';
  String vehicleTypeID = '';
  String conditionID = '';
  String countryID = '';
  String stateID = '';
  String cityID = '';
  String fuelID = '';
  String gearBoxID = '';
  String colorID = '';
  String engineSizeID = '';
  String currencyID = '';
  String whenToStartID = '';
  String spCategoryID = '';
  String spSubCategoryID = '';
  // String bPhoneCodeID = '';

  var uploadedPicture = "".obs;
  var uploadedLogo = "".obs;
  var picturePath = false.obs;
  List <ImageModel> selectedImages = [];
  List selectedImageID = [].obs;


  uploadPicture({ImageSource ims = ImageSource.gallery}) async {
    try {
      var image;
      image = await ImagePicker().pickImage(source: ims);
      if (image != null) {
        CroppedFile? croppedFile =
        await ImageCropper().cropImage(
          sourcePath: image!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
        );
        // PickedFile pickedImage = image;
        File pickedImage = File(croppedFile!.path);
        final lastIndex = pickedImage.path.lastIndexOf(RegExp(r'.jp'));
        final splitted = pickedImage.path.substring(0, (lastIndex));
        final outPath = "${splitted}_out${pickedImage.path.substring(lastIndex)}";
        print('== UPLOAD PICTURE ==');
        var file = await FlutterImageCompress.compressAndGetFile(
            pickedImage.path, outPath,
            quality: 35);

        uploadedPicture.value = file!.path;
        picturePath.value = true;
        print(uploadedPicture.value);
        update();
      } else {}
    } catch (e) {
      print(e);
    }
  }

  uploadMultiplePicture({ImageSource ims = ImageSource.gallery}) async {
    try {
      var image = await ImagePicker().pickImage(source: ims);
      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
        );
        // PickedFile pickedImage = image;
        File pickedImage = File(croppedFile!.path);
        final lastIndex = pickedImage.path.lastIndexOf(RegExp(r'.jp'));
        final splitted = pickedImage.path.substring(0, (lastIndex));
        final outPath = "${splitted}_out${pickedImage.path.substring(lastIndex)}";
        print('== UPLOAD MULTIPLE PICTURE ==');
        var file = await FlutterImageCompress.compressAndGetFile(
            pickedImage.path, outPath,
            quality: 35);
        List<String> xFilePick = [file!.path];
        if (xFilePick.isNotEmpty) {
          for (var i = 0; i < xFilePick.length; i++) {
            selectedImages.add(ImageModel(imageUrl: File(xFilePick[i]).path));
            print(selectedImages[i].imageUrl);
          }
          update();
        } else {}
        // uploadedPicture.value = file!.path;
        // picturePath.value = true;
        // print(uploadedPicture.value);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  uploadLogo({ImageSource ims = ImageSource.gallery}) async {
    try {
      var image;
      image = await ImagePicker().pickImage(source: ims);
      if (image != null) {
        CroppedFile? croppedFile =
        await ImageCropper().cropImage(
          sourcePath: image!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
        );
        // PickedFile pickedImage = image;
        File pickedImage = File(croppedFile!.path);
        final lastIndex = pickedImage.path.lastIndexOf(RegExp(r'.jp'));
        final splitted = pickedImage.path.substring(0, (lastIndex));
        final outPath = "${splitted}_out${pickedImage.path.substring(lastIndex)}";
        print('== UPLOAD PICTURE ==');
        var file = await FlutterImageCompress.compressAndGetFile(
            pickedImage.path, outPath,
            quality: 35);
        uploadedLogo.value = file!.path;
        picturePath.value = true;
        update();
      } else {}
    } catch (e) {
      print(e);
    }
  }

  addVehicleData({
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
      var data = await AddServices.addVehicle(
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
      if(data["statusCode"]==201){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        Get.offAllNamed(AppRoute.dashBoard);
      }
      else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }

  addSparePartsData({
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
      var data = await AddServices.addSpareParts(
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
      if(data["statusCode"]==201){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        Get.offAllNamed(AppRoute.dashBoard);
      }
      else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }

  addGarageData({
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
      Get.snackbar("ERROR", 'Garage Logo is required',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
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
      var data = await AddServices.addGarage(
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
      if(data["statusCode"] == 201){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        Get.offAllNamed(AppRoute.dashBoard);
      }
      else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }


}