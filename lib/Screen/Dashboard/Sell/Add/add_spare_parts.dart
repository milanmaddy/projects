import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/Controller/sp_controller.dart';
import 'package:kawawa_motors/Controller/update_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field_2.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';
import '../../../../Constraints/image_const.dart';
import 'package:get/get.dart';
import '../../../../Constraints/text_style.dart';
import '../../../../GlobalWidgets/buttons.dart';
import '../../../../GlobalWidgets/dropdown_popup.dart';
import '../../../../GlobalWidgets/loader.dart';
import '../../../../Model/car_model_model.dart';
import '../../../../Model/city_list_model.dart';
import '../../../../Model/sp_dropdown_model.dart';
import '../../../../Model/sp_sub_category_model.dart';
import '../../../../Model/state_list_model.dart';
import '../../../Authentication/validation.dart';
import '../../../PopUp/upload_image.dart';

class AddSpareParts extends StatelessWidget {
  AddSpareParts({Key? key}) : super(key: key);

  var multipleImage = false.obs;
  String navigationFrom = Get.arguments;
  final formKey = GlobalKey<FormState>();

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  AddController addController = Get.put(AddController());
  SparePartsController spController = Get.put(SparePartsController());
  UpdateController updateController = Get.put(UpdateController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.back,
      appBar: CustomAppBar(title: navigationFrom == 'add'? 'Add Spare Parts':'Update Spare Parts'),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: seeAllController,
          initState: (controller){
            seeAllController.getSparePartsDropDownData(showLoader: false);
            seeAllController.getCountryListData();
            // seeAllController.getCarDropDownData(showLoader: false);
            if(navigationFrom != 'add'){
              spController.getSPDetailsData(spId: navigationFrom);
              seeAllController.getCarModelData(carMakerID: addController.carMakerID, showLoader: false);
            }
          },
          builder: (value){
                if(seeAllController.spDropdownModel.value.data == null){
                  return SizedBox(
                    height: Get.height,
                    child: PRLoader.normalLoader(),
                  );
                }else if(navigationFrom != 'add'){
                  if(spController.spModel.value.data == null){
                    return SizedBox(
                      height: Get.height,
                      child: PRLoader.normalLoader(),
                    );
                  }else{}
                }
                return Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).copyWith(bottom: 30),
                      width: MediaQuery.of(context).size.width,
                      // height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: const Offset(2,2)
                            )
                          ]
                      ),
                      child: GetBuilder(
                        init: addController,
                            builder: (value){
                              return Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(bottom: 10, right: 10),
                                              child: navigationFrom == 'add'?
                                              addController.uploadedPicture.value == ''?
                                              Container(height: 90, width: 105,
                                                  padding: const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: const Color(0xFFF1F1F1)
                                                  ),
                                                  child: SvgPicture.asset(ImageConst.upload)):
                                              Container(height: 90, width: 105,
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: const Color(0xFFF1F1F1),
                                                    image: DecorationImage(image: FileImage(File(addController.uploadedPicture.value)),
                                                        fit: BoxFit.cover)
                                                ),
                                                // child: SvgPicture.asset(ImageConst.upload)
                                              ):
                                              addController.uploadedPicture.value == spController.spModel.value.data!.sparePart!.sparePartPrimaryImageUrl?
                                              Container(height: 90, width: 105,
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: const Color(0xFFF1F1F1),
                                                    image: DecorationImage(image: NetworkImage(addController.uploadedPicture.value), fit: BoxFit.cover)
                                                ),
                                              ):
                                              Container(height: 90, width: 105,
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: const Color(0xFFF1F1F1),
                                                    image: DecorationImage(image: FileImage(File(addController.uploadedPicture.value)),
                                                        fit: BoxFit.cover)
                                                ),
                                                // child: SvgPicture.asset(ImageConst.upload)
                                              )
                                          ),
                                          Positioned(bottom: 1, right: 1,
                                            child: GestureDetector(onTap: (){Get.bottomSheet(UploadImage(uploadFrom: 'addVehicle',));},
                                              child: Container(padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey.shade400,
                                                          spreadRadius: 0.1,
                                                          blurRadius: 1,
                                                          offset: const Offset(0, 2)
                                                      )
                                                    ]
                                                ),
                                                child: SvgPicture.asset(ImageConst.cam, height: 17),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 5),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Spare Part Image', style: AppTextStyle.label2),
                                          const SizedBox(height: 5),
                                          Text('uploading more photos Increases\nyour chance of closing a deal', style: AppTextStyle.grid),
                                          addController.uploadedPicture.value == ''?
                                          const SizedBox():
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: GestureDetector(onTap: (){multipleImage.value = true;},
                                              child: Row(
                                                children: [
                                                  navigationFrom != 'add'?
                                                  Text('See More', style: AppTextStyle.addMore):
                                                  Text('Add More', style: AppTextStyle.addMore),
                                                  const SizedBox(width: 10),
                                                  Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 13)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  multipleImage.value == true?
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Wrap(
                                          children: [
                                            ...addController.selectedImages.map((e) {
                                              return Padding(
                                                padding: const EdgeInsets.only(right: 10, top: 10),
                                                child: Stack(
                                                  children: [
                                                    navigationFrom == 'add'?
                                                    Container(height: 90, width: 105,
                                                      padding: const EdgeInsets.all(15),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: const Color(0xFFF1F1F1),
                                                          image: DecorationImage(image: FileImage(File(e.imageUrl!)), fit: BoxFit.cover)
                                                      ),
                                                      // child: SvgPicture.asset(ImageConst.upload)
                                                    ):
                                                    Container(height: 90, width: 105,
                                                      padding: const EdgeInsets.all(15),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: const Color(0xFFF1F1F1),
                                                          image: e.imageUrl!.substring(0, 4) == 'http'?
                                                          DecorationImage(image: NetworkImage(e.imageUrl!), fit: BoxFit.cover):
                                                          DecorationImage(image: FileImage(File(e.imageUrl!)), fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                    Positioned(top: 5, right: 5,
                                                      child: GestureDetector(onTap: (){
                                                        if(navigationFrom == 'add'){
                                                          addController.selectedImages.remove(e);
                                                          addController.update();
                                                        }else{
                                                          print('object');
                                                          if(e.imageUrl!.substring(0, 4) == 'http'){
                                                            ///kkkkkkkkk///
                                                            spController.deleteSPImage(spImgID: e.imageID!);
                                                          }else{
                                                            addController.selectedImages.remove(e);
                                                            addController.update();
                                                          }
                                                        }
                                                      },
                                                        child: Container(padding: const EdgeInsets.all(4),
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              shape: BoxShape.circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.grey.shade400,
                                                                    spreadRadius: 0.1,
                                                                    blurRadius: 1,
                                                                    offset: const Offset(0, 2)
                                                                )
                                                              ]
                                                          ),
                                                          child: SvgPicture.asset(ImageConst.cross, height: 15, color: ColorConst.label),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            GestureDetector(onTap: (){Get.bottomSheet(UploadImage(uploadFrom: 'addVehicle2',));},
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Container(height: 90, width: 105,
                                                    padding: const EdgeInsets.all(15),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: const Color(0xFFF1F1F1)
                                                    ),
                                                    child: SvgPicture.asset(ImageConst.upload)),
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  ):
                                  const SizedBox(),
                                ],
                              ),);
                            }
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(20).copyWith(top: 40),
                      child: Form(
                        key: formKey,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDropDownnn(
                                labelText: 'Make*',
                                controller: spController.makeController,
                                titleList: seeAllController.spDropdownModel.value.data!.carMakers!.map((e) => e.title.toString()).toList(),
                                objectList: seeAllController.spDropdownModel.value.data!.carMakers,
                                function: (CarMakersSP carMakers){
                                  spController.modelController.clear();
                                  addController.carMakerID = carMakers.carMakerId!;
                                  seeAllController.update();
                                  addController.update();
                                  seeAllController.getCarModelData(carMakerID: addController.carMakerID);
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              const SizedBox(height: 17),
                              CustomDropDownnn(
                                enablePopup: spController.makeController.text == ''? false : true,
                                dropdownMsg: 'Make',
                                labelText: 'Model*',
                                controller: spController.modelController,
                                titleList: seeAllController.carModelModel.value.data == null?
                                []: seeAllController.carModelModel.value.data!.carModels!.map((e) => e.title.toString()).toList(),
                                objectList: seeAllController.carModelModel.value.data == null?
                                []: seeAllController.carModelModel.value.data!.carModels,
                                function: (CarModels carModels){
                                  addController.carModelID = carModels.carModelId!;
                                  seeAllController.update();
                                  addController.update();
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              const SizedBox(height: 17),
                              CustomDropDownnn(
                                labelText: 'Condition*',
                                controller: spController.conditionController,
                                titleList: seeAllController.spDropdownModel.value.data!.carConditions!.map((e) => e.title.toString()).toList(),
                                objectList: seeAllController.spDropdownModel.value.data!.carConditions,
                                function: (CarConditionsSP carConditions){
                                  addController.conditionID = carConditions.carConditionId!;
                                  seeAllController.update();
                                  addController.update();
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),

                              const Padding(padding: EdgeInsets.symmetric(vertical: 25),
                                  child: Text('Address', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                              ),
                              CustomDropDownnn(
                                labelText: 'Country*',
                                controller: spController.countryController,
                                titleList: seeAllController.spDropdownModel.value.data == null?
                                []: seeAllController.spDropdownModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                                objectList: seeAllController.spDropdownModel.value.data == null?
                                []: seeAllController.spDropdownModel.value.data!.countries,
                                function: (CountriesSP countries){
                                  spController.regionController.clear();
                                  spController.cityController.clear();
                                  spController.currencyController.text = countries.currencySymbol!;
                                  addController.countryID = countries.countryId!;
                                  seeAllController.update();
                                  addController.update();
                                  seeAllController.getStateListData(countryID: addController.countryID);
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              const SizedBox(height: 17),
                              CustomDropDownnn(
                                enablePopup: spController.countryController.text == ''? false : true,
                                dropdownMsg: 'Country',
                                labelText: 'Region*',
                                controller: spController.regionController,
                                titleList: seeAllController.stateModel.value.data == null?
                                []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                                objectList: seeAllController.stateModel.value.data == null?
                                []: seeAllController.stateModel.value.data!.states,
                                function: (States states){
                                  spController.cityController.clear();
                                  print('ggg');
                                  print(states.stateName);
                                  addController.stateID = states.stateId!;
                                  seeAllController.update();
                                  addController.update();
                                  seeAllController.getCityListData(stateID: addController.stateID);
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              const SizedBox(height: 17),
                              CustomDropDownnn(
                                enablePopup: spController.regionController.text == ''? false : true,
                                dropdownMsg: spController.countryController.text == '' && spController.regionController.text == ''?
                                'Country & Region':
                                spController.regionController.text == ''?
                                'Region': '',
                                labelText: 'City*',
                                controller: spController.cityController,
                                titleList: seeAllController.cityModel.value.data == null?
                                []: seeAllController.cityModel.value.data!.cities!.map((e) => e.cityName.toString()).toList(),
                                objectList: seeAllController.cityModel.value.data == null?
                                []: seeAllController.cityModel.value.data!.cities!,
                                function: (Cities cities){
                                  addController.cityID = cities.cityId!;
                                  seeAllController.update();
                                  addController.update();
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 25),
                                  child: Text('Detail', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                              ),
                              CustomInputField2(controller: spController.dateController, labelText: 'Manufacture Year*', suffixIcon: ImageConst.calender, labelBackColor: ColorConst.back, readOnly: true, hint: 'Select Manufacture Year',
                                event: ()async{
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now()
                                  );

                                  if(pickedDate != null){
                                    print(pickedDate);

                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    spController.dateController.text = formattedDate;
                                  }else{}
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              const SizedBox(height: 17),
                              CustomDropDownnn(
                                labelText: 'Category*',
                                controller: spController.categoryController,
                                titleList: seeAllController.spDropdownModel.value.data!.sparePartCategory!.map((e) => e.title.toString()).toList(),
                                objectList: seeAllController.spDropdownModel.value.data!.sparePartCategory,
                                function: (SparePartCategory category){
                                  spController.subCategoryController.clear();
                                  addController.spCategoryID = category.sparePartCategoryId!;
                                  seeAllController.update();
                                  addController.update();
                                  seeAllController.getSPSubCategoryListData(categoryId: addController.spCategoryID);
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              // DropdownPopup(listItems: listItems, labelText: 'Category', labelBackColor: ColorConst.back, hintText: 'Select Spare Category', selected: category),
                              const SizedBox(height: 17),
                              CustomDropDownnn(
                                enablePopup: spController.categoryController.text == ''? false : true,
                                dropdownMsg: 'Category',
                                labelText: 'Subcategory*',
                                controller: spController.subCategoryController,
                                titleList: seeAllController.spSubCategoryModel.value.data == null?
                                []: seeAllController.spSubCategoryModel.value.data!.sparePartSubCategories!.map((e) => e.title.toString()).toList(),
                                objectList: seeAllController.spSubCategoryModel.value.data == null?
                                []: seeAllController.spSubCategoryModel.value.data!.sparePartSubCategories,
                                function: (SparePartSubCategories subCategories){
                                  addController.spSubCategoryID = subCategories.sparePartSubCategoryId!;
                                  seeAllController.update();
                                  addController.update();
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              // DropdownPopup(listItems: listItems, labelText: 'Subcategory', labelBackColor: ColorConst.back, hintText: 'Select Subcategory', selected: subcategory),
                              const SizedBox(height: 17),
                              CustomInputField2(controller: spController.titleController, labelText: 'Title', maxLine: 2, labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))]),
                              const SizedBox(height: 17),
                              CustomInputField2(controller: spController.descController, labelText: 'Description', maxLine: 2, labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))]),
                              const SizedBox(height: 17),
                              CustomDropDownnn(
                                labelText: 'Currency',
                                controller: spController.currencyController,
                                titleList: seeAllController.rOPModel.value.data == null?
                                []: seeAllController.rOPModel.value.data!.countries!.map((e) => e.currencySymbol.toString()).toList(),
                                objectList: seeAllController.rOPModel.value.data == null?
                                []: seeAllController.rOPModel.value.data!.countries!,
                                function: (Countries currency){
                                  addController.currencyID = currency.currencySymbol!;
                                  print(currency.currencySymbol);
                                  seeAllController.update();
                                  addController.update();
                                },
                                validation: (make) => Validation.normalValidation(make),
                              ),
                              // DropdownPopup(listItems: listItems, labelText: 'Currency', labelBackColor: ColorConst.back, hintText: 'Select Currency', selected: currency,),
                              const SizedBox(height: 17),
                              CustomInputField2(controller: spController.priceController, prefixIcon: '', labelText: 'Price*', labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))], type: TextInputType.number, validation: (make) => Validation.normalValidation(make),),
                              // DropdownPopup(listItems: listItems, labelText: 'Price', labelBackColor: ColorConst.back, hintText: 'Amount', selected: price),
                              const SizedBox(height: 50),
                              Center(child: navigationFrom == 'add'?
                              Buttons.actionButtons(title: 'ADD', event: (){
                                if(formKey.currentState!.validate()){
                                  addController.addSparePartsData(
                                      sparePartPrimaryImage: addController.uploadedPicture.value,
                                      sparePartImages: addController.selectedImages,
                                      carMakerId: addController.carMakerID,
                                      carModelId: addController.carModelID,
                                      carConditionId: addController.conditionID,
                                      countryId: addController.countryID,
                                      stateId: addController.stateID,
                                      cityId: addController.cityID,
                                      manufacturingYear: spController.dateController.text,
                                      spCategoryId: addController.spCategoryID,
                                      spSubCategoryId: addController.spSubCategoryID,
                                      title: spController.titleController.text,
                                      description: spController.descController.text,
                                      currency: spController.currencyController.text,
                                      price: spController.priceController.text
                                  );
                                }
                              }):
                              Buttons.actionButtons(title: 'UPDATE', event: (){
                                if(formKey.currentState!.validate()){
                                  updateController.updateSparePartsData(
                                      spID: navigationFrom,
                                      sparePartPrimaryImage: addController.uploadedPicture.value,
                                      sparePartImages: addController.selectedImages,
                                      carMakerId: addController.carMakerID,
                                      carModelId: addController.carModelID,
                                      carConditionId: addController.conditionID,
                                      countryId: addController.countryID,
                                      stateId: addController.stateID,
                                      cityId: addController.cityID,
                                      manufacturingYear: spController.dateController.text,
                                      spCategoryId: addController.spCategoryID,
                                      spSubCategoryId: addController.spSubCategoryID,
                                      title: spController.titleController.text,
                                      description: spController.descController.text,
                                      currency: spController.currencyController.text,
                                      price: spController.priceController.text
                                  );
                                }
                              })
                              )
                            ],
                          ),
                      )

                    )
                  ],
                );
          },
        )
      ),
    );
  }
}
