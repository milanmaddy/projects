import 'package:dio/dio.dart' as dioClient;

import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class RatingServices{

  static ratingSpareParts({required String sparePartID, required double rating}) async {
    try {
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      var mData = {
        "contentType" : "spare-part",
        "sparePartId" : sparePartID,
        "givenRating" : rating
      };
      response = await BaseUrl.getDio1().patch("common/save-rating",
          options: options,
        data: mData
      );
      print(response);
      return response.data;
    }catch (e){
      print(e);
    }
  }

  static ratingVehicle({required String vID, required double rating}) async {
    try {
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      var mData = {
        "contentType" : "vehicle",
        "vehicleId" : vID,
        "givenRating" : rating
      };
      response = await BaseUrl.getDio1().patch("common/save-rating",
          options: options,
          data: mData
      );
      print(response);
      return response.data;
    }catch (e){
      print(e);
    }
  }

  static ratingGarage({required String garageID, required double rating}) async {
    try {
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      var mData = {
        "contentType" : "garage",
        "garageId" : garageID,
        "givenRating" : rating
      };
      response = await BaseUrl.getDio1().patch("common/save-rating",
          options: options,
          data: mData
      );
      print(response);
      return response.data;
    }catch (e){
      print(e);
    }
  }

  static ratingDealer({required String dealerID, required double rating}) async {
    try {
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      var mData = {
        "contentType" : "dealer",
        "dealerId" : dealerID,
        "givenRating" : rating
      };
      response = await BaseUrl.getDio1().patch("common/save-rating",
          options: options,
          data: mData
      );
      print(response);
      return response.data;
    }catch (e){
      print(e);
    }
  }

}
