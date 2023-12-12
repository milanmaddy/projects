import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/Model/image_model.dart';
import 'package:kawawa_motors/Model/my_vehicle_model.dart';
import 'package:kawawa_motors/Model/vehicle_details_model.dart';
import 'package:kawawa_motors/Model/vehicle_type_model.dart';
import 'package:kawawa_motors/Services/vehicle_services.dart';

class VehicleController extends GetxController{

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  AddController addController = Get.put(AddController());

  TextEditingController descController = TextEditingController();
  TextEditingController mileageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController vTypeController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fTypeController = TextEditingController();
  TextEditingController gearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController wtsController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    vTypeScrollController();
  }

  var vehicleModel = VehicleDetailsModel().obs;
  var vehicleTypeModel = VehicleTypeModel().obs;
  var myVehicleList = MyVehicleModel().obs;

  ScrollController scrollController = Get.put(ScrollController());

  int pageNumber = 1;
  String pageVehicleTypeId = '';
  String pageCountryId = '';

  Future<VehicleDetailsModel> getVehicleDetailsData({required String vid}) async {
    var data = await VehicleServices.getVehicleDetails(vid);
    if(data['statusCode'] == 200){
      vehicleModel.value = VehicleDetailsModel.fromJson(data);
      for (var element in vehicleModel.value.data!.vehicleImages!) {
        addController.selectedImages.add(ImageModel(
          imageUrl: element.imageUrl,
          imageID: element.vehicleImageId
        ));
      }
      addController.selectedImages.removeAt(0);
      addController.uploadedPicture.value = vehicleModel.value.data!.vehicle!.vehiclePrimaryImageUrl!;
      makeController.text = vehicleModel.value.data!.vehicle!.maker!.carMakerName!;
      modelController.text = vehicleModel.value.data!.vehicle!.model!.carModelName!;
      vTypeController.text = vehicleModel.value.data!.vehicle!.vehicleType!.carTypeName!;
      conditionController.text = vehicleModel.value.data!.vehicle!.condition!.carConditionName!;
      countryController.text = vehicleModel.value.data!.vehicle!.country!.countryName!;
      regionController.text = vehicleModel.value.data!.vehicle!.state!.stateName!;
      cityController.text = vehicleModel.value.data!.vehicle!.city!.cityName!;
      dateController.text = vehicleModel.value.data!.vehicle!.manufacturingYear!;
      fTypeController.text = vehicleModel.value.data!.vehicle!.carFuelType!.carFuelTypeName!;
      gearController.text = vehicleModel.value.data!.vehicle!.gearBox!.carGearBoxName!;
      colorController.text = vehicleModel.value.data!.vehicle!.color!.carColorName!;
      engineController.text = vehicleModel.value.data!.vehicle!.engineSize!.carEngineSizeName!;
      descController.text = vehicleModel.value.data!.vehicle!.description!;
      mileageController.text = vehicleModel.value.data!.vehicle!.mileage!;
      currencyController.text = vehicleModel.value.data!.vehicle!.currency!;
      priceController.text = vehicleModel.value.data!.vehicle!.price!;
      urlController.text = vehicleModel.value.data!.vehicle!.youtubeVideoUrl!;
      addController.carMakerID = vehicleModel.value.data!.vehicle!.maker!.carMakerId!;
      addController.carModelID = vehicleModel.value.data!.vehicle!.model!.carModelId!;
      addController.vehicleTypeID = vehicleModel.value.data!.vehicle!.vehicleType!.carTypeId!;
      addController.conditionID = vehicleModel.value.data!.vehicle!.condition!.carConditionId!;
      addController.countryID = vehicleModel.value.data!.vehicle!.country!.countryId!;
      addController.stateID = vehicleModel.value.data!.vehicle!.state!.stateId!;
      addController.cityID = vehicleModel.value.data!.vehicle!.city!.cityId!;
      addController.fuelID = vehicleModel.value.data!.vehicle!.carFuelType!.carFuelTypeId!;
      addController.gearBoxID = vehicleModel.value.data!.vehicle!.gearBox!.carGearBoxId!;
      addController.colorID = vehicleModel.value.data!.vehicle!.color!.carColorId!;
      addController.engineSizeID = vehicleModel.value.data!.vehicle!.engineSize!.carEngineSizeId!;
      if(vehicleModel.value.data!.vehicle!.whenToStart == '' || vehicleModel.value.data!.vehicle!.whenToStart == null){
        wtsController.text = '';
      }else{
        wtsController.text = vehicleModel.value.data!.vehicle!.whenToStart!.whenToStartTitle!;
        addController.whenToStartID = vehicleModel.value.data!.vehicle!.whenToStart!.whenToStartId!;
      }
      if(addController.countryID != ''){
        await seeAllController.getStateListData(countryID: addController.countryID, showLoader: false);
        // update();
        print('NOW STATE LIST FETCHED');
      }
      if(addController.stateID != ''){
        await seeAllController.getCityListData(stateID: addController.stateID, showLoader: false);
        update();
        print('NOW CITY LIST FETCHED');
      }
    }
    update();
    return vehicleModel.value;
  }

  Future<VehicleTypeModel> getVehicleTypeData({
    required String vTypeID,
    required String countryID
  }) async {
    pageNumber = 1;
    pageVehicleTypeId = vTypeID;
    pageCountryId = countryID;
    var data = await VehicleServices.getVehicleType(
        vTypeId: vTypeID,
        countryId: countryID,
        pageName: pageNumber.toString()
    );
    vehicleTypeModel.value = VehicleTypeModel.fromJson(data);
    pageNumber++;
    update();
    return vehicleTypeModel.value;
  }

  Future<VehicleTypeModel> getVehicleTypeDataForNextPage({
    required String vTypeID,
    required String countryID
  }) async {
    update();
    var data = await VehicleServices.getVehicleType(
        vTypeId: vTypeID,
        countryId: countryID,
        pageName: pageNumber.toString()
    );
    vehicleTypeModel.value.data!.vehicles!.addAll(VehicleTypeModel.fromJson(data).data!.vehicles!);
    print('VEHICL TYPE LIST LENGTH IS ${vehicleTypeModel.value.data!.vehicles!.length}');
    pageNumber++;
    update();
    return vehicleTypeModel.value;
  }

  vTypeScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getVehicleTypeDataForNextPage(vTypeID: pageVehicleTypeId, countryID: pageCountryId);
      }
    });
  }

  Future deleteVehicle({required String vehicleID})async{
    var data = await VehicleServices.deleteVehicle(vehicleID: vehicleID);
    if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
      seeAllController.getMyVehicleListData();
    }else{
      Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
    }
  }

  Future deleteVehicleImage({required String vehicleImgID})async {
    var data = await VehicleServices.deleteVehicleImage(vehicleImgID: vehicleImgID);
    if (data['statusCode'] == 200) {
      Get.snackbar("SUCCESS", data['message'], borderRadius: 5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.black);
      for (var element in addController.selectedImages) {
        if(element.imageID == vehicleImgID){
          addController.selectedImages.remove(element);
          addController.update();
          break;
        }
      }
    }else{
      Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
    }
  }



}