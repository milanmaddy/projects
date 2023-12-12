import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../Controller/home_controller.dart';
import '../../Controller/see_all_controller.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/dropdown.dart';
import '../../GlobalWidgets/dropdown_popup.dart';
import '../../GlobalWidgets/loader.dart';
import '../../Model/car_maker_model.dart';
import '../../Model/car_model_model.dart';

class SearchSpareParts extends StatelessWidget {
  SearchSpareParts({Key? key}) : super(key: key);

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  HomeController homeController = Get.put(HomeController());

  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    seeAllController.searchedCarMakerName = '';
    seeAllController.searchedCarMakerID = '';
    seeAllController.searchedCarModelName = '';
    seeAllController.searchedCarModelID = '';
    makeController.clear();
    modelController.clear();
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
                    Text('Find Spare Parts', style: AppTextStyle.black18_600),
                    const SizedBox(height: 20),
                    CustomDropDownnn(
                      labelText: 'Make',
                      controller: makeController,
                      titleList: seeAllController.carDropdownModel.value.data!.carMakers!.map((e) => e.title.toString()).toList(),
                      objectList: seeAllController.carDropdownModel.value.data!.carMakers,
                      function: (CarMakers carMakers){
                        modelController.clear();
                        seeAllController.searchedCarModelID = '';
                        seeAllController.searchedCarModelName = '';
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
                          seeAllController.carMakerName = '';
                          seeAllController.carMakerID = '';
                          seeAllController.carModelName = '';
                          seeAllController.carModelID = '';
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
                          seeAllController.searchedCarMakerName = '';
                          seeAllController.searchedCarMakerID = '';
                          seeAllController.searchedCarModelName = '';
                          seeAllController.searchedCarModelID = '';
                          Get.toNamed(AppRoute.searchSP);
                          },
                            child: Text('More Filters', style: AppTextStyle.label2))
                      ],
                    ),
                    const SizedBox(height: 25),
                    Center(child: SizedBox(width: 265,
                        child: Buttons.filterBtn(title: 'SEARCH PARTS', icon: ImageConst.glass, event: (){
                          seeAllController.getSeeAllSparePartsData(
                              countryID: homeController.newCountryID,
                              carMakerID: seeAllController.searchedCarMakerID,
                              carModelID: seeAllController.searchedCarModelID,
                              cityID: '',
                              stateID: '',
                              sellerTypeID: '',
                              categoryID: '',
                              conditionID: '',
                              subCategoryID: '',
                              userID: '',
                              navigation: true
                          );
                        })))
                  ],
                );
              }
          )

    );
  }
}
