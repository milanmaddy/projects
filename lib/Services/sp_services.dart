import 'package:dio/dio.dart' as dioClient;
import '../GlobalWidgets/loader.dart';
import '../Model/sp_wishlist_model.dart';
import '../Model/spare_part_details_model.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class SparePartsServices{
  static getSparePartsDetails(String spId) async {
    try {
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("spare-part/get-spare-part/$spId",
          options: options
      );
      print(response);
      return response.data;
    }catch (e){
      return SparePartDetailsModel();
    }
  }

  static getFavouriteSPList({String pageName = '1', bool showLoader = true})async{
    try {
      if(showLoader == true)
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().get("spare-part/get-liked-spare-parts",
          queryParameters: {
            'page' : pageName,
            'size' : 10,
          },
          options: options
      );
      if(showLoader == true)
        PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      if(showLoader == true)
        PRLoader.hide();
      // print(e);
      return SPWishlistModel();
    }
  }

  static deleteSpareParts({required String spID}) async {
    try {
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().delete("spare-part/delete-spare-part/$spID",
          options: options
      );
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      PRLoader.hide();
      print(e);
    }
  }

  static deleteSPImage({required String spImgID}) async {
    try {
      PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'});
      response = await BaseUrl.getDio1().delete("spare-part/delete-spare-part-image/$spImgID",
          options: options
      );
      PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      PRLoader.hide();
      print(e);
    }
  }
}