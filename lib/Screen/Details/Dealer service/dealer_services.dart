import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Garage/see_all_repair_garage_list.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Spare%20Parts/see_all_spare_parts_list.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Vehicle/see_all_vehicle_list.dart';

import '../../../Constraints/image_const.dart';
import '../../../GlobalWidgets/app_bar.dart';
import '../../../GlobalWidgets/icon_dropdown.dart';

class DealerServices extends StatelessWidget {
  DealerServices({Key? key}) : super(key: key);

  String header = Get.arguments[0];
  String userID = Get.arguments[1];
  var serviceType = ''.obs;
  String sType = 'vehicle';

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());

  @override
  Widget build(BuildContext context) {
    print('user id is: $userID');
    return Scaffold(
      appBar: CustomAppBar(title: '$header Services'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: GetBuilder(
            init: seeAllController,
              initState: (controller){
              seeAllController.getSeeAllVehicleData(
                  carMakerID: '',
                  carModelID: '',
                  vehicleTypeID: '',
                  sellerTypeID: '',
                  countryID: '',
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
                  userId: userID,
                showLoader: false
              );
              seeAllController.getSeeAllSparePartsData(sellerTypeID: '', countryID: '', carMakerID: '', carModelID: '', stateID: '', cityID: '', conditionID: '', categoryID: '', subCategoryID: '', userID: userID, showLoader: false);
              seeAllController.getSeeAllGarageData(countryId: '', stateId: '', cityId: '', userID: userID, showLoader: false);
              },
              builder: (value){
                return seeAllController.seeAllVehicle.value.data == null?
                    SizedBox(
                      height: Get.height,
                      child: PRLoader.normalLoader(),
                    ):
                Column(
                  children: [
                    IconDropdownPopup(
                        enablePopup: true,
                        selected: serviceType,
                        titleList: ['Vehicles', 'Spare Parts', 'Garages'],
                        apiList: ['vehicle', 'spare-part', 'garage'],
                        function: (type){
                          sType = type;
                          print(sType);
                          print(serviceType);
                          if(sType == 'vehicle'){
                            seeAllController.getSeeAllVehicleData(carMakerID: '', carModelID: '', vehicleTypeID: '', sellerTypeID: '', countryID: '', stateID: '', cityID: '', carConditionID: '', carFuelTypeID: '', carGearBoxID: '', carColorID: '', carEngineSizeID: '', minMileage: '', maxMileage: '', minPrice: '', maxPrice: '', userId: userID);
                          }
                          if(sType == 'spare-part'){
                            seeAllController.getSeeAllSparePartsData(sellerTypeID: '', countryID: '', carMakerID: '', carModelID: '', stateID: '', cityID: '', conditionID: '', categoryID: '', subCategoryID: '', userID: userID);
                          }
                          if(sType == 'garage'){
                            seeAllController.getSeeAllGarageData(countryId: '', stateId: '', cityId: '', userID: userID);
                          }
                          // broadcastController.getBroadcastListData(type: bType);
                        },
                        hintText: 'SERVICE TYPE',
                        img: ImageConst.city),
                    const Divider(height: 30),
                    const SizedBox(height: 10),
                    // seeAllController.seeAllVehicle.value.data!.vehicles!.isEmpty?
                    // Center(
                    //   child: Padding(
                    //       padding: const EdgeInsets.only(top: 50),
                    //       child:
                    //       Stack(
                    //         children: [
                    //           SvgPicture.asset(ImageConst.noVehicle, height: 350),
                    //           const Positioned(right: 0, left: 0, bottom: 25,
                    //             child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
                    //                 SizedBox(height: 5),
                    //                 Text("I can't find what you are looking", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //   ),
                    // ):
                    ListView.builder(
                        shrinkWrap: true,
                        physics:  const NeverScrollableScrollPhysics(),
                        // controller: broadcastController.scrollController,
                        itemCount: sType == 'spare-part'?
                            seeAllController.seeAllSparePart.value.data!.spareParts!.length:
                        sType == 'garage'?
                          seeAllController.seeAllGarage.value.data!.garages!.length:
                          seeAllController.seeAllVehicle.value.data!.vehicles!.length,
                        itemBuilder: (context, index){
                          if(sType == 'vehicle'){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: SeeAllVehicleList(vehicles: seeAllController.seeAllVehicle.value.data!.vehicles![index],),
                            );
                          }
                          if(sType == 'spare-part'){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: SeeAllSPList(spareParts: seeAllController.seeAllSparePart.value.data!.spareParts![index]),
                            );
                          }
                          if(sType == 'garage'){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: SeeAllRepairGarageList(garages: seeAllController.seeAllGarage.value.data!.garages![index]),
                            );
                          }
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
