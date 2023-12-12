import 'package:dio/dio.dart' as dioClient;

import '../GlobalWidgets/loader.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class WishListServices{
  static wishlistCar({required String vId, required String userID, bool showLoader = false})async{
    try{
      // if(showLoader == true)
      PRLoader.show();
      print(SharedPrefUtils.getUserId().toString());
      print("== WISHLIST DATA ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().patch("vehicle/like-vehicle/$vId",
        queryParameters: {
        'userId': userID
        },
        options: dioClient.Options(contentType: "application/json",
            headers: {
              "Authorization": "Bearer ${SharedPrefUtils.getToken()}"
            }
        ),
      );
      print(response);
      // if(showLoader == true)
      PRLoader.hide();
      return response.data;
    }catch (e){
      // if(showLoader == true)
      PRLoader.hide();
      print(e);
    }
  }

  static wishlistSP({required String spID, required String userID})async{
    try{
      PRLoader.show();
      print(SharedPrefUtils.getUserId().toString());
      print("== WISHLIST DATA ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().patch("spare-part/like-spare-part/$spID",
        queryParameters: {
          'userId': userID
        },
        options: dioClient.Options(contentType: "application/json",
            headers: {
              "Authorization": "Bearer ${SharedPrefUtils.getToken()}"
            }
        ),
      );
      print(response);
      PRLoader.hide();
      return response.data;
    }catch (e){
      PRLoader.hide();
      print(e);
    }
  }

  static wishlistGarage({required String garageID, required String userID})async{
    try{
      PRLoader.show();
      print(SharedPrefUtils.getUserId().toString());
      print("== WISHLIST DATA ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().patch("garage/like-garage/$garageID",
        queryParameters: {
          'userId': userID
        },
        options: dioClient.Options(contentType: "application/json",
            headers: {
              "Authorization": "Bearer ${SharedPrefUtils.getToken()}"
            }
        ),
      );
      print(response);
      PRLoader.hide();
      return response.data;
    }catch (e){
      PRLoader.hide();
      print(e);
    }
  }
}