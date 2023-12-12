import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/item_available_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Dealer/see_all_dealer_list.dart';

import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../GlobalWidgets/icon_dropdown.dart';
import '../../Model/city_list_model.dart';
import '../../Model/register_option_model.dart';
import '../../Model/state_list_model.dart';

class SeeAllDealer extends StatefulWidget {
  SeeAllDealer({Key? key}) : super(key: key);

  @override
  State<SeeAllDealer> createState() => _SeeAllDealerState();
}

class _SeeAllDealerState extends State<SeeAllDealer> {
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController(type: 'dealer'));
  ItemAvailableController itemController = Get.put(ItemAvailableController());
  DropDownController dropController = Get.put(DropDownController());
  HomeController homeController = Get.put(HomeController());

  String countryID = Get.arguments[0];
  String stateID = Get.arguments[1];
  String cityID = Get.arguments[2];
  String businessID = Get.arguments[3];
  String flag = Get.arguments[4];

  var region = ''.obs;
  var city = ''.obs;
  var type = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    region.value = seeAllController.stateName;
    city.value = seeAllController.cityName;
    type.value = seeAllController.bTypeName;

    seeAllController.stateID = seeAllController.searchStateID;
    seeAllController.cityID = seeAllController.searchCityID;
    seeAllController.businessTypeID = seeAllController.searchedBusinessTypeID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Dealers'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        controller: seeAllController.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder(
              init: seeAllController,
              initState: (controller){
                seeAllController.getSeeAllDealerData(
                  countryId: countryID,
                  stateId: stateID,
                  cityId: cityID,
                  businessId: businessID,
                  showLoader: false
                );
                seeAllController.getStateListData(countryID: homeController.newCountryID, showLoader: false);
                seeAllController.getCountryListData();
                if(flag == 'search'){
                  seeAllController.getCityListData(stateID: stateID, showLoader: false);
                }
              },
              builder: (value){
                return seeAllController.seeAllDealer.value.data == null?
                SizedBox(height: Get.height,
                    child: PRLoader.normalLoader()):
                  Column(
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: SizedBox(width: 50,
                              child: IconDropdownPopup(
                                enablePopup: true,
                                selected: region,
                                hintText: 'Region',
                                width: 60,
                                titleList: seeAllController.stateModel.value.data == null?
                                []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                                apiList: seeAllController.stateModel.value.data == null?
                                []: seeAllController.stateModel.value.data!.states,
                                function: (States states){
                                  seeAllController.stateID = states.stateId!;
                                  city.value = '';
                                  // type.value = '';
                                  seeAllController.seeAllDealer.value.data = null;
                                  seeAllController.update();
                                  seeAllController.getCityListData(stateID: states.stateId!, showLoader: false);
                                  seeAllController.getSeeAllDealerData(
                                      countryId: homeController.newCountryID,
                                      stateId: states.stateId!,
                                      cityId: '',
                                    businessId: seeAllController.searchedBusinessTypeID,
                                    showLoader: false
                                  );
                                },
                                img: ImageConst.lp2),
                            )
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: IconDropdownPopup(
                              enablePopup: region.value == ''? false : true,
                              dropdownMsg: 'Region',
                              selected: city,
                              hintText: 'City',
                              width: 60,
                              titleList: seeAllController.cityModel.value.data == null?
                              []: seeAllController.cityModel.value.data!.cities!.map((e) => e.cityName.toString()).toList(),
                              apiList: seeAllController.cityModel.value.data == null?
                              []: seeAllController.cityModel.value.data!.cities,
                              function: (Cities cities){
                                // dropController.isValueSelected = true;
                                seeAllController.cityID = cities.cityId!;
                                // type.value = '';
                                seeAllController.seeAllDealer.value.data = null;
                                seeAllController.update();
                                seeAllController.getSeeAllDealerData(
                                  countryId: homeController.newCountryID,
                                  stateId: seeAllController.stateID,
                                  cityId: seeAllController.cityID,
                                  businessId: seeAllController.searchedBusinessTypeID,
                                  showLoader: false
                                );
                              },
                              img: ImageConst.city)
                        ),
                        const SizedBox(width: 20),
                            IconDropdownPopup(
                              enablePopup: true,
                              selected: type,
                              hintText: 'Type',
                              width: 60,
                              titleList: seeAllController.rOPModel.value.data == null?
                              []: seeAllController.rOPModel.value.data!.businessTypes!.map((e) => e.description.toString()).toList(),
                              apiList: seeAllController.rOPModel.value.data == null?
                              []: seeAllController.rOPModel.value.data!.businessTypes!,
                              function: (BusinessTypes businessType){
                                seeAllController.businessTypeID = businessType.businessTypeId!;
                                seeAllController.seeAllDealer.value.data = null;
                                seeAllController.update();
                                seeAllController.getSeeAllDealerData(
                                    countryId: homeController.newCountryID,
                                    businessId: seeAllController.businessTypeID,
                                    stateId: seeAllController.stateID,
                                    cityId: seeAllController.cityID,
                                  showLoader: false
                                );
                              },
                              img: ImageConst.type)
                      ],
                    ),
                    const Divider(height: 30),
                    seeAllController.seeAllDealer.value.data!.businesses == null?
                    CircularProgressIndicator():
                    seeAllController.seeAllDealer.value.data!.businesses!.isEmpty?
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child:
                          Stack(
                            children: [
                              SvgPicture.asset(ImageConst.noDealer, height: 350),
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
                        itemCount: value.seeAllDealer.value.data!.businesses!.length,
                        itemBuilder: (context, index){
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: SeeAllDealerList(dealers: value.seeAllDealer.value.data!.businesses![index]),
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
