import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/search_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';

import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../Controller/see_all_controller.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/dropdown.dart';
import '../../GlobalWidgets/dropdown_popup.dart';
import '../../Model/city_list_model.dart';
import '../../Model/state_list_model.dart';

class SearchRepairGarages extends StatelessWidget {
  SearchRepairGarages({Key? key}) : super(key: key);

  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  SearchDataController searchController = Get.put(SearchDataController());
  HomeController homeController = Get.put(HomeController());



  @override
  Widget build(BuildContext context) {
    countryController.clear();
    regionController.clear();
    cityController.clear();
    countryController.text = homeController.newCountryName;
    seeAllController.countryID = homeController.newCountryID;
    seeAllController.searchCityID = '';
    seeAllController.cityName = '';
    seeAllController.stateName = '';
    seeAllController.searchStateID = '';
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
                SizedBox(
                  height: 500,
                  child: PRLoader.normalLoader(),
                ):
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Find Repair Garages', style: AppTextStyle.black18_600),
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
                  enablePopup: countryController.text == ''? false : true,
                  dropdownMsg: 'Country',
                  labelText: 'Region',
                  controller: regionController,
                  titleList: seeAllController.stateModel.value.data == null?
                  []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                  objectList: seeAllController.stateModel.value.data == null?
                  []: seeAllController.stateModel.value.data!.states,
                  function: (States states){
                    cityController.clear();
                    seeAllController.searchCityID = '';
                    seeAllController.cityName = '';
                    print('ggg');
                    print(states.stateName);
                    seeAllController.searchStateID = states.stateId!;
                    seeAllController.stateName = states.stateName!;
                    seeAllController.update();
                    // addController.update();
                    seeAllController.getCityListData(stateID: seeAllController.searchStateID);
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
                    seeAllController.searchCityID = cities.cityId!;
                    seeAllController.cityName = cities.cityName!;
                    seeAllController.update();
                    // addController.update();
                  },
                ),
                const SizedBox(height: 17),
                GestureDetector(onTap: (){
                  // countryController.clear();
                  regionController.clear();
                  cityController.clear();
                  // seeAllController.countryID = '';
                  // seeAllController.countryName = '';
                  seeAllController.searchStateID = '';
                  seeAllController.stateName = '';
                  seeAllController.searchCityID = '';
                  seeAllController.cityName = '';
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
                    child: Buttons.filterBtn(title: 'SEARCH GARAGES', icon: ImageConst.glass, event: (){
                      // searchController.getSearchedGarageData(
                      //   countryId: seeAllController.countryID,
                      //   stateId: seeAllController.stateID,
                      //   cityId: seeAllController.cityID,
                      // );
                      homeController.newCountryName = seeAllController.countryName;
                      homeController.newCountryID = seeAllController.countryID;
                      homeController.newCountryFlag = seeAllController.countryFlag;
                      homeController.getHomePageData(
                          date:DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                          countryID: homeController.newCountryID
                      );
                      seeAllController.getSeeAllGarageData(
                          countryId: seeAllController.countryID,
                          stateId: seeAllController.searchStateID,
                          cityId: seeAllController.searchCityID,
                          userID: '',
                          navigation: true
                      );
                      // print(seeAllController.countryID);
                      // print(seeAllController.stateID);
                      // print(seeAllController.cityID);
                    })))
              ],
            );
          }
      )

    );
  }
}
