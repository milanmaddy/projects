import 'package:dio/dio.dart' as dioClient;

class BaseUrl{

  static dioClient.Dio getDio1() {
    dioClient.BaseOptions options = dioClient.BaseOptions();
    options.baseUrl = "https://www.kawawamotorsapi.acelance.com:8020/";
    dioClient.Dio dio = new dioClient.Dio(options);
    return dio;
  }
}