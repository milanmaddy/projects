import 'package:kawawa_motors/Model/my_garage_model.dart';
import 'package:kawawa_motors/Model/my_spare_parts_model.dart';
import 'package:kawawa_motors/Model/see_all_dealer_model.dart';
import 'package:kawawa_motors/Model/see_all_garage_model.dart';
import 'package:kawawa_motors/Model/see_all_spare_parts_model.dart';
import 'package:kawawa_motors/Model/see_all_vehicle_model.dart';

import '../GlobalWidgets/loader.dart';
import '../Model/my_vehicle_model.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';
import 'package:dio/dio.dart' as dioClient;

class SeeAllServices{

  static getSeeAllVehicleDetails({
    required String pageNumber,
    required String carMakerId,
    required String carModelId,
    required String vehicleTypeId,
    required String sellerTypeId,
    required String countryId,
    required String stateId,
    required String cityId,
    required String carConditionId,
    required String carFuelTypeId,
    required String carGearBoxId,
    required String carColorId,
    required String carEngineSizeId,
    required String minMileage,
    required String maxMileage,
    required String minPrice,
    required String maxPrice,
    required String userId,
    bool showLoader = false,
  }) async {
    try {
      if(showLoader == true)
      PRLoader.show();
      print('QUERY PARAMETER');
      print(
        {
          'vehicleType':'normal',
          'page': pageNumber,
          'size': '10',
          'carMakerId': carMakerId,
          'carModelId': carModelId,
          'vehicleTypeId': vehicleTypeId,
          'sellerTypeId': sellerTypeId,
          'countryId': countryId,
          'stateId': stateId,
          'cityId': cityId,
          'carConditionId': carConditionId,
          'carFuelType': carFuelTypeId,
          'carGearBoxId': carGearBoxId,
          'carColorId': carColorId,
          'carEngineSizeId': carEngineSizeId,
          'minMileage': minMileage,
          'maxMileage': maxMileage,
          'minPrice': minPrice,
          'maxPrice': maxPrice,
          'userId': userId,
        },
      );
      dioClient.Response response;
      dioClient.Options options = SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json'):
      dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("vehicle/get-all-vehicles",
          queryParameters: {
            'vehicleType':'normal',
            'page': pageNumber,
            'size': '10',
            'carMakerId': carMakerId,
            'carModelId': carModelId,
            'vehicleTypeId': vehicleTypeId,
            'sellerTypeId': sellerTypeId,
            'countryId': countryId,
            'stateId': stateId,
            'cityId': cityId,
            'carConditionId': carConditionId,
            'carFuelType': carFuelTypeId,
            'carGearBoxId': carGearBoxId,
            'carColorId': carColorId,
            'carEngineSizeId': carEngineSizeId,
            'minMileage': minMileage,
            'maxMileage': maxMileage,
            'minPrice': minPrice,
            'maxPrice': maxPrice,
            'userId': userId,
          },
          options: options
      );
      if(showLoader == true)
      PRLoader.hide();
      print('RESPONSE');
      print(response.data);
      return response.data;
    }catch (e){
      if(showLoader == true)
      PRLoader.hide();
      return SeeAllVehicleModel();
    }
  }

