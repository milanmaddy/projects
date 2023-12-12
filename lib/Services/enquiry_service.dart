import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/Model/my_enquiry_model.dart';
import '../GlobalWidgets/loader.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class EnquiryServices{

  static postEnquiry({
    required String toUserId,
    required String productId,
    required String enquiryType,
    required String enquiryText,
  })async{
    try{
      PRLoader.show();
      print("== POST ENQUIRY DATA ==");
      dioClient.Response response;
      var mData = {
        'toUserId': toUserId,
        'productId': productId,
        'enquiryType': enquiryType,
        'enquiryText': enquiryText,
      };
      response = await BaseUrl.getDio1().post("enquiry/post-enquiry",
        data: mData,
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

  static getMyEnquiry({
    String pageName = '1',
    required String enquiryType,
    bool showLoader = true
  })async{
    try{
      if(showLoader == true)
      PRLoader.show();
      print("== MY ENQUIRY DATA ==");
      print({
        'page': pageName,
        'size': '5',
        'enquiryType': enquiryType,
      });
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("enquiry/get-my-enquiries",
        queryParameters: {
          'page': pageName,
          'size': '5',
          'enquiryType': enquiryType,
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
      // print(e);
      return MyEnquiryModel();
    }
  }

}