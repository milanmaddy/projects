import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/dropdown.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Routes/app_route.dart';

import '../../GlobalWidgets/dropdown_popup.dart';
import '../../GlobalWidgets/loader.dart';
import '../../Model/car_maker_model.dart';
import '../../Model/car_model_model.dart';

class SearchVehicle extends StatelessWidget {
  SearchVehicle({Key? key}) : super(key: key);
  
  // DropDownController dropController = Get.put(DropDownController());
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  HomeController homeController = Get.put(HomeController());

  var make = ''.obs;
  var model = ''.obs;

  @override
  Widget build(BuildContext context) {
    // seeAllController.searchedCarMakerName = '';
    // seeAllController.searchedCarMakerID = '';
    // seeAllController.searchedCarModelName = '';
    // seeAllController.searchedCarModelID = '';
    // makeController.clear();
    // modelController.clear();
    return Container(padding: const EdgeInsets.all(15).copyWith(top: 20, bottom: 50),
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: GetBuilder(
        init: seeAllController,
          initState: (controller){
            seeAllController.getCarDropDownData(showLoader: false);
          },
          builder: (value){
            return seeAllController.carDropdownModel.value.data == null?
            SizedBox(height: 500,
                child: PRLoader.normalLoader()):
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Find Vehicles', style: AppTextStyle.black18_600),
                const SizedBox(height: 20),
                CustomDropDownnn(
                  labelText: 'Make',
                  controller: makeController,
                  titleList: seeAllController.carDropdownModel.value.data!.carMakers!.map((e) => e.title.toString()).toList(),
                  objectList: seeAllController.carDropdownModel.value.data!.carMakers,
                  function: (CarMakers carMakers){
                    modelController.clear();
                    seeAllController.searchedCarMakerID = carMakers.carMakerId!;
                    seeAllController.searchedCarMakerName = carMakers.title!;
                    print(carMakers.carMakerId);
                    seeAllController.update();
                    seeAllController.update();
                    seeAllController.getCarModelData(carMakerID: carMakers.carMakerId!);
                  },
                ),
                // DropdownPopup(labelText: 'Make*', labelBackColor: ColorConst.back, hintText: 'Select Make', selected: make,),
                const SizedBox(height: 17),
                CustomDropDownnn(
                  labelText: 'Model',
                  controller: modelController,
                  enablePopup: makeController.text == ''? false : true,
                  dropdownMsg: 'Make',
                  titleList: seeAllController.carModelModel.value.data == null?
                  []: seeAllController.carModelModel.value.data!.carModels!.map((e) => e.title.toString()).toList(),
                  objectList: seeAllController.carModelModel.value.data == null?
                  []: seeAllController.carModelModel.value.data!.carModels,
                  function: (CarModels carModels){
                    seeAllController.searchedCarModelID = carModels.carModelId!;
                    seeAllController.searchedCarModelName = carModels.title!;
                    print(carModels.carModelId);
                    seeAllController.update();
                  },
                ),
                const SizedBox(height: 17),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: (){
                      makeController.clear();
                      modelController.clear();
                      seeAllController.searchedCarMakerID = '';
                      seeAllController.searchedCarMakerName = '';
                      seeAllController.searchedCarModelID = '';
                      seeAllController.searchedCarModelName = '';
                    },
                      child: Container(color: Colors.transparent,
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageConst.reset),
                            const SizedBox(width: 10),
                            Text('Reset', style: AppTextStyle.grey15_600)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(onTap: (){
                      seeAllController.searchedCarMakerID = '';
                      seeAllController.searchedCarMakerName = '';
                      seeAllController.searchedCarModelID = '';
                      seeAllController.searchedCarModelName = '';
                      Get.toNamed(AppRoute.searchVehicle);
                      },
                        child: Text('More Filters', style: AppTextStyle.label2))
                  ],
                ),
                const SizedBox(height: 25),
                Center(child: SizedBox(width: 265,
                    child: Buttons.filterBtn(title: 'SEARCH CARS', icon: ImageConst.glass, event: (){
                      seeAllController.getSeeAllVehicleData(
                          carMakerID: seeAllController.searchedCarMakerID,
                          carModelID: seeAllController.searchedCarModelID,
                          vehicleTypeID: '',
                          sellerTypeID: '',
                          countryID: homeController.newCountryID,
                          stateID: '',
                          cityID: '',
                          carConditionID: '',
                          carFuelTypeID: '',
                          carGearBoxID: '',
                          carColorID: '',
                          carEngineSizeID: '',
                          minMileage: '',
                          maxMileage: '',
                          minPrice: '',
                          maxPrice: '',
                          userId: '',
                        navigate: true
                      );
                      // print(seeAllController.carMakerID);
                      // print(seeAllController.carMakerName);
                      // print(seeAllController.carModelID);
                      // print(seeAllController.carModelName);
                    })))
              ],
            );
          }
      )
    );
  }
  // resetDropdownValue(){
  //   selectedVal = null;
  // }
}
