import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Model/me_model.dart';
import 'package:kawawa_motors/Services/me_services.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import '../Constraints/color_const.dart';
import '../Routes/app_route.dart';
import '../Services/profile_services.dart';

class ProfileController extends GetxController{

  MeController meController = Get.put(MeController());
  HomeController homeController = Get.put(HomeController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // MeService.getMyData();

    nameController.text = SharedPrefUtils.getName().toString();
    emailController.text = SharedPrefUtils.getEmail().toString();
    phoneController.text = SharedPrefUtils.getPhone().toString();
    countryController.text = SharedPrefUtils.getCountry().toString();
    regionController.text = SharedPrefUtils.getState().toString();
    cityController.text = SharedPrefUtils.getCity().toString();
    codeController.text = SharedPrefUtils.getPhoneCode().toString();

    // businessProfileLogo.value = SharedPrefUtils.getBusinessLogo()!;
    businessCountryController.text = SharedPrefUtils.getCountry().toString();
    businessCityController.text = SharedPrefUtils.getCity().toString();
    businessRegionController.text = SharedPrefUtils.getState().toString();
    businessEmailController.text = SharedPrefUtils.getEmail().toString();
    personalContactNo.text = SharedPrefUtils.getPhone().toString();
    SharedPrefUtils.getBusinessTypeName().toString() != "null"?
    businessTypeController.text = SharedPrefUtils.getBusinessTypeName().toString():
    businessTypeController.text = '';
    SharedPrefUtils.getBusinessName().toString() != "null"?
    businessName.text = SharedPrefUtils.getBusinessName().toString():
    businessName.text = '';
    phoneCodeController.text = SharedPrefUtils.getPhoneCode().toString();
    SharedPrefUtils.getBusinessPhoneCode().toString() != "null"?
    bPhoneCodeController.text = SharedPrefUtils.getBusinessPhoneCode().toString():
    bPhoneCodeController.text = '';
    SharedPrefUtils.getBusinessPhone().toString() != "null"?
    businessContactNo.text = SharedPrefUtils.getBusinessPhone().toString():
    businessContactNo.text = '';
    businessPersonName.text = SharedPrefUtils.getName().toString();
    SharedPrefUtils.getWebsiteURL().toString() != "null"?
    urlController.text = SharedPrefUtils.getWebsiteURL().toString():
    urlController.text = "";
  }

  var profilePath = false.obs;
  var profilePath2 = false.obs;
  var localProfile = File("").obs;
  var localLogo = File("").obs;
  var profileImage = "".obs;
  var businessLogo = "".obs;
  var businessProfileLogo = "".obs;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var codeController = TextEditingController();
  var phoneController = TextEditingController();
  var countryController = TextEditingController();
  var regionController = TextEditingController();
  var cityController = TextEditingController();

  var businessCountryController = TextEditingController();
  var businessCityController = TextEditingController();
  var businessRegionController = TextEditingController();
  var businessEmailController = TextEditingController();
  var personalContactNo = TextEditingController();
  var businessTypeController = TextEditingController();
  var businessName = TextEditingController();
  var phoneCodeController = TextEditingController();
  var bPhoneCodeController = TextEditingController();
  var businessContactNo = TextEditingController();
  var businessPersonName = TextEditingController();
  var urlController = TextEditingController();

