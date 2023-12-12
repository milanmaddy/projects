import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Model/city_list_model.dart';
import 'package:kawawa_motors/Model/my_garage_model.dart';
import 'package:kawawa_motors/Model/my_spare_parts_model.dart';
import 'package:kawawa_motors/Model/sp_dropdown_model.dart';
import 'package:kawawa_motors/Model/sp_sub_category_model.dart';
import 'package:kawawa_motors/Model/state_list_model.dart';
import 'package:kawawa_motors/Model/see_all_garage_model.dart';
import 'package:kawawa_motors/Model/see_all_spare_parts_model.dart';
import 'package:kawawa_motors/Model/see_all_vehicle_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Services/see_all_services.dart';
import '../Model/car_maker_model.dart';
import '../Model/car_model_model.dart';
import '../Model/my_vehicle_model.dart';
import '../Model/register_option_model.dart';
import '../Model/see_all_dealer_model.dart';
import '../Services/Authentication_Services/authentrication_services.dart';
import '../Services/list_services.dart';

class SeeAllAndListController extends GetxController{

  SeeAllAndListController({this.type});

  String? type;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('===');
    print(type);
    // region = searchStateID.obs;
    // if(type == 'vehicle'){
      vehicleScrollController();
    // }else if(type == 'sp'){
      sparePartsScrollController();
    // }else if(type == 'garage'){
      garageScrollController();
    // }else if(type == 'dealer'){
      dealerScrollController();
    // }else if(type == 'mv'){
      myVehicleScrollController();
    // }else if(type == 'msp'){
      mySparePartsScrollController();
    // }else if(type == 'mg'){
      myGaragesScrollController();
    // }
  }
  // var region;

  var seeAllVehicle = SeeAllVehicleModel().obs;
  var seeAllSparePart = SeeAllSparePartsModel().obs;
  var seeAllGarage = SeeAllGarageModel().obs;
  var seeAllDealer = SeeAllDealerModel().obs;
  var myVehicleList = MyVehicleModel().obs;
  var mySparePartsList = MySparePartsModel().obs;
  var myGarageList = MyGarageModel().obs;

  ScrollController scrollController = ScrollController();
  AddController addController = Get.put(AddController());
  HomeController homeController = Get.put(HomeController());

  String carMakerID = '';
  String searchedCarMakerID = '';
  String carMakerName = '';
  String searchedCarMakerName = '';
  String carModelID = '';
  String searchedCarModelID = '';
  String carModelName = '';
  String searchedCarModelName = '';
  String countryID = '';
  String stateID = '';
  String searchStateID = '';
  String cityID = '';
  String searchCityID = '';
  String businessTypeID = '';
  String searchedBusinessTypeID = '';
  String phoneCodeID = '';
  String bPhoneCodeID = '';
  String countryName = '';
  String countryFlag = '';
  String stateName = '';
  String cityName = '';
  String bTypeName = '';
  String conditionID = '';
  String spCategoryID = '';
  String spSubCategoryID = '';
  String sellerTypeID = '';
  String vehicleTypeID = '';
  String carFuelID = '';
  String engineID = '';
  String gearBoxID = '';
  String colorID = '';
  String minPrice = '';
  String maxPrice = '';
  String minMileage = '';
  String maxMileage = '';

  String pageCountryId = '';
  String pageMakerId = '';
  String pageModelId = '';
  String pageStateId = '';
  String pageCityId = '';
  String pageBTypeId = '';

  String pageSellerTypeID = '';
  String pageConditionID = '';
  String pageCategoryID = '';
  String pageSubCategoryID = '';
  String pageVehicleTypeID = '';
  String pageFuelTypeId = '';
  String pageGearBoxId = '';
  String pageColorId = '';
  String pageEngineSize = '';
  String pageMinMileage = '';
  String pageMaxMileage = '';
  String pageMinPrice = '';
  String pageMaxPrice = '';
  String pageUserId = '';

  var carDropdownModel = CarDropDownModel().obs;
  var spDropdownModel = SparePartsDropDownModel().obs;
  var spSubCategoryModel = SparePartsSubCategoryModel().obs;
  var carModelModel = CarModelModel().obs;
  var rOPModel = RegisterOptionModel().obs;
  var stateModel = StateListModel().obs;
  var cityModel = CityListModel().obs;

  int pageNumberV = 1;
  int pageNumberSP = 1;
  int pageNumberG = 1;
  int pageNumberD = 1;
  int pageNumberMV = 1;
  int pageNumberMSP = 1;
  int pageNumberMG = 1;

  Future<RegisterOptionModel> getCountryListData()async{
    var data = await AuthenticationServices.registerOptions();
    try{
      if(data['statusCode'] == 200){
      rOPModel.value = RegisterOptionModel.fromJson(data);
      // getStateListData(countryID: homeController.newCountryID);
      }
    }catch(e){
      print(e);
    }
    update();
    return rOPModel.value;
  }

  Future<StateListModel> getStateListData({required String countryID, bool showLoader = true}) async {
    var data = await ListService.getStateList(countryID, showLoader) ;
    try {
      // if(data['statusCode'] == 200){
      stateModel.value = StateListModel.fromJson(data);
      // getCityListData(stateID: addController.cityID);
      // }
    } catch (e) {
      print(e);
    }
    update();
    return stateModel.value;
  }

  Future<CityListModel> getCityListData({required String stateID, bool showLoader = true}) async {
    var data = await ListService.getCityList(stateID, showLoader);
    try {
      cityModel.value = CityListModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    update();
    return cityModel.value;
  }

  Future<CarDropDownModel> getCarDropDownData({bool showLoader = true}) async {
    var data = await ListService.getCarDropDownList(showLoader) ;
    try {
      carDropdownModel.value = CarDropDownModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    update();
    return carDropdownModel.value;
  }

  Future<SparePartsDropDownModel> getSparePartsDropDownData({bool showLoader = true}) async {
    var data = await ListService.getSparePartsDropDownList(showLoader) ;
    try {
      spDropdownModel.value = SparePartsDropDownModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    update();
    return spDropdownModel.value;
  }

  Future<SparePartsSubCategoryModel> getSPSubCategoryListData({bool showLoader = true, required String categoryId}) async {
    var data = await ListService.getSPSubCategoryList(categoryId, showLoader) ;
    try {
      spSubCategoryModel.value = SparePartsSubCategoryModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    update();
    return spSubCategoryModel.value;
  }

  Future<CarModelModel> getCarModelData({required String carMakerID, bool showLoader = true}) async {
    var data = await ListService.getCarModelList(carMakerID, showLoader) ;
    try {
      carModelModel.value = CarModelModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    update();
    return carModelModel.value;
  }








  Future<SeeAllVehicleModel> getSeeAllVehicleData({
    required String carMakerID,
    required String carModelID,
    required String vehicleTypeID,
    required String sellerTypeID,
    required String countryID,
    required String stateID,
    required String cityID,
    required String carConditionID,
    required String carFuelTypeID,
    required String carGearBoxID,
    required String carColorID,
    required String carEngineSizeID,
    required String minMileage,
    required String maxMileage,
    required String minPrice,
    required String maxPrice,
    required String userId,
    bool navigate = false,
    bool showLoader = true,
    // bool isFirst = false
  }) async {
    pageNumberV = 1;
    pageMakerId = carMakerID;
    pageModelId = carModelID;
    pageVehicleTypeID = vehicleTypeID;
    pageSellerTypeID = sellerTypeID;
    pageCountryId = countryID;
    pageStateId = stateID;
    pageCityId = cityID;
    pageConditionID = carConditionID;
    pageFuelTypeId = carFuelTypeID;
    pageGearBoxId = carGearBoxID;
    pageColorId = carColorID;
    pageEngineSize = carEngineSizeID;
    pageMinMileage = minMileage;
    pageMaxMileage = maxMileage;
    pageMinPrice = minPrice;
    pageMaxPrice = maxPrice;
    pageUserId = userId;

    var data = await SeeAllServices.getSeeAllVehicleDetails(
        pageNumber: pageNumberV.toString(),
        carMakerId: carMakerID,
        carModelId: carModelID,
        vehicleTypeId: vehicleTypeID,
        sellerTypeId: sellerTypeID,
        countryId: countryID,
        stateId: stateID,
        cityId: cityID,
        carConditionId: carConditionID,
        carFuelTypeId: carFuelTypeID,
        carGearBoxId: carGearBoxID,
        carColorId: carColorID,
        carEngineSizeId: carEngineSizeID,
        minMileage: minMileage,
        maxMileage: maxMileage,
        minPrice: minPrice,
        maxPrice: maxPrice,
      userId: userId,
      showLoader: showLoader,
    );
    seeAllVehicle.value = SeeAllVehicleModel.fromJson(data);
    if(data['statusCode'] == 200){
      if(navigate == true) {
        Get.toNamed(AppRoute.seeAllVehicle, arguments: [countryID, carMakerID, carModelID, 'search']);
      }
    }
    pageNumberV++;
    print('LIST LENGTH');
    print(seeAllVehicle.value.data!.vehicles!.length);
    print('-+-+-+-');
    update();
    return seeAllVehicle.value;
  }

  Future<SeeAllVehicleModel> getSeeAllVehicleDataForNextPage({
    required String carMakerID,
    required String carModelID,
    required String vehicleTypeID,
    required String sellerTypeID,
    required String countryID,
    required String stateID,
    required String cityID,
    required String carConditionID,
    required String carFuelTypeID,
    required String carGearBoxID,
    required String carColorID,
    required String carEngineSizeID,
    required String minMileage,
    required String maxMileage,
    required String minPrice,
    required String maxPrice,
    required String userId,
    required String page,
  }) async {
    // vehicleScrollController();
    update();

    print('PAGE $pageNumberV DATA FOR VEHICLE');
    if(seeAllVehicle.value.data!.pagination!.lastPage! >= pageNumberV){
      var data = await SeeAllServices.getSeeAllVehicleDetails(
          carMakerId: carMakerID,
          pageNumber: pageNumberV.toString(),
          carModelId: carModelID,
          vehicleTypeId: vehicleTypeID,
          sellerTypeId: sellerTypeID,
          countryId: countryID,
          stateId: stateID,
          cityId: cityID,
          carConditionId: carConditionID,
          carFuelTypeId: carFuelTypeID,
          carGearBoxId: carGearBoxID,
          carColorId: carColorID,
          carEngineSizeId: carEngineSizeID,
          minMileage: minMileage,
          maxMileage: maxMileage,
          minPrice: minPrice,
          maxPrice: maxPrice,
          userId: userId,
          showLoader: true
      );
      seeAllVehicle.value.data!.vehicles!.addAll(SeeAllVehicleModel.fromJson(data).data!.vehicles!);
      print('FINAL LIST LENGTH IS ${seeAllVehicle.value.data!.vehicles!.length} OF VEHICLE');
      print('== page $pageNumberV ends here ==');
      pageNumberV++;
      print('== now page $pageNumberV begins ==');
    }
    update();
    return seeAllVehicle.value;
  }

  Future<SeeAllSparePartsModel> getSeeAllSparePartsData({
    required String sellerTypeID,
    required String countryID,
    required String carMakerID,
    required String carModelID,
    required String stateID,
    required String cityID,
    required String conditionID,
    required String categoryID,
    required String subCategoryID,
    required String userID,
    bool showLoader = true,
    bool navigation = false,
  }) async {
    // sparePartsScrollController();
    pageNumberSP = 1;
    pageCountryId = countryID;
    pageMakerId = carMakerID;
    pageModelId = carModelID;
    pageSellerTypeID = sellerTypeID;
    pageConditionID = conditionID;
    pageCategoryID = categoryID;
    pageSubCategoryID = subCategoryID;
    pageStateId = stateID;
    pageCityId = cityID;
    var data = await SeeAllServices.getSeeAllSparePartsDetails(
        countryID: countryID,
        carMakerID: carMakerID,
        carModelID: carModelID,
        page: pageNumberSP.toString(),
        cityID: cityID,
        stateID: stateID,
        categoryID: categoryID,
        conditionID: conditionID,
        sellerID: sellerTypeID,
        subCategoryID: subCategoryID,
        showLoader: showLoader,
      userID: userID
    );
    seeAllSparePart.value = SeeAllSparePartsModel.fromJson(data);
    if(data['statusCode'] == 200){
      if(navigation == true) {
        Get.toNamed(AppRoute.seeAllSP, arguments: [countryID, carMakerID, carModelID, 'search']);
      }
    }
    pageNumberSP++;
    print('-+-+-+-');
    print("pageNumber is $pageNumberSP");
    update();
    return seeAllSparePart.value;
  }

  Future<SeeAllSparePartsModel> getSeeAllSparePartsDataForNextPage({
    required String sellerTypeID,
    required String countryID,
    required String carMakerID,
    required String carModelID,
    required String stateID,
    required String cityID,
    required String conditionID,
    required String categoryID,
    required String subCategoryID,
    required String page,
    required String userID,
  }) async {
    update();
    if(seeAllSparePart.value.data!.pagination!.lastPage! >= pageNumberSP){
      var data = await SeeAllServices.getSeeAllSparePartsDetails(
          countryID: countryID,
          carMakerID: carMakerID,
          carModelID: carModelID,
          page: pageNumberSP.toString(),
          cityID: cityID,
          stateID: stateID,
          categoryID: categoryID,
          conditionID: conditionID,
          sellerID: sellerTypeID,
          subCategoryID: subCategoryID,
          userID: userID,
          showLoader: true
      );
      seeAllSparePart.value.data!.spareParts!.addAll(SeeAllSparePartsModel.fromJson(data).data!.spareParts!);
      pageNumberSP++;
    }
    update();
    return seeAllSparePart.value;
  }

  Future<SeeAllGarageModel> getSeeAllGarageData({
    required String countryId,
    required String stateId,
    required String cityId,
    required String userID,
    bool showLoader = true,
    bool navigation = false
  }) async {
    seeAllGarage.value.data = null;
    // update();
    // garageScrollController();
    pageNumberG = 1;
    pageCountryId = countryId;
    pageStateId = stateId;
    pageCityId = cityId;
    var data = await SeeAllServices.getSeeAllGarageDetails(
        pageNumber: pageNumberG.toString(),
        countryID: countryId,
        stateID: stateId,
        cityID: cityId,
      userID: userID,
      showLoader: showLoader
    );
    seeAllGarage.value = SeeAllGarageModel.fromJson(data);
    if(data['statusCode'] == 200){
      if(navigation == true) {
        Get.toNamed(AppRoute.seeAllRG, arguments: [countryId, stateId, cityId, 'search']);
      }
    }
    pageNumberG++;
    print('AFTER INCREMENTED, THE PAGE NUMBER IS $pageNumberG FOR GARAGE');
    update();
    return seeAllGarage.value;
  }

  Future<SeeAllGarageModel> getSeeAllGarageDataForNextPage({
    required String countryId,
    required String stateId,
    required String cityId,
    required String page,
    required String userID,
  }) async {
    update();
    print('PAGE $pageNumberG DATA FOR GARAGE');
    if(seeAllGarage.value.data!.pagination!.lastPage! >= pageNumberG){
      var data = await SeeAllServices.getSeeAllGarageDetails(
          pageNumber: pageNumberG.toString(),
          countryID: countryId,
          stateID: stateId,
          cityID: cityId,
          userID: userID,
        showLoader: true
      );
      seeAllGarage.value.data!.garages!.addAll(SeeAllGarageModel.fromJson(data).data!.garages!);
      print('FINAL GARAGE LIST LENGTH');
      print(seeAllGarage.value.data!.garages!.length);
      print('== page $pageNumberG ends here ==');
      pageNumberG++;
      print('== now page $pageNumberG begins ==');
    }
    update();
    return seeAllGarage.value;
  }

  Future<SeeAllDealerModel> getSeeAllDealerData({
    required String countryId,
    required String businessId,
    required String stateId,
    required String cityId,
    bool showLoader = true,
  }) async {
    print('object==');
    // update();
    pageNumberD = 1;
    pageCountryId = countryId;
    pageStateId = stateId;
    pageCityId = cityId;
    pageBTypeId = businessId;
    var data = await SeeAllServices.getSeeAllDealerDetails(
        pageName: pageNumberD.toString(),
        countryID: countryId,
        stateID: stateId,
        cityID: cityId,
        businessID: businessId,
      showLoader: showLoader
    );
    if(data['statusCode'] == 200){
      Get.toNamed(AppRoute.seeAllDealer, arguments: [countryId, stateId, cityId, businessId, 'search']);
    }
    seeAllDealer.value = SeeAllDealerModel.fromJson(data);
    print('NOW DEALER LIST LENGTH IS ${seeAllDealer.value.data!.businesses!.length}');
    pageNumberD++;
    print('NOW THE PAGE NUMBER IS $pageNumberD FOR DEALER');
    update();
    return seeAllDealer.value;
  }

  Future<SeeAllDealerModel> getSeeAllDealerDataForNextPage({
    required String countryId,
    required String businessId,
    required String stateId,
    required String cityId,
    required String page,
  }) async {
    update();
    print('PAGE $pageNumberD DATA FOR DEALER');
    if(seeAllDealer.value.data!.pagination!.lastPage! >= pageNumberD){
      var data = await SeeAllServices.getSeeAllDealerDetails(
          countryID: countryId,
          pageName: pageNumberD.toString(),
          stateID: stateId,
          cityID: cityId,
          businessID: businessId,
          showLoader: true
      );
      seeAllDealer.value.data!.businesses!.addAll(SeeAllDealerModel.fromJson(data).data!.businesses!);
      print('NOW DEALER LIST LENGTH IS ${seeAllDealer.value.data!.businesses!.length}');
      pageNumberD++;
    }
    update();
    return seeAllDealer.value;
  }

  dealerScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getSeeAllDealerDataForNextPage(stateId: pageStateId, cityId: pageCityId, countryId: pageCountryId, businessId: pageBTypeId, page: pageNumberD.toString());
      }
    });
  }

  vehicleScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getSeeAllVehicleDataForNextPage(carModelID: pageModelId, carMakerID: pageMakerId, countryID: pageCountryId, vehicleTypeID: pageVehicleTypeID, sellerTypeID: pageSellerTypeID, stateID: pageStateId, cityID: pageCityId, carFuelTypeID: pageFuelTypeId, carConditionID: pageConditionID, carColorID: pageColorId, carEngineSizeID: pageEngineSize, carGearBoxID: pageGearBoxId, minMileage: pageMinMileage, maxMileage: pageMaxMileage, minPrice: pageMinPrice, maxPrice: pageMaxPrice, page: pageNumberV.toString(), userId: pageUserId);
      }
    });
  }

  sparePartsScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getSeeAllSparePartsDataForNextPage(page: pageNumberSP.toString(), carModelID: pageModelId, carMakerID: pageMakerId, countryID: pageCountryId, subCategoryID: pageSubCategoryID, conditionID: pageConditionID, categoryID: pageCategoryID, sellerTypeID: pageSellerTypeID, stateID: pageStateId, cityID: pageCityId, userID: pageUserId);
      }
    });
  }

  garageScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getSeeAllGarageDataForNextPage(page: pageNumberG.toString(), countryId: pageCountryId, cityId: pageStateId, stateId: pageStateId, userID: pageUserId);
      }
    });
  }

  Future<MyVehicleModel> getMyVehicleListData() async {
    pageNumberMV = 1;
    var data = await SeeAllServices.getMyVehicleList(
        pageName: pageNumberMV.toString(),
      showLoader: false
    );
    myVehicleList.value = MyVehicleModel.fromJson(data);
    pageNumberMV++;
    update();
    return myVehicleList.value;
  }

  Future<MyVehicleModel> getMyVehicleListDataForNextPage({required String page}) async {
    if(myVehicleList.value.data!.pagination!.lastPage! >= pageNumberMV){
      pageNumberMV = 1;
      var data = await SeeAllServices.getMyVehicleList(
          pageName: pageNumberMV.toString(),
        showLoader: true
      );
      myVehicleList.value.data!.vehicles!.addAll(MyVehicleModel.fromJson(data).data!.vehicles!);
      pageNumberMV++;
    }
    update();
    return myVehicleList.value;
  }

  Future<MySparePartsModel> getMySparePartsListData() async {
    pageNumberMSP = 1;
    var data = await SeeAllServices.getMySparePartsList(
        pageName: pageNumberMSP.toString()
    );
    mySparePartsList.value = MySparePartsModel.fromJson(data);
    pageNumberMSP++;
    update();
    return mySparePartsList.value;
  }

  Future<MySparePartsModel> getMySparePartsListDataForNextPage({required String page}) async {
    pageNumberMSP = 1;
    if(mySparePartsList.value.data!.pagination!.lastPage! >= pageNumberMSP){
      var data = await SeeAllServices.getMySparePartsList(
          pageName: pageNumberMSP.toString(), showLoader: true
      );
      mySparePartsList.value.data!.spareParts!.addAll(MySparePartsModel.fromJson(data).data!.spareParts!);
      pageNumberMSP++;
    }
    update();
    return mySparePartsList.value;
  }

  Future<MyGarageModel> getMyGarageListData() async {
    pageNumberMG = 1;
    var data = await SeeAllServices.getMyGarageList(
        pageName: pageNumberMG.toString()
    );
    myGarageList.value = MyGarageModel.fromJson(data);
    pageNumberMG++;
    update();
    return myGarageList.value;
  }

  Future<MyGarageModel> getMyGarageListDataForNextPage({required String page}) async {
    pageNumberMG = 1;
    if(myGarageList.value.data!.pagination!.lastPage! >= pageNumberMG){
      var data = await SeeAllServices.getMyGarageList(
          pageName: pageNumberMG.toString(), showLoader: true
      );
      myGarageList.value.data!.garages!.addAll(MyGarageModel.fromJson(data).data!.garages!);
      pageNumberMG++;
    }
    update();
    return myGarageList.value;
  }

  myVehicleScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getMyVehicleListDataForNextPage(page: pageNumberMV.toString());
      }
    });
  }

  mySparePartsScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getMySparePartsListDataForNextPage(page: pageNumberMSP.toString());
      }
    });
  }

  myGaragesScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        getMyGarageListDataForNextPage(page: pageNumberMG.toString());
      }
    });
  }
}