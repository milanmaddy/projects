import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';

import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../Controller/see_all_controller.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/dropdown.dart';
import '../../GlobalWidgets/dropdown_popup.dart';
import '../../GlobalWidgets/loader.dart';
import '../../Model/car_maker_model.dart';
import '../../Model/car_model_model.dart';
import '../../Model/city_list_model.dart';
import '../../Model/sp_dropdown_model.dart';
import '../../Model/sp_sub_category_model.dart';
import '../../Model/state_list_model.dart';

class MoreFilterSpareParts extends StatelessWidget {
  MoreFilterSpareParts({Key? key}) : super(key: key);

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  HomeController homeController = Get.put(HomeController());

  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController sTypeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();

  var count = 1.obs;
  bool incMake = true;
  bool incModel = true;
  bool incSType = true;
  bool incCountry = true;
  bool incState = true;
  bool incCity = true;
  bool incCondition = true;
  bool incCat = true;
  bool incSubCat = true;


  @override
  Widget build(BuildContext context) {
    countryController.text = homeController.newCountryName;
    seeAllController.countryID = homeController.newCountryID;

    // seeAllController.carMakerID = '';
    // seeAllController.carMakerName = '';
    // seeAllController.carModelID = '';
    // seeAllController.carModelName = '';
    return Scaffold(
      appBar: CustomAppBarCross(title: 'Spare Parts',),
      backgroundColor: ColorConst.back,
      body: Padding(padding: const EdgeInsets.all(20).copyWith(top: 35),
        child: GetBuilder(
          init: seeAllController,
          initState: (controller){
            seeAllController.getSparePartsDropDownData(showLoader: false);
            seeAllController.getCarDropDownData(showLoader: false);
            seeAllController.getCountryListData();
          },
            builder: (value){
              return seeAllController.spDropdownModel.value.data == null?
              SizedBox(height: Get.height,
                  child: PRLoader.normalLoader()):
              seeAllController.rOPModel.value.data == null?
              SizedBox(height: Get.height,
                  child: PRLoader.normalLoader()):
              Column(
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
                      seeAllController.searchedCarMakerID = carMakers.carMakerId!;
                      seeAllController.searchedCarMakerName = carMakers.title!;
                      print(carMakers.carMakerId);
                      seeAllController.update();
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
                  // DropdownPopup(listItems: listItems, labelText: 'Model', labelBackColor: ColorConst.back, hintText: 'Select Model', selected: model,),
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
                      seeAllController.countryFlag = countries.countryFlagUrl!;
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
                      labelText: 'Category',
                      controller: categoryController,
                    titleList: seeAllController.spDropdownModel.value.data!.sparePartCategory!.map((e) => e.title.toString()).toList(),
                    objectList: seeAllController.spDropdownModel.value.data!.sparePartCategory,
                    function: (SparePartCategory category){
                      if(incCat == true){
                        categoryController.text == ''?
                        count.value = count.value - 0 :
                        count.value = count.value + 1;
                        print(count.value);
                        incCat = false;
                      }
                      subCategoryController.clear();
                      seeAllController.spCategoryID = category.sparePartCategoryId!;
                      seeAllController.update();
                      seeAllController.getSPSubCategoryListData(categoryId: seeAllController.spCategoryID);
                    },
                  ),
                  const SizedBox(height: 17),
                  CustomDropDownnn(
                    enablePopup: categoryController.text == ''? false : true,
                    dropdownMsg: 'Category',
                      labelText: 'Subcategory',
                      controller: subCategoryController,
                    titleList: seeAllController.spSubCategoryModel.value.data == null?
                    []: seeAllController.spSubCategoryModel.value.data!.sparePartSubCategories!.map((e) => e.title.toString()).toList(),
                    objectList: seeAllController.spSubCategoryModel.value.data == null?
                    []: seeAllController.spSubCategoryModel.value.data!.sparePartSubCategories,
                    function: (SparePartSubCategories subCategories){
                      if(incSubCat == true){
                        subCategoryController.text == ''?
                        count.value = count.value - 0 :
                        count.value = count.value + 1;
                        print(count.value);
                        incSubCat = false;
                      }
                      seeAllController.spSubCategoryID = subCategories.sparePartSubCategoryId!;
                      print(seeAllController.spSubCategoryID);
                      seeAllController.update();
                    },
                  ),
                  const SizedBox(height: 17),
                ],
              );
            }
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
                  // countryController.clear();
                  makeController.clear();
                  modelController.clear();
                  sTypeController.clear();
                  regionController.clear();
                  cityController.clear();
                  conditionController.clear();
                  categoryController.clear();
                  subCategoryController.clear();
                  seeAllController.carMakerName = '';
                  seeAllController.carModelName = '';
                  seeAllController.carMakerID = '';
                  seeAllController.carModelID = '';
                  seeAllController.sellerTypeID = '';
                  // seeAllController.countryID = '';
                  seeAllController.stateID = '';
                  seeAllController.cityID = '';
                  seeAllController.conditionID = '';
                  seeAllController.spCategoryID = '';
                  seeAllController.spSubCategoryID = '';
                  count.value = 1;
                  incMake = true;
                  incModel = true;
                  incSType = true;
                  incCountry = false;
                  incState = true;
                  incCity = true;
                  incCondition = true;
                  incCat = true;
                  incSubCat = true;
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
            Buttons.actionButtons(title: 'SEARCH PARTS', event: (){
              homeController.newCountryName = seeAllController.countryName;
              homeController.newCountryID = seeAllController.countryID;
              homeController.newCountryFlag = seeAllController.countryFlag;
              homeController.getHomePageData(
                  date:DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                  countryID: homeController.newCountryID
              );
              seeAllController.getSeeAllSparePartsData(
                  countryID: seeAllController.countryID,
                  carMakerID: seeAllController.searchedCarMakerID,
                  carModelID: seeAllController.searchedCarModelID,
                  cityID: seeAllController.cityID,
                  stateID: seeAllController.stateID,
                  sellerTypeID: seeAllController.sellerTypeID,
                  categoryID: seeAllController.spCategoryID,
                  subCategoryID: seeAllController.spSubCategoryID,
                  conditionID: seeAllController.conditionID,
                  userID: '',
                  navigation: true
              );
              print(seeAllController.countryID);
              print(seeAllController.stateID);
              print(seeAllController.cityID);
            })
          ],

        ),
      ),
    );
  }
}
