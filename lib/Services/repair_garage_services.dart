import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/Model/garage_wishlist_model.dart';
import 'package:kawawa_motors/Model/repair_garage_details_model.dart';

import '../GlobalWidgets/loader.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class RepairGarageServices{
  static getGarageDetails(String gid) async {
    try {
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("garage/get-garage/$gid",
          options: options
      );
      print(response);
      return response.data;
    }catch (e){
      return RepairGarageDetailsModel();
    }
  }

  static getFavouriteGarageList({String pageName = '1'}) async {
    try {
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().get("garage/get-liked-garages",
          queryParameters: {
            'page' : pageName,
            'size' : 10,
          },
          options: options
      );
      print(response);
      return response.data;
    }catch (e){
      // print(e);
      return GarageWishlistModel();
    }
  }

  static deleteGarage({required String garageID}) async {
    try {
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().delete("garage/delete-garage/$garageID",
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

  static deleteGarageImage({required String garageImgID}) async {
    try {
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().delete("garage/delete-garage-image/$garageImgID",
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