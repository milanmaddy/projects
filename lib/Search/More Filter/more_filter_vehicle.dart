import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/dropdown_popup.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field_2.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';
import 'package:kawawa_motors/Screen/PopUp/logout_popup.dart';
import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../GlobalWidgets/dropdown.dart';
import 'package:get/get.dart';

import '../../GlobalWidgets/loader.dart';
import '../../Model/car_maker_model.dart';
import '../../Model/car_model_model.dart';
import '../../Model/city_list_model.dart';
import '../../Model/state_list_model.dart';

class MoreFilterVehicle extends StatelessWidget {
  MoreFilterVehicle({Key? key}) : super(key: key);

  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController vTypeController = TextEditingController();
  TextEditingController sTypeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController fTypeController = TextEditingController();
  TextEditingController gearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController minMileageController = TextEditingController();
  TextEditingController maxMileageController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  var count = 1.obs;
  bool incMake = true;
  bool incModel = true;
  bool incVType = true;
  bool incSType = true;
  bool incCountry = true;
  bool incState = true;
  bool incCity = true;
  bool incCondition = true;
  bool incFType = true;
  bool incGear = true;
  bool incColor = true;
  bool incEngine = true;
  bool minMileage = true;
  bool maxMileage = true;

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    countryController.text = homeController.newCountryName;
    seeAllController.countryID = homeController.newCountryID;
    // seeAllController.vehicleTypeID = '';
    // seeAllController.sellerTypeID = '';
    // seeAllController.carModelID = '';
    // seeAllController.carModelName = '';
    return Scaffold(
      appBar: CustomAppBarCross(title: 'Vehicles',),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20).copyWith(top: 35, bottom: 180),
          child:
              GetBuilder(
                init: seeAllController,
                initState: (controller){
                  seeAllController.getCarDropDownData(showLoader: false);
                  seeAllController.getCountryListData();
                },
                  builder: (value){
                    return seeAllController.carDropdownModel.value.data == null?
                    SizedBox(height: Get.height,
                        child: PRLoader.normalLoader()):
                    seeAllController.rOPModel.value.data == null?
                      SizedBox(height: Get.height,
                          child: PRLoader.normalLoader()):
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropDownnn(
                          // count: count,
                          labelText: 'Make',
                          controller: makeController,
                          titleList: seeAllController.carDropdownModel.value.data!.carMakers!.map((e) => e.title.toString()).toList(),
                          objectList: seeAllController.carDropdownModel.value.data!.carMakers,
                          function: (CarMakers carMakers){
                            if(incMake == true){
                              makeController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incMake = false;
                            }
                            modelController.clear();
                            seeAllController.searchedCarModelName = '';
                            seeAllController.searchedCarModelID = '';
                            seeAllController.searchedCarMakerID = carMakers.carMakerId!;
                            seeAllController.searchedCarMakerName = carMakers.title!;
                            print(carMakers.carMakerId);
                            seeAllController.update();
                            seeAllController.getCarModelData(carMakerID: carMakers.carMakerId!);
                          },
                        ),
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
                            if(incModel == true){
                              modelController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incModel = false;
                            }
                            seeAllController.searchedCarModelID = carModels.carModelId!;
                            seeAllController.searchedCarModelName = carModels.title!;
                            print(carModels.carModelId);
                            seeAllController.update();
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                            labelText: 'Vehicle Type',
                            controller: vTypeController,
                          titleList: seeAllController.carDropdownModel.value.data == null?
                          []: seeAllController.carDropdownModel.value.data!.carTypes!.map((e) => e.title.toString()).toList(),
                          objectList: seeAllController.carDropdownModel.value.data == null?
                          []: seeAllController.carDropdownModel.value.data!.carTypes!.map((e) => e.carTypeId.toString()).toList(),
                          function: (CarTypes carType){
                            if(incVType == false){
                              countryController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incVType = true;
                              seeAllController.vehicleTypeID = carType.carTypeId!;
                              seeAllController.update();
                            }
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          labelText: 'Seller Type',
                          controller: sTypeController,
                          titleList: seeAllController.rOPModel.value.data == null?
                          []: seeAllController.rOPModel.value.data!.roles!.map((e) => e.title.toString()).toList(),
                          objectList: seeAllController.rOPModel.value.data!.roles,
                          function: (Roles roles){
                            if(incSType == true){
                              sTypeController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incSType = false;
                            }
                            seeAllController.sellerTypeID = roles.roleId!;
                            print(seeAllController.sellerTypeID);
                            seeAllController.update();
                          },
                        ),
                        // DropdownPopup(labelText: 'Seller Type', labelBackColor: ColorConst.back, hintText: 'Select Seller Type', selected: sType,),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          // count: count,
                          labelText: 'Country',
                          controller: countryController,
                          titleList: seeAllController.rOPModel.value.data == null?
                          []: seeAllController.rOPModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                          objectList: seeAllController.rOPModel.value.data == null?
                          []: seeAllController.rOPModel.value.data!.countries,
                          function: (Countries countries){
                            if(incCountry == false){
                              countryController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incCountry = true;
                            }
                            // if(in)
                            incState = true;
                            incCity = true;
                            regionController.clear();
                            cityController.clear();
                            seeAllController.countryID = countries.countryId!;
                            seeAllController.countryName = countries.countryName!;
                            seeAllController.countryFlag = countries.countryFlag!;
                            print(countries.countryId);
                            seeAllController.update();
                            seeAllController.getStateListData(countryID: seeAllController.countryID);
                            // homeController.newCountryName = countries.countryName!;
                            // homeController.newCountryID = countries.countryId!;
                            // homeController.newCountryFlag = countries.countryFlagUrl!;
                            // homeController.getHomePageData(
                            //     date:DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                            //     countryID: homeController.newCountryID
                            // );
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          enablePopup: countryController.text == ''? false : true,
                          dropdownMsg: 'Country',
                          labelText: 'Region',
                          controller: regionController,
                          titleList: seeAllController.stateModel.value.data == null?
                          []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                          objectList: seeAllController.stateModel.value.data == null?
                          []: seeAllController.stateModel.value.data!.states,
                          function: (States states){
                            if(incState == true){
                              regionController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incState = false;
                            }
                            incCity = true;
                            cityController.clear();
                            print('ggg');
                            print(states.stateName);
                            seeAllController.stateID = states.stateId!;
                            print(states.stateId);
                            seeAllController.update();
                            seeAllController.getCityListData(stateID: seeAllController.stateID);
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          enablePopup: regionController.text == ''? false : true,
                          dropdownMsg: countryController.text == '' && regionController.text == ''?
                          'Country & Region':
                          regionController.text == ''?
                          'Region': '',
                          labelText: 'City',
                          controller: cityController,
                          titleList: seeAllController.cityModel.value.data == null?
                          []: seeAllController.cityModel.value.data!.cities!.map((e) => e.cityName.toString()).toList(),
                          objectList: seeAllController.cityModel.value.data == null?
                          []: seeAllController.cityModel.value.data!.cities!,
                          function: (Cities cities){
                            if(incCity == true){
                              cityController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incCity = false;
                            }
                            seeAllController.cityID = cities.cityId!;
                            print(cities.cityId);
                            seeAllController.update();
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          labelText: 'Condition',
                          controller: conditionController,
                          titleList: seeAllController.carDropdownModel.value.data!.carConditions!.map((e) => e.title.toString()).toList(),
                          objectList: seeAllController.carDropdownModel.value.data!.carConditions,
                          function: (CarConditions carConditions){
                            if(incCondition == true){
                              conditionController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incCondition = false;
                            }
                            seeAllController.conditionID = carConditions.carConditionId!;
                            print(carConditions.carConditionId);
                            seeAllController.update();
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          labelText: 'Fuel Type',
                          controller: fTypeController,
                          titleList: seeAllController.carDropdownModel.value.data!.carFuelType!.map((e) => e.title.toString()).toList(),
                          objectList: seeAllController.carDropdownModel.value.data!.carFuelType,
                          function: (CarFuelType carFuelType){
                            if(incFType == true){
                              fTypeController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incFType = false;
                            }
                            seeAllController.carFuelID = carFuelType.carFuelTypeId!;
                            print(carFuelType.carFuelTypeId);
                            seeAllController.update();
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          labelText: 'Gear Box',
                          controller: gearController,
                          titleList: seeAllController.carDropdownModel.value.data!.carGearBox!.map((e) => e.title.toString()).toList(),
                          objectList: seeAllController.carDropdownModel.value.data!.carGearBox,
                          function: (CarGearBox carGearBox){
                            if(incGear == true){
                              gearController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incGear = false;
                            }
                            seeAllController.gearBoxID = carGearBox.carGearBoxId!;
                            print(carGearBox.carGearBoxId);
                            seeAllController.update();
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          labelText: 'Color',
                          controller: colorController,
                          titleList: seeAllController.carDropdownModel.value.data!.carColor!.map((e) => e.title.toString()).toList(),
                          objectList: seeAllController.carDropdownModel.value.data!.carColor,
                          function: (CarColor color){
                            if(incColor == true){
                              colorController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incColor = false;
                            }
                            seeAllController.colorID = color.carColorId!;
                            print(color.carColorId);
                            seeAllController.update();
                          },
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          labelText: 'Engine Size',
                          controller: engineController,
                          titleList: seeAllController.carDropdownModel.value.data!.carEngineSize!.map((e) => e.title.toString()).toList(),
                          objectList: seeAllController.carDropdownModel.value.data!.carEngineSize,
                          function: (CarEngineSize engine){
                            if(incEngine == true){
                              engineController.text == ''?
                              count.value = count.value - 0 :
                              count.value = count.value + 1;
                              print(count.value);
                              incEngine = false;
                            }
                            seeAllController.engineID = engine.carEngineSizeId!;
                            print(engine.carEngineSizeId);
                            seeAllController.update();
                          },
                        ),
                        const SizedBox(height: 20),
                        // Text('Mileage', style: AppTextStyle.label2),
                        // const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(child: CustomInputField2(
                              controller: minMileageController,
                              prefixIcon: '',
                              labelText: 'Min Mileage',
                              type: TextInputType.number,
                              iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                              onChanged: (value){
                                // if(minMileageController.text.isEmpty){
                                //   if(minMileage == true){
                                //     minMileageController.text == ''?
                                //     count.value = count.value - 0 :
                                //     count.value = count.value + 1;
                                //     print(count.value);
                                //     // if(minMileageController.text.isEmpty){
                                //     //   minMileage = true;
                                //     // }else{minMileage = false;}
                                //   }
                                // }
                                value = minMileageController.text;
                                seeAllController.minMileage = value;
                              },
                            )),
                            const SizedBox(width: 17),
                            Expanded(child: CustomInputField2(controller: maxMileageController, prefixIcon: '',labelText: 'Max Mileage',
                              type: TextInputType.number,
                              iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                              onChanged: (value){
                              value = maxMileageController.text;
                              seeAllController.maxMileage = value;
                              },
                            )),
                          ],
                        ),
                        const SizedBox(height: 15),
                        // Text('Price', style: AppTextStyle.label2),
                        // const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(child: CustomInputField2(controller: minPriceController, prefixIcon: '', labelText: 'Min Price',
                            onChanged: (value){
                              value = minPriceController.text;
                              seeAllController.minPrice = value;
                            },
                              type: TextInputType.number,
                              iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                            )),
                            const SizedBox(width: 17),
                            Expanded(child: CustomInputField2(controller: maxPriceController, prefixIcon: '', labelText: 'Max Price',
                            onChanged: (value){
                              value = maxPriceController.text;
                              seeAllController.maxPrice = value;
                            },
                              type: TextInputType.number,
                              iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                            )),
                          ],
                        ),
                      ],
                    );
                  }
              )

        ),
      ),

      bottomSheet: Container(height: 150, width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap: (){
                  makeController.clear();
                  seeAllController.searchedCarMakerID = '';
                  seeAllController.searchedCarMakerName = '';
                  modelController.clear();
                  seeAllController.searchedCarModelID = '';
                  seeAllController.searchedCarModelName = '';
                  vTypeController.clear();
                  seeAllController.vehicleTypeID = '';
                  sTypeController.clear();
                  seeAllController.sellerTypeID = '';
                  // countryController.clear();
                  // seeAllController.countryID = '';
                  regionController.clear();
                  seeAllController.stateID = '';
                  cityController.clear();
                  seeAllController.cityID = '';
                  conditionController.clear();
                  seeAllController.conditionID = '';
                  fTypeController.clear();
                  seeAllController.carFuelID = '';
                  gearController.clear();
                  seeAllController.gearBoxID = '';
                  colorController.clear();
                  seeAllController.colorID = '';
                  engineController.clear();
                  seeAllController.engineID = '';
                  minPriceController.clear();
                  seeAllController.minPrice = '';
                  maxPriceController.clear();
                  seeAllController.maxPrice = '';
                  minMileageController.clear();
                  seeAllController.minMileage = '';
                  maxMileageController.clear();
                  seeAllController.maxMileage = '';
                  incMake = true;
                  incModel = true;
                  incVType = true;
                  incSType = true;
                  incCountry = true;
                  incState = true;
                  incCity = true;
                  incCondition = true;
                  incFType = true;
                  incGear = true;
                  incColor = true;
                  incEngine = true;
                  minMileage = true;
                  maxMileage = true;
                  count.value = 1;
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
                GestureDetector(onTap: (){},
                    child: Obx(() => Text('${count.value} Filters Selected', style: AppTextStyle.label2))
                )
              ],
            ),
            const SizedBox(height: 20),
            Buttons.actionButtons(title: 'SEARCH CARS', event: (){
              seeAllController.seeAllVehicle.value.data = null;
              homeController.newCountryName = seeAllController.countryName;
              homeController.newCountryID = seeAllController.countryID;
              homeController.newCountryFlag = seeAllController.countryFlag;
              homeController.getHomePageData(
                  date:DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                  countryID: homeController.newCountryID
              );
              seeAllController.getSeeAllVehicleData(
                  carMakerID: seeAllController.searchedCarMakerID,
                  carModelID: seeAllController.searchedCarModelID,
                  vehicleTypeID: seeAllController.vehicleTypeID,
                  sellerTypeID: seeAllController.sellerTypeID,
                  countryID: seeAllController.countryID,
                  stateID: seeAllController.stateID,
                  cityID: seeAllController.cityID,
                  carConditionID: seeAllController.conditionID,
                  carFuelTypeID: seeAllController.carFuelID,
                  carGearBoxID: seeAllController.gearBoxID,
                  carColorID: seeAllController.colorID,
                  carEngineSizeID: seeAllController.engineID,
                  minMileage: minMileageController.text,
                  maxMileage: maxMileageController.text,
                  minPrice: minPriceController.text,
                  maxPrice: maxPriceController.text,
                  userId: '',
                navigate: true
              );
              print(seeAllController.searchedCarMakerID);
              print(seeAllController.searchedCarModelID);
            })
          ],

        ),
      ),
    );
  }



}
