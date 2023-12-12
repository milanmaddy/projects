import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import 'base.dart';

class ProfileServices{

  static updateProfilePicture(String image) async {
    dioClient.Response response;
    // EasyLoading.show();
    try {
      String fileName = image.split('/').last;
      dioClient.FormData formData = dioClient.FormData.fromMap({
        'profileImage': await dioClient.MultipartFile.fromFile(
          image,
          filename: fileName,
        ) //contentType: MediaType("image", "jpeg"),)
      });
      //var data = {'profile_image': path};
      response = await BaseUrl.getDio1().post('profile/update-profile-image',
          data: formData,
          options: dioClient.Options(
              contentType: 'multipart/form-data',
              headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken().toString()}"}));
      return response.data;
    } catch (e) {
      // EasyLoading.dismiss();
      print(e);
    }
  }


  static updatePrivateProfile({
    required String countryID,
    required String stateID,
    required String cityID,
    required String name,
    required String countryCode,
    required String phone,
  }) async {
    try {
      print('=== UPDATE PRIVATE PROFILE ===');
      PRLoader.show();
      dioClient.FormData formData = dioClient.FormData.fromMap({
        'roleId' : 'd1b4a3ce-cfb5-420c-98cd-901ce5ab88cd',
        'countryId': countryID,
        'stateId': stateID,
        'cityId': cityID,
        'fullName': name,
        'phoneCountryCode': countryCode,
        'phoneNumber': phone,
      });
      // print(data);
      dioClient.Response response;
      response = await BaseUrl.getDio1().patch("profile/update-account-details",
          data: formData,
          options: dioClient.Options(contentType: "multipart/form-data",
              headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken().toString()}"}));
      PRLoader.hide();
      print(response);
      return response.data;
    } catch (e) {
      PRLoader.hide();
    }
  }

  static profileUpgrade({
    required String businessLogo,
    required String countryID,
    required String stateID,
    required String cityID,
    required String bTypeID,
    required String bName,
    required String bCode,
    required String bPhone,
    required String bPersonName,
    required String phoneCode,
    required String phone,
    required String website,
  }) async {
    try {
      print('=== UPGRADE TO BUSINESS PROFILE ===');
      PRLoader.show();
      String fileName = businessLogo.split('/').last;
      var mData = {};
      if(businessLogo != ''){
        mData = {
          'businessLogo': await dioClient.MultipartFile.fromFile(
            businessLogo,
            filename: fileName,
          )
        };
      }
      dioClient.FormData formData = dioClient.FormData.fromMap({
        // 'businessLogo': businessLogo,
        'roleId' : '0a7f492c-3322-4a0a-af41-85ce8d551d28',
        'countryId': countryID,
        'stateId': stateID,
        'cityId': cityID,
        'businessTypeId': bTypeID,
        'businessName': bName,
        'businessPhoneCountryCode': bCode,
        'businessPhoneNumber': bPhone,
        'fullName': bPersonName,
        'phoneCountryCode': phoneCode,
        'phoneNumber': phone,
        'websiteUrl': website,
        ...mData,
      });
      print({
        // 'businessLogo': businessLogo,
        'roleId' : '0a7f492c-3322-4a0a-af41-85ce8d551d28',
        'countryId': countryID,
        'stateId': stateID,
        'cityId': cityID,
        'businessTypeId': bTypeID,
        'businessName': bName,
        'businessPhoneCountryCode': bCode,
        'businessPhoneNumber': bPhone,
        'fullName': bPersonName,
        'phoneCountryCode': phoneCode,
        'phoneNumber': phone,
        'websiteUrl': website,
        ...mData,
      });

      dioClient.Response response;
      response = await BaseUrl.getDio1().patch("profile/update-account-details",
          data: formData,
          options: dioClient.Options(contentType: "multipart/form-data",
              headers: {"Authorization": "Bearer ${SharedPrefUtils.getToken().toString()}"}));
      PRLoader.hide();
      print(response);
      return response.data;
    } catch (e) {
      PRLoader.hide();
    }
  }

}