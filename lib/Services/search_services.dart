import 'package:dio/dio.dart' as dioClient;

import '../Model/see_all_garage_model.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class SearchServices{

  static getSearchedGarageDetails({
    required String countryID,
    String pageNumber = '1',
    required String stateID,
    required String cityID,
  }) async {
    print({
      'page': pageNumber,
      'size': '10',
      'countryId': countryID,
      'stateId': stateID,
      'cityId': cityID,
    });
    try {
      dioClient.Response response;
      dioClient.Options options = SharedPrefUtils.isLoggedIn()?
      dioClient.Options(contentType: 'application/json'):
      dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      response = await BaseUrl.getDio1().get("garage/get-all-garages",
          queryParameters: {
            'page': pageNumber,
            'size': '10',
            'countryId': countryID,
            'stateId': stateID,
            'cityId': cityID,
          },
          options: options
      );
      print('SEARCHED GARAGE DATA');
      print(response);
      return response.data;
    }catch (e){
      return SeeAllGarageModel();
    }
  }

  // static getSearchedDealerDetails({
  //   required String countryID,
  //   String pageNumber = '1',
  //   required String stateID,
  //   required String cityID,
  //   required String type,
  // }) async {
  //   print({
  //     'page': pageNumber,
  //     'size': '10',
  //     'countryId': countryID,
  //     'stateId': stateID,
  //     'cityId': cityID,
  //     'type': type,
  //   });
  //   try {
  //     dioClient.Response response;
  //     dioClient.Options options = SharedPrefUtils.isLoggedIn()?
  //     dioClient.Options(contentType: 'application/json'):
  //     dioClient.Options(contentType: 'application/json',
  //         headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
  //     );
  //     response = await BaseUrl.getDio1().get("garage/get-all-garages",
  //         queryParameters: {
  //           'page': pageNumber,
  //           'size': '10',
  //           'countryId': countryID,
  //           'stateId': stateID,
  //           'cityId': cityID,
  //         },
  //         options: options
  //     );
  //     print('SEARCHED GARAGE DATA');
  //     print(response);
  //     return response.data;
  //   }catch (e){
  //     return SeeAllGarageModel();
  //   }
  // }

}