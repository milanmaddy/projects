import 'package:dio/dio.dart'as dioClient;
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Model/sp_wishlist_model.dart';
import 'package:kawawa_motors/Model/vehicle_details_model.dart';
import 'package:kawawa_motors/Model/vehicle_type_model.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import '../Model/car_wishlist_model.dart';
import 'base.dart';

class VehicleServices{
  static getVehicleDetails(String vid) async {
    try {
      dioClient.Response response;
      dioClient.Options options = SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}):
          dioClient.Options(contentType: 'application/json');
      response = await BaseUrl.getDio1().get("vehicle/get-vehicle/$vid",
        options: options
      );
      print(response);
      return response.data;
    }catch (e){
      // print(e);
      return VehicleDetailsModel();
    }
  }

  static getVehicleType({required String vTypeId, String pageName = '1', required String countryId
  }) async {
    print({
      'vehicleType':'normal',
      'page': pageName,
      'size': '10',
      'countryId': countryId,
      'vehicleTypeId': vTypeId
    },);
    try {
      dioClient.Response response;
      dioClient.Options options = SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json'):
      dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("vehicle/get-all-vehicles",
          queryParameters: {
            'vehicleType':'normal',
            'page': pageName,
            'size': '10',
            'countryId': countryId,
            'vehicleTypeId': vTypeId
          },
          options: options
      );
      print(response);
      return response.data;
    }catch (e){
      return VehicleTypeModel();
    }
  }

  static getFavouriteCarList({String pageName = '1', bool showLoader = true}) async {
    try {
      if(showLoader == true)
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().get("vehicle/get-liked-vehicles",
          queryParameters: {
        'vehicleType' : 'normal',
        'page' : pageName,
        'size' : 10,
          },
          options: options
      );
      if(showLoader == true)
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      // print(e);
      if(showLoader == true)
      PRLoader.hide();
      return CarWishlistModel();
    }
  }

  static deleteVehicle({required String vehicleID}) async {
    try {
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().delete("vehicle/delete-vehicle/$vehicleID",
          options: options
      );
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      PRLoader.hide();
      print(e);
    }
  }

  static deleteVehicleImage({required String vehicleImgID}) async {
    try {
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().delete("vehicle/delete-vehicle-image/$vehicleImgID",
          options: options
      );
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      PRLoader.hide();
      print(e);
    }
  }
}