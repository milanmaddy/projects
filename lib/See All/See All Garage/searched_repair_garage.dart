import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kawawa_motors/Controller/search_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Garage/see_all_repair_garage_list.dart';

import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../GlobalWidgets/app_bar.dart';
import '../../GlobalWidgets/icon_dropdown.dart';
import '../../GlobalWidgets/loader.dart';
import '../../Model/city_list_model.dart';
import '../../Model/state_list_model.dart';


class SearchedGarage extends StatelessWidget {
  SearchedGarage({Key? key}) : super(key: key);

  SearchDataController searchController = Get.put(SearchDataController());
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());

  var region = ''.obs;
  var city = ''.obs;

  String countryId = Get.arguments[0];
  String stateId = Get.arguments[1];
  String cityId = Get.arguments[2];

  @override
  Widget build(BuildContext context) {
    searchController.stateID = stateId;
    searchController.cityID = cityId;
    region.value = seeAllController.stateName;
    return Scaffold(
      appBar: CustomAppBar(title: 'Garage'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        // controller: seeAllController.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GetBuilder(
                init: searchController,
                initState: (controller){
                  searchController.getSearchedGarageData(
                      countryId: countryId,
                      stateId: stateId,
                      cityId: cityId
                  );
                },
                builder: (value){
                  return searchController.searchGarage.value.data == null?
                  SizedBox(height: Get.height,
                      child: PRLoader.normalLoader()):
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: IconDropdownPopup(
                                enablePopup: true,
                                selected: region,
                                hintText: 'Region',
                                titleList: seeAllController.stateModel.value.data == null?
                                []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                                apiList: seeAllController.stateModel.value.data == null?
                                []: seeAllController.stateModel.value.data!.states,
                                function: (States states){
                                  searchController.stateID = states.stateId!;
                                  print(searchController.stateID);
                                  city.value = '';
                                  searchController.searchGarage.value.data = null;
                                  searchController.update();
                                  seeAllController.getCityListData(stateID: states.stateId!, showLoader: false);

                                  searchController.getSearchedGarageData(
                                      countryId: countryId,
                                      stateId: searchController.stateID,
                                      cityId: '');
                                },
                                img: ImageConst.lp2,
                              )
                          ),
                          const SizedBox(width: 20),
                          Expanded(//width: MediaQuery.of(context).size.width*0.48,
                              child: IconDropdownPopup(
                                enablePopup: region.value == ''? false : true,
                                dropdownMsg: 'Region',
                                selected: city,
                                hintText: 'City',
                                titleList: seeAllController.cityModel.value.data == null?
                                []: seeAllController.cityModel.value.data!.cities!.map((e) => e.cityName.toString()).toList(),
                                apiList: seeAllController.cityModel.value.data == null?
                                []: seeAllController.cityModel.value.data!.cities,
                                function: (Cities cities){
                                  searchController.cityID = cities.cityId!;
                                  searchController.searchGarage.value.data = null;
                                  searchController.update();
                                  // seeAllController.getSeeAllGarageData(
                                  //     countryId: countryId,
                                  //     stateId: seeAllController.stateID,
                                  //     cityId: seeAllController.cityID);
                                  searchController.getSearchedGarageData(
                                      countryId: countryId,
                                      stateId: searchController.stateID,
                                      cityId: searchController.cityID);
                                },
                                img: ImageConst.city,)
                          ),
                        ],
                      ),
                      const Divider(height: 30),
                      searchController.searchGarage.value.data!.garages == null?
                      CircularProgressIndicator():
                      searchController.searchGarage.value.data!.garages!.isEmpty?
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child:
                            Stack(
                              children: [
                                SvgPicture.asset(ImageConst.noGarage, height: 350),
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
                        ),
                      ):
                      ListView.builder(
                          shrinkWrap: true,
                          physics:  const NeverScrollableScrollPhysics(),
                          itemCount: value.searchGarage.value.data!.garages!.length,
                          itemBuilder: (context, index){
                            return  Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: SeeAllRepairGarageList(garages: value.searchGarage.value.data!.garages![index]),
                            );
                          }
                      ),
                    ],
                  );
                  // }
                }
            )

        ),
      ),
    );
  }
}
