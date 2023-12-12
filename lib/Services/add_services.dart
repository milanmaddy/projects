import 'package:dio/dio.dart' as dioClient;

import '../GlobalWidgets/loader.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class AddServices{

  static addVehicle({
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
  })async{
    try {
      PRLoader.show();
      String fileName = vehiclePrimaryImage.split('/').last;
      var mData = {
        'vehiclePrimaryImage': await dioClient.MultipartFile.fromFile(
          vehiclePrimaryImage,
          filename: fileName,
        )
      };
      List carList = [];
      for (var file in vehicleImages) {
        String fileName2 = file.imageUrl.split('/').last;
        var multipartFile = await dioClient.MultipartFile.fromFile(
            file.imageUrl,
          filename: fileName2
        );
        carList.add(multipartFile);
      }
      var mData2 = {
        'vehicleImages[]': carList.toList()
      };
      dioClient.Response response;
      dioClient.FormData formData = dioClient.FormData.fromMap({
        // "vehicleImages[]": vehicleImages,
        "listingType": 'normal',
        "carMakerId": carMakerId,
        "carModelId": carModelId,
        "carTypeId": carTypeId,
        "carConditionId": carConditionId,
        "countryId": countryId,
        "stateId": stateId,
        "cityId": cityId,
        "manufacturingYear": manufacturingYear,
        "carFuelTypeId": carFuelTypeId,
        "carGearBoxId": carGearBoxId,
        "carColorId": carColorId,
        "carEngineSizeId": carEngineSizeId,
        "description": description,
        "mileage": mileage,
        "currency": currency,
        "price": price,
        "youtubeUrl": youtubeUrl,
        "whenToStartId": whenToStartId,
        ...mData,
        ...mData2
      });
      print({
        // "vehicleImages[]": vehicleImages,
        "listingType": 'normal',
        "carMakerId": carMakerId,
        "carModelId": carModelId,
        "carTypeId": carTypeId,
        "carConditionId": carConditionId,
        "countryId": countryId,
        "stateId": stateId,
        "cityId": cityId,
        "manufacturingYear": manufacturingYear,
        "carFuelTypeId": carFuelTypeId,
        "carGearBoxId": carGearBoxId,
        "carColorId": carColorId,
        "carEngineSizeId": carEngineSizeId,
        "description": description,
        "mileage": mileage,
        "currency": currency,
        "price": price,
        "youtubeUrl": youtubeUrl,
        "whenToStartId": whenToStartId,
        ...mData,
        ...mData2
      });
      response = await BaseUrl.getDio1().post("vehicle/create-new-vehicle",
          data: formData,
          options: dioClient.Options(contentType: "multipart/form-data",
          headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken().toString()}"}));
      PRLoader.hide();
      print(response.data);
      return response.data;
    }catch(e){
      print(e);
      PRLoader.hide();
    }
  }

  static addSpareParts({
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
  })async{
    try {
      PRLoader.show();
      String fileName = sparePartPrimaryImage.split('/').last;
      var mData = {
        'sparePartPrimaryImage': await dioClient.MultipartFile.fromFile(
          sparePartPrimaryImage,
          filename: fileName,
        )
      };
      List spList = [];
      for (var file in sparePartImages) {
        String fileName2 = file.imageUrl.split('/').last;
        var multipartFile = await dioClient.MultipartFile.fromFile(
            file.imageUrl,
            filename: fileName2
        );
        spList.add(multipartFile);
      }
      var mData2 = {
        'sparePartImages[]': spList.toList()
      };
      dioClient.Response response;
      dioClient.FormData formData = dioClient.FormData.fromMap({
        // "sparePartImages": sparePartImages,
        "carMakerId": carMakerId,
        "carModelId": carModelId,
        "carConditionId": carConditionId,
        "countryId": countryId,
        "stateId": stateId,
        "cityId": cityId,
        "manufacturingYear": manufacturingYear,
        "sparePartCategoryId": spCategoryId,
        "sparePartSubCategoryId": spSubCategoryId,
        "title": title,
        "description": description,
        "currency": currency,
        "price": price,
        ...mData,
        ...mData2
      });
      // print(formData);
      response = await BaseUrl.getDio1().post("spare-part/create-new-spare-part",
          data: formData,
          options: dioClient.Options(contentType: "multipart/form-data",
              headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken().toString()}"}));
      PRLoader.hide();
      print(response.data);
      return response.data;
    }catch(e){
      PRLoader.hide();
    }
  }

  static addGarage({
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
  })async{
    try {
      PRLoader.show();
      String fileName = garagePrimaryImage.split('/').last;
      String fileName2 = garageSecondaryImage.split('/').last;
      var logo = {
        'garagePrimaryImage': await dioClient.MultipartFile.fromFile(
          garagePrimaryImage,
          filename: fileName,
        )
      };

      var image = {
        'garageSecondaryImage': await dioClient.MultipartFile.fromFile(
          garageSecondaryImage,
          filename: fileName2,
        )
      };
      List garageList = [];
      for (var file in garageImages) {
        String fileName3 = file.imageUrl.split('/').last;
        var multipartFile = await dioClient.MultipartFile.fromFile(
            file.imageUrl,
            filename: fileName3
        );
        garageList.add(multipartFile);
      }
      var mData = {
        'garageImages[]': garageList.toList()
      };
      dioClient.Response response;
      dioClient.FormData formData = dioClient.FormData.fromMap({
        // "garageImages": garageImages,
        "countryId": countryId,
        "stateId": stateId,
        "cityId": cityId,
        "garageName": garageName,
        "garageStartTime": garageStartTime,
        "garageEndTime": garageEndTime,
        "contactPersonName": personName,
        "contactPersonEmail": personEmail,
        "contactPersonNumber": personNumber,
        "websiteUrl": websiteUrl,
        "services": services,
        "description": description,
        ...logo,
        ...image,
        ...mData
      });
      print({
        // "garageImages": garageImages,
        "countryId": countryId,
        "stateId": stateId,
        "cityId": cityId,
        "garageName": garageName,
        "garageStartTime": garageStartTime,
        "garageEndTime": garageEndTime,
        "contactPersonName": personName,
        "contactPersonEmail": personEmail,
        "contactPersonNumber": personNumber,
        "websiteUrl": websiteUrl,
        "services": services,
        "description": description,
        ...logo,
        ...image,
        ...mData
      });
      response = await BaseUrl.getDio1().post("garage/create-new-garage",
          data: formData,
          options: dioClient.Options(contentType: "multipart/form-data",
              headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken().toString()}"}));
      PRLoader.hide();
      print(response.data);
      return response.data;
    }catch(e){
      PRLoader.hide();
    }
  }

}