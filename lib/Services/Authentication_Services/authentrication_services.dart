import 'package:kawawa_motors/Model/register_option_model.dart';

import '../../GlobalWidgets/loader.dart';
import '../../Shared Pref/sharedpref_utils.dart';
import '../base.dart';
import 'package:dio/dio.dart' as dioClient;

class AuthenticationServices{

  static userLogin(String email, String password)async{
    try {
      PRLoader.show();
      print("==  LOGIN ==");
      dioClient.Response response;
      var mData = {
        "emailAddress": email,
        "password": password,
        "rememberMe": true,
      };
      print(mData);
      response = await BaseUrl.getDio1().post("auth/login",
          data: mData,
          options: dioClient.Options(contentType: "application/json"));
      print(response.data);
      PRLoader.hide();
      return response.data;
    } catch (e) {
      PRLoader.hide();
    }
  }

  static userSignUpPrivate(
      String roleID,
      String countryID,
      String stateID,
      String cityID,
      String name,
      String email,
      String countryCode,
      String phone,
      String password,
      String confirmPassword,
      ) async{
    try {
      PRLoader.show();
      print('== SIGN UP PRIVATE ==');
      dioClient.Response response;
      var mData = {
        "roleId": roleID,
        "countryId": countryID,
        "stateId": stateID,
        "cityId": cityID,
        "fullName": name,
        "emailAddress": email,
        "phoneCountryCode": countryCode,
        "phoneNumber": phone,
        "password": password,
        "confirmPassword": confirmPassword,
      };
      // print('mData');
      print('<<====== MDATA IS =======>>');
      print(mData);
      response = await BaseUrl.getDio1().post("auth/register",
          data: mData,
          options: dioClient.Options(contentType: "application/json",
          ));

      print(response.data);
      PRLoader.hide();
      return response.data;
    }catch (e) {
      print(e);
      PRLoader.hide();
    }
  }

  static userSignUpBusiness(
      String roleID,
      String countryID,
      String stateID,
      String cityID,
      String businessTypeID,
      String businessName,
      String businessPhoneCountryCode,
      String businessPhone,
      String name,
      String email,
      String phoneCountryCode,
      String phone,
      String website,
      String password,
      String confirmPassword,
      ) async{
    try {
      PRLoader.show();
      print('== SIGN UP BUSINESS ==');
      dioClient.Response response;
      var mData = {
        "roleId": roleID,
        "countryId": countryID,
        "stateId": stateID,
        "cityId": cityID,
        "businessTypeId": businessTypeID,
        "businessName": businessName,
        "fullName": name,
        "emailAddress": email,
        "phoneCountryCode": phoneCountryCode,
        "phoneNumber": phone,
        "businessPhoneCountryCode": businessPhoneCountryCode,
        "businessPhoneNumber": businessPhone,
        "password": password,
        "confirmPassword": confirmPassword,
        "websiteUrl": website,
      };
      // print('mData');
      print(mData);
      response = await BaseUrl.getDio1().post("auth/register",
          data: mData,
          options: dioClient.Options(contentType: "application/json",
          ));
      print(response.data);
      PRLoader.hide();
      return response.data;
    }catch (e) {
      print(e);
      PRLoader.show();
    }
  }

  static registerOptions()async{
    try{
      // EasyLoading.show();
      print("== COUNTRY LIST ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("common/get-signup-options",
        options: dioClient.Options(contentType: "application/json"),
      );
      print(response);
      // EasyLoading.dismiss();
      return response.data;
    }catch (e){
      // EasyLoading.dismiss();
      return RegisterOptionModel();
    }
  }

  static forgotPassword(String email)async{
    try {
      PRLoader.show();
      dioClient.Response response;
      var mData = {"emailAddress": email};
      print(mData);
      response = await BaseUrl.getDio1().post("auth/forget-password/request-otp",
          data: mData,
          options: dioClient.Options(contentType: "application/json"));
      PRLoader.hide();
      print(response.data);
      return response.data;
    }catch(e){
      PRLoader.hide();
    }
  }

  static resetPassword(String email, String password, String confirmPassword, String otp,)async{
    try {
      PRLoader.show();
      dioClient.Response response;
      var mData = {
        "emailAddress" : email,
        "newPassword": password,
        "confirmPassword": confirmPassword,
        "OTP": otp,
      };
      print(mData);
      response = await BaseUrl.getDio1().post("auth/forget-password/reset-password",
          data: mData,
          options: dioClient.Options(contentType: "application/json"));
      PRLoader.hide();
      return response.data;
    }catch(e){
      PRLoader.hide();
    }
  }

  static logout()async{
    try {
      PRLoader.show();
      dioClient.Response response;
      response = await BaseUrl.getDio1().delete("auth/logout",
          options: dioClient.Options(contentType: "application/json",
            headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken()}"}
          ));
      PRLoader.hide();
      return response.data;
    }catch(e){
      PRLoader.hide();
    }
  }

  static deleteAccount()async{
    try {
      PRLoader.show();
      dioClient.Response response;
      response = await BaseUrl.getDio1().delete("auth/delete-account",
          options: dioClient.Options(contentType: "application/json",
              headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken()}"}
          ));
      PRLoader.hide();
      return response.data;
    }catch(e){
      PRLoader.hide();
    }
  }

  static changePassword({required String oldPassword, required String newPassword, required String confirmPassword})async{
    try {
      PRLoader.show();
      dioClient.Response response;
      var mData = {
        "currentPassword" : oldPassword,
        "newPassword" : newPassword,
        "confirmPassword": confirmPassword
      };
      response = await BaseUrl.getDio1().patch("auth/change-password",
          data: mData,
          options: dioClient.Options(contentType: "application/json",
              headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken()}"}
          ));
      PRLoader.hide();
      return response.data;
    }catch(e){
      PRLoader.hide();
    }
  }

}