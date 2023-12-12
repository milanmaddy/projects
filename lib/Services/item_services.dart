import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/Model/item_available_model.dart';

import 'base.dart';

class ItemService{
  static getItemData()async{
    try{
      // EasyLoading.show();
      print("== COUNTRY LIST HOMEPAGE ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/item-available-countries",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      // EasyLoading.dismiss();
      return response.data;
    }catch (e){
      // EasyLoading.dismiss();
      return ItemAvailableModel();
    }
  }
}