  updateProfilePicture({ImageSource ims = ImageSource.gallery}) async {
    try {
      var image;
      image = await ImagePicker().pickImage(source: ims);
      if (image != null) {
        CroppedFile? croppedFile =
            await ImageCropper().cropImage(
            sourcePath: image!.path,
            compressFormat: ImageCompressFormat.jpg,
            compressQuality: 100,
        );
        // PickedFile pickedImage = image;
        File pickedImage = File(croppedFile!.path);
        final lastIndex = pickedImage.path.lastIndexOf(RegExp(r'.jp'));
        final splitted = pickedImage.path.substring(0, (lastIndex));
        final outPath = "${splitted}_out${pickedImage.path.substring(lastIndex)}";
        print('===== PROFILE =====');
        var file = await FlutterImageCompress.compressAndGetFile(
            pickedImage.path, outPath,
            quality: 35);
        if (file != null) {
          var data = await ProfileServices.updateProfilePicture(file.path);
          if (data['statusCode'] == 200) {
            Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
            localProfile.value = File(pickedImage.path);
            profilePath.value = true;
            SharedPrefUtils.setProfilePic(data['data']['user']['profileImageUrl']);
            print('local profile = ${localProfile.value}');
            // var data2 = await MeService.getMyData();
            // if(data2['statusCode'] == 200){
            //   profileImage.value = data2['data']['user']['profileImageUrl'];
            //   print('PRIVATE INFO FETCHED');
            // }
            // try {
            //   if (data2['statusCode'] == 200) {
            //     SharedPrefUtils.setPP(jsonEncode(MeModel.fromJson(data2)));
            //   } else {}
            // } catch (e) {
            //   print(e);
            // }

          } else {
            Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
            // EasyLoading.dismiss();
          }
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }

  updateBusinessLogo({ImageSource ims = ImageSource.gallery}) async {
    try {
      var image;
      image = await ImagePicker().pickImage(source: ims);
      if (image != null) {
        CroppedFile? croppedFile =
        await ImageCropper().cropImage(
          sourcePath: image!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
        );
        // PickedFile pickedImage = image;
        File pickedImage = File(croppedFile!.path);
        final lastIndex = pickedImage.path.lastIndexOf(RegExp(r'.jp'));
        final splitted = pickedImage.path.substring(0, (lastIndex));
        final outPath = "${splitted}_out${pickedImage.path.substring(lastIndex)}";
        print('===== BUSINESS PROFILE =====');
        var file = await FlutterImageCompress.compressAndGetFile(
            pickedImage.path, outPath,
            quality: 35);
        businessProfileLogo.value = file!.path;
        profilePath2.value = true;
        print(businessProfileLogo.value);
        SharedPrefUtils.setBusinessLogo(businessProfileLogo.value);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  updateUserProfile({
    required String name,
    required String code,
    required String phone,
    required String country,
    required String region,
    required String city,
  })async{
    if (name == "") {
      Get.snackbar("ERROR", 'Please Enter Name',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (phone == "") {
      Get.snackbar("ERROR", 'Please Enter Phone. No',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (code == "") {
      Get.snackbar("ERROR", 'Please Select Code',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (country == "") {
      Get.snackbar("ERROR", 'Please Select Country',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (region == "") {
      Get.snackbar("ERROR", 'Please Select Region',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (city == "") {
      Get.snackbar("ERROR", 'Please Select City',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else{
      var data = await ProfileServices.updatePrivateProfile(
          countryID: country,
          stateID: region,
          cityID: city,
          name: name,
          countryCode: code,
          phone: phone,
      );
      print('details FILLED');
      if (data['statusCode'] == 200){
        print("updated success");
        var data2 = await MeService.getMyData();
        update();
        try{
          if(data2['statusCode'] == 200){
            // await meController.getMeData();
            SharedPrefUtils.setName(data['data']['user']['fullName']);
            SharedPrefUtils.setPhoneCode(data['data']['user']['phoneCountryCode']);
            SharedPrefUtils.setPhone(data['data']['user']['phoneNumber']);
            SharedPrefUtils.setCountry(data['data']['user']['country']['countryName']);
            SharedPrefUtils.setState(data['data']['user']['state']['stateName']);
            SharedPrefUtils.setCity(data['data']['user']['city']['cityName']);
            SharedPrefUtils.setAccountType(data['data']['user']['role']['roleName']);
            print(SharedPrefUtils.getName());
            print(SharedPrefUtils.getPhoneCode());
            print(SharedPrefUtils.getPhone());
            print(SharedPrefUtils.getCountry());
            print(SharedPrefUtils.getState());
            print(SharedPrefUtils.getCity());
            Get.snackbar("SUCCESS", 'Profile Updated Successfully',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
            // Get.offAndToNamed(AppRoute.login);
            homeController.selectedIndex.value = 0;
            update();
          }else{
            // Get.snackbar("SUCCESS", 'Profile NOT Updated Successfully',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
          }
        }catch(e){
          print(e);
        }
        return true;
      } else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
        return false;
      }
    }
  }

  updatePrivateToBusinessProfile({
    required String logo,
    required String country,
    required String region,
    required String city,
    required String businessType,
    required String businessName,
    required String phoneCode,
    required String businessPhoneCode,
    required String personalContactNo,
    required String businessContactNo,
    required String businessPersonName,
    required String website,
  })async{
    if (businessName == "") {
      Get.snackbar("ERROR", 'Please Enter Business Name',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (businessPersonName == "") {
      Get.snackbar("ERROR", 'Please Enter Your Name',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (phoneCode == "") {
      Get.snackbar("ERROR", 'Please Select Code',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (country == "") {
      Get.snackbar("ERROR", 'Please Select Country',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (region == "") {
      Get.snackbar("ERROR", 'Please Select Region',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (city == "") {
      Get.snackbar("ERROR", 'Please Select City',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (businessType == ""){
      Get.snackbar("ERROR", 'Please Select Business Type',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (businessPhoneCode == ""){
      Get.snackbar("ERROR", 'Please Select Code',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (businessContactNo == ""){
      Get.snackbar("ERROR", 'Please Enter Business Contact No.',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    else if (personalContactNo == ""){
      Get.snackbar("ERROR", 'Please Select City',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    // else if (website == ""){
    //   Get.snackbar("ERROR", 'Please Select City',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);}
    // }

    else{
      var data = await ProfileServices.profileUpgrade(
          businessLogo: logo,
          countryID: country,
          stateID: region,
          cityID: city,
          bTypeID: businessType,
          bName: businessName,
          bCode: businessPhoneCode,
          bPhone: businessContactNo,
          bPersonName: businessPersonName,
          phoneCode: phoneCode,
          phone: personalContactNo,
          website: website);
      print('details FILLED');
      print('logo url: ${businessProfileLogo.value}');
      if (data['statusCode'] == 200){
        print("updated success");
        // SharedPrefUtils.setBusinessLogo(data['data']['user']['businessAccount']['businessLogoUrl']);
        // print('PROFILE LOGO IS : ${SharedPrefUtils.getBusinessLogo()}');
        // print('PROFILE LOGO 2 IS : ${data['data']['user']['businessAccount']['businessLogoUrl']}');
        print('PROFILE LOGO 3 IS : ${businessProfileLogo.value}');
        var data2 = await MeService.getMyData();
        update();
        // try{
          if(data2['statusCode'] == 200){
            // await meController.getMeData();
            SharedPrefUtils.setCountry(data2['data']['user']['country']['countryName']);
            SharedPrefUtils.setState(data2['data']['user']['state']['stateName']);
            SharedPrefUtils.setCity(data2['data']['user']['city']['cityName']);
            SharedPrefUtils.setBusinessType(data2['data']['user']['businessAccount']['businessType']['businessTypeId']);
            SharedPrefUtils.setBusinessTypeName(data2['data']['user']['businessAccount']['businessType']['title']);
            SharedPrefUtils.setBusinessName(data2['data']['user']['businessAccount']['businessName']);
            SharedPrefUtils.setBusinessPhoneCode(data2['data']['user']['businessAccount']['phoneCountryCode']);
            SharedPrefUtils.setBusinessPhone(data2['data']['user']['businessAccount']['businessPhoneNumber']);
            SharedPrefUtils.setName(data2['data']['user']['fullName']);
            SharedPrefUtils.setPhoneCode(data2['data']['user']['phoneCountryCode']);
            SharedPrefUtils.setPhone(data2['data']['user']['phoneNumber']);
            SharedPrefUtils.setWebsiteURL(data2['data']['user']['businessAccount']['websiteUrl']);
            SharedPrefUtils.setBusinessLogo(data2['data']['user']['businessAccount']['businessLogoUrl']);
            SharedPrefUtils.setAccountType(data['data']['user']['role']['roleName']);

            // Get.offAllNamed(AppRoute.login);

            print(SharedPrefUtils.getCountry());
            print(SharedPrefUtils.getCountryId());
            print(SharedPrefUtils.getState());
            print(SharedPrefUtils.getStateId());
            print(SharedPrefUtils.getCity());
            print(SharedPrefUtils.getCityId());
            print(SharedPrefUtils.getBusinessType());
            print(SharedPrefUtils.getBusinessName());
            print(SharedPrefUtils.getBusinessPhoneCode());
            print(SharedPrefUtils.getBusinessPhone());
            print(SharedPrefUtils.getName());
            print(SharedPrefUtils.getPhoneCode());
            print(SharedPrefUtils.getPhone());
            print(SharedPrefUtils.getWebsiteURL());
            print(SharedPrefUtils.getBusinessLogo());
            Get.snackbar("SUCCESS", data['message'], borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
            // Get.offAndToNamed(AppRoute.login);
            Get.offAllNamed(AppRoute.dashBoard);
            // homeController.selectedIndex.value = 0;
            update();
          }else{
            Get.snackbar("SUCCESS", 'Profile NOT Updated Successfully',borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
          }
        // }catch(e){
        //   print(e);
        // }
        // return true;
      } else{
        Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
        // return false;
      }
    }
  }

}