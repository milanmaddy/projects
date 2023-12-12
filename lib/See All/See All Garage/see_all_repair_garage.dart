import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/search_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Garage/see_all_repair_garage_list.dart';

import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../Controller/home_controller.dart';
import '../../Controller/item_available_controller.dart';
import '../../GlobalWidgets/icon_dropdown.dart';
import '../../GlobalWidgets/loader.dart';
import '../../Model/city_list_model.dart';
import '../../Model/state_list_model.dart';

class SeeAllRepairGarage extends StatefulWidget {
  SeeAllRepairGarage({Key? key}) : super(key: key);

  @override
  State<SeeAllRepairGarage> createState() => _SeeAllRepairGarageState();
}

class _SeeAllRepairGarageState extends State<SeeAllRepairGarage> {
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController(type: 'garage'));
  SearchDataController searchController = Get.put(SearchDataController());
  HomeController homeController = Get.put(HomeController());

  String countryID = Get.arguments[0];
  String stateID = Get.arguments[1];
  String cityID = Get.arguments[2];
  String flag = Get.arguments[3];

  // String navigationFrom = Get.arguments[3];
  var region = ''.obs;
  var city = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    region.value = seeAllController.stateName;
    city.value = seeAllController.cityName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Garage'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        controller: seeAllController.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder(
            init: seeAllController,
              initState: (controller){
                seeAllController.getSeeAllGarageData(
                    countryId: countryID,
                    cityId: cityID,
                    stateId: stateID,
                  showLoader: false,
                  userID: ''
                );
                seeAllController.getStateListData(countryID: countryID, showLoader: false);
                if(flag == 'search'){
                  seeAllController.getCityListData(stateID: stateID, showLoader: false);
                }
              // }
              },
              builder: (value){
                return seeAllController.seeAllGarage.value.data == null?
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
                                seeAllController.stateID = states.stateId!;
                                city.value = '';
                                seeAllController.seeAllGarage.value.data = null;
                                seeAllController.update();
                                seeAllController.getCityListData(stateID: states.stateId!, showLoader: false);
                                seeAllController.getSeeAllGarageData(
                                    countryId: homeController.newCountryID,
                                    stateId: states.stateId!,
                                    userID: '',
                                    cityId: '',
                                  showLoader: false
                                );
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
                                seeAllController.cityID = cities.cityId!;
                                seeAllController.seeAllGarage.value.data = null;
                                seeAllController.update();
                                seeAllController.getSeeAllGarageData(
                                    countryId: homeController.newCountryID,
                                    stateId: seeAllController.stateID,
                                    cityId: seeAllController.cityID,
                                  userID: '',
                                  showLoader: false
                                );
                              },
                              img: ImageConst.city,)
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    seeAllController.seeAllGarage.value.data!.garages == null?
                    CircularProgressIndicator():
                    seeAllController.seeAllGarage.value.data!.garages!.isEmpty?
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
                        // Text('No Data Found', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: ColorConst.label),),
                      ),
                    ):
                    ListView.builder(
                        shrinkWrap: true,
                        physics:  const NeverScrollableScrollPhysics(),
                        itemCount: value.seeAllGarage.value.data!.garages!.length,
                        itemBuilder: (context, index){
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: SeeAllRepairGarageList(garages: value.seeAllGarage.value.data!.garages![index]),
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
