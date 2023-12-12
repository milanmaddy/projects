import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/Model/broadcast_type_model.dart';

import '../GlobalWidgets/loader.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class BroadcastService{

  static getBroadcastList({required String type, String pageName = '1', required bool showLoader}) async {
    try {
      if(showLoader)
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      print({
        'broadcastType': type,
        'page': pageName,
        'size': '10',
      });
      response = await BaseUrl.getDio1().get("broadcast/get-broadcasts",
          options: options,
          queryParameters: {
            'broadcastType': type,
            'page': pageName,
            'size': '10',
          }
      );
      if(showLoader)
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      if(showLoader)
      PRLoader.hide();
      return BroadcastTypeModel();
    }
  }

  static getMyBroadcastList({
    String pageName = '1',
    bool showLoader = true
  }) async {
    try {
      if(showLoader == true)
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );

      response = await BaseUrl.getDio1().get("broadcast/get-my-broadcasts",
          options: options,
        queryParameters: {
        'page': pageName,
          'size': '10'
        }
      );
      if(showLoader == true)
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      if(showLoader == true)
      PRLoader.hide();
      return BroadcastTypeModel();
    }
  }

  static deleteBroadcast({required String bID}) async {
    try {
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().delete("broadcast/delete-broadcast/$bID",
          options: options);
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      PRLoader.hide();
      print(e);
    }
  }

  static addBroadcast({required String bType, required String bText}) async {
    try {
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      var mData = {
        "broadcastType": bType,
        "broadcastText": bText
      };
      response = await BaseUrl.getDio1().post("broadcast/post-broadcast",
          options: options,
        data: mData
      );
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      PRLoader.hide();
      print(e);
    }
  }

  static contactUs({
    required String name,
    required String email,
    required String phone,
    required String message,
  })async{
    try{
      PRLoader.show();
      print("== GET IN TOUCH DATA ==");
      dioClient.Response response;
      var mData = {
        "name": name,
        "emailAddress": email,
        "mobileNumber": phone,
        "message": message
      };
      response = await BaseUrl.getDio1().post("common/save-contact-us",
        data: mData,
        options: dioClient.Options(contentType: "application/json",
            // headers: {
            //   "Authorization": "Bearer ${SharedPrefUtils.getToken()}"
            // }
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

  static contactUSDetails()async{
    try {
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/contact-admin-details",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

}