  static getSeeAllSparePartsDetails({
    String page = '1',
    required String carMakerID,
    required String carModelID,
    required String sellerID,
    required String countryID,
    required String stateID,
    required String cityID,
    required String conditionID,
    required String categoryID,
    required String subCategoryID,
    required String userID,
    bool showLoader = false,
  }) async {
    print({
      'page': page,
      'size': '10',
      'makerId': carMakerID,
      'modelId': carModelID,
      'sellerTypeId': sellerID,
      'countryId': countryID,
      'stateId': stateID,
      'cityId': cityID,
      'conditionId': conditionID,
      'categoryId': categoryID,
      'subCategoryId': subCategoryID,
      'userId': userID,
    });
    try {
      if(showLoader == true)
        PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json'):
      dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("spare-part/get-all-spare-parts",
          queryParameters: {
            'page': page,
            'size': '10',
            'makerId': carMakerID,
            'modelId': carModelID,
            'sellerTypeId': sellerID,
            'countryId': countryID,
            'stateId': stateID,
            'cityId': cityID,
            'conditionId': conditionID,
            'categoryId': categoryID,
            'subCategoryId': subCategoryID,
            'userId': userID,
          },
          options: options
      );
      if(showLoader == true)
      PRLoader.hide();
      print(response.data);
      return response.data;
    }catch (e){
      if(showLoader == true)
        PRLoader.hide();
      return SeeAllSparePartsModel();
    }
  }

  static getSeeAllGarageDetails({
    required String countryID,
    String pageNumber = '1',
    required String stateID,
    required String cityID,
    required String userID,
    bool showLoader = false,
  }) async {
    print('QUERY PARAMETER');
    print({
      'page': pageNumber,
      'size': '10',
      'countryId': countryID,
      'stateId': stateID,
      'cityId': cityID,
      'userId': userID,
    },);
    try {
      if(showLoader == true)
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json'):
      dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("garage/get-all-garages",
          queryParameters: {
            'page': pageNumber,
            'size': '10',
            'countryId': countryID,
            'stateId': stateID,
            'cityId': cityID,
            'userId': userID,
          },
          options: options
      );
      if(showLoader == true)
      PRLoader.hide();
      print('GARAGE DATA');
      print(response);
      return response.data;
    }catch (e){
      if(showLoader == true)
      PRLoader.hide();
      return SeeAllGarageModel();
    }
  }

  static getSeeAllDealerDetails({
    required String countryID,
    required String stateID,
    required String cityID,
    required String businessID,
    String pageName = '1',
    bool showLoader = false,
  }) async {
    try {
      print({
        'page': pageName,
        'countryId': countryID,
        'stateId': stateID,
        'cityId': cityID,
        'size': '10',
        'businessTypeId': businessID,
      });
      if(showLoader == true)
        PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}):
      dioClient.Options(contentType: 'application/json');
      response = await BaseUrl.getDio1().get("business/get-all-dealers",
          queryParameters: {
            'page': pageName,
            'countryId': countryID,
            'stateId': stateID,
            'cityId': cityID,
            'size': '10',
            'businessTypeId': businessID,
          },
          options: options
      );
      if(showLoader == true)
        PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      if(showLoader == true)
        PRLoader.hide();
      return SeeAllDealerModel();
    }
  }

  static getMyVehicleList({String pageName = '1', bool showLoader = false}) async {
    try {
      if(showLoader == true)
        PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}):
      dioClient.Options(contentType: 'application/json');
      response = await BaseUrl.getDio1().get("vehicle/get-my-vehicles",
          queryParameters: {
            'vehicleType':'normal',
            'page': pageName,
            'size': '10',
          },
          options: options
      );
      if(showLoader == true)
        PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      if(showLoader == true)
        PRLoader.hide();
      return MyVehicleModel();
    }
  }

  static getMySparePartsList({String pageName = '1', bool showLoader = false}) async {
    try {
      if(showLoader == true)
        PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("spare-part/get-my-spare-parts",
          queryParameters: {
            'page': pageName,
            'size': '10',
          },
          options: options
      );
      if(showLoader == true)
        PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      if(showLoader == true)
        PRLoader.hide();
      return MySparePartsModel();
    }
  }

  static getMyGarageList({String pageName = '1', bool showLoader = false}) async {
    try {
      if(showLoader == true)
        PRLoader.hide();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("garage/get-my-garages",
          queryParameters: {
            'page': pageName,
            'size': '10',
          },
          options: options
      );
      if(showLoader == true)
        PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      if(showLoader == true)
        PRLoader.hide();
      return MyGarageModel();
    }
  }

}