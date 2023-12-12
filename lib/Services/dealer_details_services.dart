import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/Model/dealer_details_model.dart';

import '../Model/dealer_details_modelnn.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class DealerDetailsServices{
  static getDealerDetails(String dealerId) async {
    try {
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("business/get-dealer/$dealerId",
          options: options
      );
      print(response);
      return response.data;
    }catch (e){
      return DealerDetailsModel();
    }
  }
}