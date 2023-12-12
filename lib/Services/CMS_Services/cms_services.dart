import '../../Model/cms_model.dart';
import 'package:dio/dio.dart' as dioClient;

import '../base.dart';

class CMSServices{

  static Future<CMSModel>cms({required String pageName})async{
    try {
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/pages/$pageName",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      return CMSModel.fromJson(response.data);
    } catch (e) {
      return CMSModel();
      print(e);
    }
  }

}