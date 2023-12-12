import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';

import '../Model/login_model.dart';
import '../Routes/app_route.dart';
import '../Services/Authentication_Services/authentrication_services.dart';
import '../Shared Pref/sharedpref_utils.dart';

class AuthenticationController extends GetxController{

  HomeController homeController = Get.put(HomeController());

  var rOPModel =  RegisterOptionModel().obs;

  login({
    required var key,
    required String email,
    required String password,
  }) async {
    if (key.currentState!.validate()) {
      var data = await AuthenticationServices.userLogin(email, password);
      //print(data);
      if(data["statusCode"] == 200){
        LoginModel loginModel = LoginModel.fromJson(data);
        // SharedPrefUtils.setToken(loginModel.data!.token!);
        SharedPrefUtils.setPassword(password);
        SharedPrefUtils.setToken(data['data']['token']);
        SharedPrefUtils.setUserId(data['data']['user']['userId']);
        SharedPrefUtils.setName(data['data']['user']['fullName']);
        SharedPrefUtils.setEmail(data['data']['user']['emailAddress']);
        SharedPrefUtils.setPhone(data['data']['user']['phoneNumber']);
        SharedPrefUtils.setCountry(data['data']['user']['country']['countryName']);
        SharedPrefUtils.setCountryId(data['data']['user']['country']['countryId']);
        SharedPrefUtils.setState(data['data']['user']['state']['stateName']);
        SharedPrefUtils.setStateId(data['data']['user']['state']['stateId']);
        SharedPrefUtils.setCity(data['data']['user']['city']['cityName']);
        SharedPrefUtils.setCityId(data['data']['user']['city']['cityId']);
        SharedPrefUtils.setPhoneCode(data['data']['user']['phoneCountryCode']);
        SharedPrefUtils.setAccountType(data['data']['user']['role']['roleName']);
        SharedPrefUtils.setProfilePic(data['data']['user']['profileImageUrl']);
        if(loginModel.data!.user!.businessAccount != null){
          SharedPrefUtils.setBusinessLogo(data['data']['user']['businessAccount']['businessLogoUrl']);
          SharedPrefUtils.setBusinessName(data['data']['user']['businessAccount']['businessName']);
          SharedPrefUtils.setBusinessTypeName(data['data']['user']['businessAccount']['businessType']['title']);
          SharedPrefUtils.setBusinessType(data['data']['user']['businessAccount']['businessType']['businessTypeId']);
          SharedPrefUtils.setBusinessPhoneCode(data['data']['user']['businessAccount']['businessPhoneCountryCode']);
          SharedPrefUtils.setBusinessPhone(data['data']['user']['businessAccount']['businessPhoneNumber']);
          SharedPrefUtils.setWebsiteURL(data['data']['user']['businessAccount']['websiteUrl']);
        }
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        Get.offAllNamed(AppRoute.dashBoard);
      }
      else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }

  signUpPrivate({
    required var key,
    required String roleID,
    required String countryID,
    required String stateID,
    required String cityID,
    required String name,
    required String email,
    required String countryCode,
    required String phone,
    required String password,
    required String confirmPassword,
  })async{
    if(key.currentState!.validate()) {
      try{
        var data = await AuthenticationServices.userSignUpPrivate(
            roleID, countryID, stateID, cityID, name, email, countryCode, phone, password, confirmPassword);
        print("<<<>>>");
        print(data);
        print("== SIGN UP PRIVATE COMPLETE ==");
        if(data["statusCode"] == 201){
          // RegistrationModel registerModel = RegistrationModel.fromJson(data);
          Get.back();
          Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
          SharedPrefUtils.setToken(data['token']);
        }else{
          Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText:  Colors.redAccent);
        }
      }catch(e){
        print(e);
      }
    }
  }

  signUpBusiness({
    required var key,
    required String roleID,
    required String countryID,
    required String stateID,
    required String cityID,
    required String businessTypeID,
    required String businessName,
    required String businessPhoneCountryCode,
    required String businessPhone,
    required String name,
    required String email,
    required String phoneCountryCode,
    required String phone,
    required String website,
    required String password,
    required String confirmPassword,
  })async{
    if(key.currentState!.validate()) {
      try{
        var data = await AuthenticationServices.userSignUpBusiness(
            roleID,
            countryID,
            stateID,
            cityID,
            businessTypeID,
            businessName,
            businessPhoneCountryCode,
            businessPhone,
            name,
            email,
            phoneCountryCode,
            phone,
            website,
            password,
            confirmPassword
        );
        print("<<<>>>");
        print(data);
        print("== SIGN UP BUSINESS COMPLETE ==");
        if(data["statusCode"] == 201){
          // RegistrationModel registerModel = RegistrationModel.fromJson(data);
          Get.back();
          Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
          SharedPrefUtils.setToken(data['token']);
        }else{
          Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText:  Colors.redAccent);
        }
      }catch(e){
        print(e);
      }
    }
  }


  forgotPassWord({
    bool isSendAgain = false,
    required var key,
    required String email,
  })async{
    if(!isSendAgain){
      if(key.currentState.validate()){
        var data = await AuthenticationServices.forgotPassword(email);
        if(data["statusCode"] == 200){
          Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
          Get.offAllNamed(AppRoute.resetPass, arguments: email);
        }else{
          Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
        }
      }
    }
      else{
      var data = await AuthenticationServices.forgotPassword(email);
      if(data["statusCode"] == 200){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        // Get.offAllNamed(AppRoute.resetPass, arguments: email);
      }else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }

  resetPassWord({
    required var key,
    required String email,
    required String password,
    required String confirmPassword,
    required String otp,
  }) async {
    if (key.currentState!.validate()) {
      var data = await AuthenticationServices.resetPassword(email, password, confirmPassword, otp);
      if(data["statusCode"]==200){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        Get.offAllNamed(AppRoute.login);
      }
      else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }
  }

  logout()async{
    // SharedPrefUtils.logOut();
    // Get.offAllNamed(AppRoute.login);
    var data = await AuthenticationServices.logout();
    if(data["statusCode"] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
      SharedPrefUtils.logOut();
      Get.offAllNamed(AppRoute.dashBoard);
      // homeController.selectedIndex.value == 1;
    }else{
      Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
    }

  }

  delete()async{
    // SharedPrefUtils.logOut();
    // Get.offAllNamed(AppRoute.login);
    var data = await AuthenticationServices.deleteAccount();
    if(data["statusCode"] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
      SharedPrefUtils.logOut();
      Get.offAllNamed(AppRoute.dashBoard);
      // homeController.selectedIndex.value == 1;
    }else{
      Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
    }
  }

  changePassword({
    required var key,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword
  })async{
    if(key.currentState.validate()){
      var data = await AuthenticationServices.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword
      );
      if(data["statusCode"] == 200){
        Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
        // SharedPrefUtils.logOut();
        Get.offAllNamed(AppRoute.login);
      }else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
      }
    }

  }


}