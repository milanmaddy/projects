import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/item_available_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/Model/car_maker_model.dart';
import 'package:kawawa_motors/Model/car_model_model.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Spare%20Parts/see_all_spare_parts_list.dart';
import '../../Constraints/image_const.dart';
import '../../GlobalWidgets/icon_dropdown.dart';
import '../../GlobalWidgets/loader.dart';

class SeeAllSP extends StatefulWidget {
  SeeAllSP({Key? key}) : super(key: key);

  @override
  State<SeeAllSP> createState() => _SeeAllSPState();
}

class _SeeAllSPState extends State<SeeAllSP> {
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController(type: 'sp'));
  ItemAvailableController itemController = Get.put(ItemAvailableController());
  DropDownController dropController = Get.put(DropDownController());
  HomeController homeController = Get.put(HomeController());
  CarDropDownModel carMakerModel = CarDropDownModel();

  // CarMakers? carMakers;
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
    return Scaffold(
      appBar: CustomAppBar(title: 'Spare Parts'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        controller: seeAllController.scrollController,
        physics: const BouncingScrollPhysics(),
        child: GetBuilder(
          init: seeAllController,
          initState: (controller){
            seeAllController.getCarDropDownData(showLoader: false);
            seeAllController.getSeeAllSparePartsData(
              countryID: countryID,
              // itemController.itemModel.value.data!.countries![1].countryId!,
              // '13414701-f899-41cd-815b-093e21ceffed',
              carModelID: carModelID,
              carMakerID: carMakerID,
              subCategoryID: seeAllController.spSubCategoryID,
              conditionID: seeAllController.conditionID,
              categoryID: seeAllController.spCategoryID,
              sellerTypeID: seeAllController.sellerTypeID,
              stateID: seeAllController.stateID,
              cityID: seeAllController.cityID,
              showLoader: false,
              userID: ''
            );
            if(flag == 'search'){
              seeAllController.getCarModelData(carMakerID: carMakerID, showLoader: false);
            }
          },
          builder: (value){
            return seeAllController.seeAllSparePart.value.data == null?
            SizedBox(height: Get.height,
                child: PRLoader.normalLoader()):
              Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: IconDropdownPopup(
                            enablePopup: true,
                            selected: make,
                            hintText: 'Make',
                            img: ImageConst.type,
                            titleList: seeAllController.carDropdownModel.value.data == null?
                                []: seeAllController.carDropdownModel.value.data!.carMakers!.map((e) => e.title.toString()).toList(),
                            apiList: seeAllController.carDropdownModel.value.data == null?
                                []: seeAllController.carDropdownModel.value.data!.carMakers,
                            function: (CarMakers carMakers){
                              seeAllController.carMakerID = carMakers.carMakerId!;
                              model.value = '';
                              seeAllController.seeAllSparePart.value.data = null;
                              seeAllController.update();
                              seeAllController.getCarModelData(carMakerID: carMakers.carMakerId!, showLoader: false);
                              seeAllController.getSeeAllSparePartsData(
                                countryID: homeController.newCountryID,
                                carMakerID: carMakers.carMakerId!,
                                carModelID: '',
                                subCategoryID: seeAllController.spSubCategoryID,
                                conditionID: seeAllController.conditionID,
                                categoryID: seeAllController.spCategoryID,
                                sellerTypeID: seeAllController.sellerTypeID,
                                stateID: seeAllController.stateID,
                                cityID: seeAllController.cityID,
                                showLoader: false,
                                userID: ''
                              );
                            }
                          )
                      ),
                      const SizedBox(width: 20),
                      Expanded(//width: MediaQuery.of(context).size.width*0.48,
                          child: IconDropdownPopup(
                            enablePopup: make.value == ''? false : true,
                              dropdownMsg: 'Make',
                              selected: model,
                              hintText: 'Model',
                              img: ImageConst.city,
                              titleList: seeAllController.carModelModel.value.data == null?
                                  []: seeAllController.carModelModel.value.data!.carModels!.map((e) => e.title.toString()).toList(),
                            apiList: seeAllController.carModelModel.value.data == null?
                            []: seeAllController.carModelModel.value.data!.carModels,
                            function: (CarModels carModel){
                              seeAllController.seeAllSparePart.value.data = null;
                                seeAllController.update();
                                seeAllController.getSeeAllSparePartsData(
                                    countryID: homeController.newCountryID,
                                    carMakerID: seeAllController.carMakerID,
                                    carModelID: carModel.carModelId!,
                                    subCategoryID: seeAllController.spSubCategoryID,
                                    conditionID: seeAllController.conditionID,
                                    categoryID: seeAllController.spCategoryID,
                                    sellerTypeID: seeAllController.sellerTypeID,
                                    stateID: seeAllController.stateID,
                                    cityID: seeAllController.cityID,
                                    showLoader: false,
                                  userID: ''
                                );
                            },
                            // selectedID: itemController.itemModel.value.data!.countries!.map((e) => e.countryId).toList()
                          )
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  seeAllController.seeAllSparePart.value.data!.spareParts!.isEmpty?
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child:
                        Stack(
                          children: [
                            SvgPicture.asset(ImageConst.noSP, height: 350),
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
                      itemCount: value.seeAllSparePart.value.data!.spareParts!.length,
                      itemBuilder: (context, index){
                        return  Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: SeeAllSPList(spareParts: value.seeAllSparePart.value.data!.spareParts![index],),
                        );
                      }
                  ),
                ],
              ),
            );
          },
        )


      ),
    );
  }
}
