import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/GlobalWidgets/loader.dart';

import '../Model/me_model.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class MeService{
  static getMyData()async{
    try{
      // PRLoader.show();
      print("== ME DATA ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("auth/me",
        options: dioClient.Options(contentType: "application/json",
            headers: {
              "Authorization": "Bearer ${SharedPrefUtils.getToken()}"
            }
        ),
      );
      print(response);
      // PRLoader.hide();
      return response.data;
    }catch (e){
      // PRLoader.hide();
      print(e);
      return MeModel();
    }
  }
}