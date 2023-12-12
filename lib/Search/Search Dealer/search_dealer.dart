import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';

import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../Controller/home_controller.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/dropdown.dart';
import '../../GlobalWidgets/dropdown_popup.dart';
import '../../GlobalWidgets/loader.dart';
import '../../Model/city_list_model.dart';
import '../../Model/state_list_model.dart';

class SearchDealer extends StatelessWidget {
  SearchDealer({Key? key}) : super(key: key);

  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    countryController.clear();
    regionController.clear();
    cityController.clear();
    typeController.clear();
    countryController.text = homeController.newCountryName;
    seeAllController.countryID = homeController.newCountryID;
    seeAllController.searchCityID = '';
    seeAllController.cityName = '';
    seeAllController.stateName = '';
    seeAllController.searchStateID = '';
    seeAllController.businessTypeID = '';
    seeAllController.bTypeName = '';
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
          seeAllController.getCountryListData();
          seeAllController.getStateListData(countryID: homeController.newCountryID, showLoader: false);
          },
          builder: (value){
            return seeAllController.rOPModel.value.data == null?
            SizedBox(height: 500,
                child: PRLoader.normalLoader()):
                seeAllController.stateModel.value.data == null?
                SizedBox(height: 500,
                    child: PRLoader.normalLoader()):
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Find Dealers', style: AppTextStyle.black18_600),
                const SizedBox(height: 20),
                CustomDropDownnn(
                  labelText: 'Country*',
                  controller: countryController,
                  titleList: seeAllController.rOPModel.value.data == null?
                  []: seeAllController.rOPModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                  objectList: seeAllController.rOPModel.value.data == null?
                  []: seeAllController.rOPModel.value.data!.countries,
                  function: (Countries countries){
                    regionController.clear();
                    seeAllController.searchStateID = '';
                    seeAllController.stateName = '';
                    cityController.clear();
                    seeAllController.searchCityID = '';
                    seeAllController.cityName = '';
                    seeAllController.countryID = countries.countryId!;
                    seeAllController.countryName = countries.countryName!;
                    seeAllController.countryFlag = countries.countryFlagUrl!;
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
                    labelText: 'Region',
                  enablePopup: countryController.text == ''? false : true,
                  dropdownMsg: 'Country',
                    controller: regionController,
                  titleList: seeAllController.stateModel.value.data == null?
                  []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                  objectList: seeAllController.stateModel.value.data == null?
                  []: seeAllController.stateModel.value.data!.states,
                  function: (States states){
                    seeAllController.searchStateID = states.stateId!;
                    seeAllController.stateName = states.stateName!;
                    cityController.clear();
                    seeAllController.seeAllDealer.value.data = null;
                    seeAllController.update();
                    seeAllController.getCityListData(stateID: states.stateId!, showLoader: false);
                    // seeAllController.getSeeAllDealerData(
                    //     countryId: homeController.newCountryID,
                    //     stateId: states.stateId!,
                    //     cityId: '',
                    //     businessId: ''
                    // );
                  },
                ),
                // DropdownPopup(listItems: listItems, labelText: 'Region*', labelBackColor: ColorConst.back, hintText: 'Select Region', selected: region),
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
                  []: seeAllController.cityModel.value.data!.cities,
                  function: (Cities cities){
                    // dropController.isValueSelected = true;
                    seeAllController.searchCityID = cities.cityId!;
                    seeAllController.cityName = cities.cityName!;
                    // type.value = '';
                    seeAllController.seeAllDealer.value.data = null;
                    seeAllController.update();
                    // seeAllController.getSeeAllDealerData(
                    //     countryId: homeController.newCountryID,
                    //     stateId: seeAllController.stateID,
                    //     cityId: seeAllController.cityID,
                    //     businessId: ''
                    // );
                  },
                ),
                const SizedBox(height: 17),
                CustomDropDownnn(
                    labelText: 'Type',
                    controller: typeController,
                  titleList: seeAllController.rOPModel.value.data == null?
                  []: seeAllController.rOPModel.value.data!.businessTypes!.map((e) => e.description.toString()).toList(),
                  objectList: seeAllController.rOPModel.value.data == null?
                  []: seeAllController.rOPModel.value.data!.businessTypes!,
                  function: (BusinessTypes businessType){
                    seeAllController.searchedBusinessTypeID = businessType.businessTypeId!;
                    seeAllController.bTypeName = businessType.description!;
                    seeAllController.seeAllDealer.value.data = null;
                    seeAllController.update();
                    // seeAllController.getSeeAllDealerData(
                    //     countryId: homeController.newCountryID,
                    //     businessId: seeAllController.businessTypeID,
                    //     stateId: seeAllController.stateID,
                    //     cityId: seeAllController.cityID
                    // );
                  },
                ),
                const SizedBox(height: 17),
                GestureDetector(onTap: (){
                  // countryController.clear();
                  regionController.clear();
                  cityController.clear();
                  typeController.clear();
                  // seeAllController.countryID = '';
                  seeAllController.searchStateID = '';
                  seeAllController.stateName = '';
                  seeAllController.searchCityID = '';
                  seeAllController.cityName = '';
                  seeAllController.searchedBusinessTypeID = '';
                  seeAllController.bTypeName = '';
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
                const SizedBox(height: 25),
                Center(child: SizedBox(width: 265,
                    child: Buttons.filterBtn(title: 'SEARCH DEALERS', icon: ImageConst.glass, event: (){
                      homeController.newCountryName = seeAllController.countryName;
                      homeController.newCountryID = seeAllController.countryID;
                      homeController.newCountryFlag = seeAllController.countryFlag;
                      homeController.getHomePageData(
                          date:DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                          countryID: homeController.newCountryID
                      );
                      seeAllController.getSeeAllDealerData(
                          countryId: seeAllController.countryID,
                          stateId: seeAllController.searchStateID,
                          cityId: seeAllController.searchCityID,
                          businessId: seeAllController.searchedBusinessTypeID,
                          showLoader: false
                      );
                      print('BUSINESS ID : ${seeAllController.searchedBusinessTypeID}');
                    })))
              ],
            );
          }
      )

    );
  }
}
