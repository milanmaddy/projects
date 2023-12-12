import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/item_available_controller.dart';
import 'package:kawawa_motors/Controller/list_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/dropdown.dart';
import 'package:kawawa_motors/GlobalWidgets/icon_dropdown.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Vehicle/see_all_vehicle_list.dart';
import '../../Constraints/image_const.dart';
import '../../Model/car_maker_model.dart';
import '../../Model/car_model_model.dart';

class SeeAllVehicle extends StatefulWidget {
  SeeAllVehicle({Key? key}) : super(key: key);

  @override
  State<SeeAllVehicle> createState() => _SeeAllVehicleState();
}

class _SeeAllVehicleState extends State<SeeAllVehicle> {
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController(type: 'vehicle'));

  HomeController homeController = Get.put(HomeController());
  ScrollController scrollController = ScrollController();

  // ListController listController = Get.put(ListController());
  String countryID = Get.arguments[0];
  String carMakerID = Get.arguments[1];
  String carModelID = Get.arguments[2];
  String flag = Get.arguments[3];
  var make = ''.obs;
  var model = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    make.value = seeAllController.searchedCarMakerName;
    model.value = seeAllController.searchedCarModelName;
    seeAllController.carMakerID = seeAllController.searchedCarMakerID;
    seeAllController.carModelID = seeAllController.searchedCarModelID;
  }

  @override
  Widget build(BuildContext context) {
    // print(SharedPrefUtils.getCountryId());
    return Scaffold(
      appBar: CustomAppBar(title: 'Vehicles'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        controller: seeAllController.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder(
            init: seeAllController,
              initState: (controller){
              seeAllController.getSeeAllVehicleData(
                  carMakerID: carMakerID,
                  carModelID: carModelID,
                sellerTypeID: seeAllController.sellerTypeID,
                vehicleTypeID: seeAllController.vehicleTypeID,
                countryID: countryID,
                stateID: seeAllController.stateID,
                cityID: seeAllController.cityID,
                carFuelTypeID: seeAllController.carFuelID,
                carConditionID: seeAllController.conditionID,
                carEngineSizeID: seeAllController.engineID,
                carGearBoxID: seeAllController.gearBoxID,
                carColorID: seeAllController.colorID,
                minPrice: seeAllController.minPrice,
                maxPrice: seeAllController.maxPrice,
                minMileage: seeAllController.minMileage,
                maxMileage: seeAllController.maxMileage,
                userId: '',
                showLoader: false
                // isFirst: true
              );
              seeAllController.getCarDropDownData(showLoader: false);
              if(flag == 'search'){
                seeAllController.getCarModelData(carMakerID: carMakerID, showLoader: false);
              }
              },
              builder: (value){
                return seeAllController.seeAllVehicle.value.data == null?
                  SizedBox(height: Get.height,
                      child: PRLoader.normalLoader()):
                    // seeAllController.seeAllVehicle.value.data!.vehicles!.isEmpty?
                    //     Text("data"):
                  Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: IconDropdownPopup(
                              enablePopup: true,
                                selected: make,
                                hintText: 'Make',
                                titleList: seeAllController.carDropdownModel.value.data == null?
                                []: seeAllController.carDropdownModel.value.data!.carMakers!.map((e) => e.title.toString()).toList(),
                                apiList: seeAllController.carDropdownModel.value.data == null?
                                []: seeAllController.carDropdownModel.value.data!.carMakers,
                                function: (CarMakers carMakers){
                                  seeAllController.carMakerID = carMakers.carMakerId!;
                                  print('=|=|=|=');
                                  print(seeAllController.carMakerID);
                                  print(seeAllController.searchedCarMakerID);
                                  model.value = '';
                                  seeAllController.seeAllVehicle.value.data = null;
                                  seeAllController.update();
                                  seeAllController.getCarModelData(carMakerID: carMakers.carMakerId!, showLoader: false);
                                  seeAllController.getSeeAllVehicleData(
                                      carMakerID: carMakers.carMakerId!,
                                      userId: '',
                                      carModelID: '',
                                      sellerTypeID: seeAllController.sellerTypeID,
                                      vehicleTypeID: seeAllController.vehicleTypeID,
                                      countryID: homeController.newCountryID,
                                      stateID: seeAllController.stateID,
                                      cityID: seeAllController.cityID,
                                      carFuelTypeID: seeAllController.carFuelID,
                                      carConditionID: seeAllController.conditionID,
                                      carEngineSizeID: seeAllController.engineID,
                                      carGearBoxID: seeAllController.gearBoxID,
                                      carColorID: seeAllController.colorID,
                                      minPrice: seeAllController.minPrice,
                                      maxPrice: seeAllController.maxPrice,
                                      minMileage: seeAllController.minMileage,
                                      maxMileage: seeAllController.maxMileage,
                                    showLoader: false
                                  );
                                },
                                img: ImageConst.type)
                        ),
                        const SizedBox(width: 20),
                        Expanded(//width: MediaQuery.of(context).size.width*0.48,
                            child: IconDropdownPopup(
                              enablePopup: make.value == ''? false : true,
                              dropdownMsg: 'Make',
                              selected: model,
                              hintText: 'Model',
                              titleList: seeAllController.carModelModel.value.data == null?
                              []: seeAllController.carModelModel.value.data!.carModels!.map((e) => e.title.toString()).toList(),
                              apiList: seeAllController.carModelModel.value.data == null?
                              []: seeAllController.carModelModel.value.data!.carModels,
                              function: (CarModels carModel){
                                // seeAllController.searchedCarMakerID = '';
                                // seeAllController.searchedCarModelID = '';
                                seeAllController.seeAllVehicle.value.data = null;
                                seeAllController.update();
                                seeAllController.getSeeAllVehicleData(
                                    carMakerID: seeAllController.carMakerID,
                                    userId: '',
                                    carModelID: carModel.carModelId!,
                                    sellerTypeID: seeAllController.sellerTypeID,
                                    vehicleTypeID: seeAllController.vehicleTypeID,
                                    countryID: homeController.newCountryID,
                                    stateID: seeAllController.stateID,
                                    cityID: seeAllController.cityID,
                                    carFuelTypeID: seeAllController.carFuelID,
                                    carConditionID: seeAllController.conditionID,
                                    carEngineSizeID: seeAllController.engineID,
                                    carGearBoxID: seeAllController.gearBoxID,
                                    carColorID: seeAllController.colorID,
                                    minPrice: seeAllController.minPrice,
                                    maxPrice: seeAllController.maxPrice,
                                    minMileage: seeAllController.minMileage,
                                    maxMileage: seeAllController.maxMileage,
                                  showLoader: false
                                );
                              },
                              img: ImageConst.city,)
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    seeAllController.seeAllVehicle.value.data!.vehicles!.isEmpty?
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child:
                          Stack(
                            children: [
                              SvgPicture.asset(ImageConst.noVehicle, height: 350),
                              const Positioned(right: 0, left: 0, bottom: 25,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
                                    SizedBox(height: 5),
                                    Text("I can't find what you are looking", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                                  ],
                                ),
                              )
                            ],
                          )
                        // Text('No Data Found', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: ColorConst.label),),
                      ),
                    ):
                    ListView.builder(
                        shrinkWrap: true,
                        physics:  const NeverScrollableScrollPhysics(),
                        itemCount: seeAllController.seeAllVehicle.value.data!.vehicles!.length,
                        itemBuilder: (context, index){
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: SeeAllVehicleList(vehicles: seeAllController.seeAllVehicle.value.data!.vehicles![index]),
                          );
                        }
                    ),
                  ],
                );
              }
          )
        ),

      ),
    );
  }
}
