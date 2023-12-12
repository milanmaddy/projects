// import 'package:get/get.dart';
// import 'package:kawawa_motors/Model/car_maker_model.dart';
// import 'package:kawawa_motors/Model/car_model_model.dart';
// import 'package:kawawa_motors/Services/list_services.dart';
//
// class ListController extends GetxController{
//
//   String carMakerID = '';
//   String carModelID = '';
//
//   var carMakerModel = CarMakerModel().obs;
//   var carModelModel = CarModelModel().obs;
//
//   Future<CarMakerModel> getCarMakerData() async {
//     var data = await ListService.getCarMakerData() ;
//     try {
//       carMakerModel.value = CarMakerModel.fromJson(data);
//     } catch (e) {
//       print(e);
//     }
//     update();
//     return carMakerModel.value;
//   }
//
//   Future<CarModelModel> getCarModelData({required String carMakerID}) async {
//     var data = await ListService.getCarModelData(carMakerID) ;
//     try {
//       carModelModel.value = CarModelModel.fromJson(data);
//     } catch (e) {
//       print(e);
//     }
//     update();
//     return carModelModel.value;
//   }
//
// }