import 'package:dio/dio.dart' as dioClient;
import 'package:get/get.dart';

import '../GlobalWidgets/loader.dart';
import '../Model/dashboard_model.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class HomePageServices{

  static getHomePageData({required String date, required String countryID})async{
    try{
      // PRLoader.show();
      print("== HOMEPAGE DATA ==");
      print('GGGGG');
      print(date);
      print(countryID);
      dioClient.Response response;
      dioClient.Options options =
      // SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json');
      // dioClient.Options(contentType: 'application/json',
      //     headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      // );
      response = await BaseUrl.getDio1().get("common/get-dashboard-data",
          options: options,
        queryParameters: {
        'localDate' : date,
        'countryId' : countryID,
      }
      );

      // print(response);
      // PRLoader.hide();
      return response.data;
    }catch (e){
      print(e);
      // PRLoader.hide();
      // return e.response!.data;
      return HomePageModel();
    }
  }
}