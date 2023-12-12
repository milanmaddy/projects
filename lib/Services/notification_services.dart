import 'package:dio/dio.dart' as dioClient;

import '../GlobalWidgets/loader.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class NotificationServices{

  static notificationList({required String pageName, bool showLoader = true})async{
    try{
      if(showLoader == true)
      PRLoader.show();
      print("== NOTIFICATION DATA ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/get-notifications",
        queryParameters: {
          'size': '10',
          'page': pageName,
        },
        options: dioClient.Options(contentType: "application/json",
            headers: {
              "Authorization": "Bearer ${SharedPrefUtils.getToken()}"
            }
        ),
      );
      print(response);
      if(showLoader == true)
      PRLoader.hide();
      return response.data;
    }catch (e){
      if(showLoader == true)
      PRLoader.hide();
      print(e);
    }
  }

}