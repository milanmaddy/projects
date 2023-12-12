import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Model/car_maker_model.dart';
import 'package:kawawa_motors/Model/car_model_model.dart';
import 'package:kawawa_motors/Model/city_list_model.dart';
import 'package:kawawa_motors/Model/sp_dropdown_model.dart';
import 'package:kawawa_motors/Model/sp_sub_category_model.dart';
import 'package:kawawa_motors/Model/state_list_model.dart';

import 'base.dart';

class ListService{
  static getStateList(String countryID, bool showLoader)async{
    try{
      if(showLoader)
      PRLoader.show();
      print("== STATE LIST ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/get-states/$countryID",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      if(showLoader)
      PRLoader.hide();
      return response.data;
    }catch (e){
      if(showLoader)
      PRLoader.hide();
      return StateListModel();
    }
  }

  static getCityList(String stateID, bool showLoader)async{
    try{
      if(showLoader)
        PRLoader.show();
          print("== CITY LIST ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/get-cities/$stateID",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      if(showLoader)
          PRLoader.hide();
      return response.data;
    }catch (e){
      if(showLoader)
      PRLoader.hide();
      return CityListModel();
    }
  }

  static getCarDropDownList(bool showLoader)async{
    try{
      if(showLoader)
      PRLoader.show();
      print("== CAR MAKER LIST ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/get-cars-dropdown",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      if(showLoader)
      PRLoader.hide();
      return response.data;
    }catch (e){
      if(showLoader)
      PRLoader.hide();
      return CarDropDownModel();
    }
  }

  static getSparePartsDropDownList(bool showLoader)async{
    try{
      if(showLoader)
        PRLoader.show();
      print("== SPARE PARTS LIST ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/get-spare-part-dropdown",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      if(showLoader)
        PRLoader.hide();
      return response.data;
    }catch (e){
      if(showLoader)
        PRLoader.hide();
      return SparePartsDropDownModel();
    }
  }

  static getCarModelList(String carMakerID, bool showLoader)async{
    try{
      if(showLoader)
      PRLoader.show();
      print("== CAR MAKER LIST ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/get-car-models/$carMakerID",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      if(showLoader)
      PRLoader.hide();
      return response.data;
    }catch (e){
      if(showLoader)
      PRLoader.hide();
      return CarModelModel();
    }
  }

  static getSPSubCategoryList(String categoryId, bool showLoader)async{
    try{
      if(showLoader)
        PRLoader.show();
      print("== CAR MAKER LIST ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/get-spare-part-sub-categories/$categoryId",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      if(showLoader)
        PRLoader.hide();
      return response.data;
    }catch (e){
      if(showLoader)
        PRLoader.hide();
      return SparePartsSubCategoryModel();
    }
  }
}