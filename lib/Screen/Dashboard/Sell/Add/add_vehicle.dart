import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/Controller/update_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field_2.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';
import 'package:kawawa_motors/Screen/PopUp/upload_image.dart';
import '../../../../Constraints/color_const.dart';
import '../../../../GlobalWidgets/dropdown_popup.dart';
import '../../../../Model/car_maker_model.dart';
import '../../../../Model/car_model_model.dart';
import '../../../../Model/city_list_model.dart';
import '../../../../Model/state_list_model.dart';
import '../../../Authentication/validation.dart';

class AddVehicle extends StatelessWidget {
  AddVehicle({Key? key}) : super(key: key);

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  AddController addController = Get.put(AddController());
  UpdateController updateController = Get.put(UpdateController());
  VehicleController vehicleController = Get.put(VehicleController());

  var multipleImage = false.obs;
  String navigationFrom = Get.arguments;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.back,
      appBar: CustomAppBar(title: navigationFrom == 'add'? 'Add Vehicle':'Update Vehicle'),
      body: SingleChildScrollView(
        child:GetBuilder(
          init: seeAllController,
          initState: (controller){
            seeAllController.getCarDropDownData(showLoader: false);
            seeAllController.getCountryListData();
            if(navigationFrom != 'add'){
              vehicleController.getVehicleDetailsData(vid: navigationFrom);
              seeAllController.getCarModelData(carMakerID: addController.carMakerID, showLoader: false);
            }
          },
          builder: (value){
            if(seeAllController.carDropdownModel.value.data == null){
              return SizedBox(
                height: Get.height,
                child: PRLoader.normalLoader(),
              );
            }else if(navigationFrom != 'add'){
              if(vehicleController.vehicleModel.value.data == null){
                return SizedBox(
                  height: Get.height,
                  child: PRLoader.normalLoader(),
                );
              }else {}
            }
            return Column(
              children: [
                GetBuilder(
                  init: addController,
                    builder: (value){
                      return Obx(() => Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).copyWith(bottom: 30),
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
                        child:
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                                        addController.uploadedPicture.value == vehicleController.vehicleModel.value.data!.vehicle!.vehiclePrimaryImageUrl!?
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
                                    Text('Vehicle Image', style: AppTextStyle.label2),
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
                                                          vehicleController.deleteVehicleImage(
                                                              vehicleImgID: e.imageID!);
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
                        ),
                      ),);
                    }
                ),
                Padding(
                  padding: const EdgeInsets.all(20).copyWith(top: 40, bottom: 40),
                  child: Form(
                    key: formKey,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropDownnn(
                            labelText: 'Make*',
                            controller: vehicleController.makeController,
                            titleList: seeAllController.carDropdownModel.value.data!.carMakers!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carDropdownModel.value.data!.carMakers,
                            function: (CarMakers carMakers){
                              vehicleController.modelController.clear();
                              addController.carMakerID = carMakers.carMakerId!;
                              print(carMakers.carMakerId);
                              seeAllController.update();
                              addController.update();
                              seeAllController.getCarModelData(carMakerID: addController.carMakerID);
                            },
                            validation: (make) => Validation.normalValidation(make),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            enablePopup: vehicleController.makeController.text == ''? false : true,
                            dropdownMsg: 'Make',
                            labelText: 'Model*',
                            controller: vehicleController.modelController,
                            titleList: seeAllController.carModelModel.value.data == null?
                            []: seeAllController.carModelModel.value.data!.carModels!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carModelModel.value.data == null?
                            []: seeAllController.carModelModel.value.data!.carModels,
                            function: (CarModels carModels){
                              addController.carModelID = carModels.carModelId!;
                              print(carModels.carModelId);
                              seeAllController.update();
                              addController.update();
                            },
                            validation: (model) => Validation.normalValidation(model),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            labelText: 'Vehicle Type*',
                            controller: vehicleController.vTypeController,
                            titleList: seeAllController.carDropdownModel.value.data!.carTypes!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carDropdownModel.value.data!.carTypes,
                            function: (CarTypes carTypes){
                              addController.vehicleTypeID = carTypes.carTypeId!;
                              print(carTypes.carTypeId);
                              seeAllController.update();
                              addController.update();
                            },
                            validation: (vType) => Validation.normalValidation(vType),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            labelText: 'Condition*',
                            controller: vehicleController.conditionController,
                            titleList: seeAllController.carDropdownModel.value.data!.carConditions!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carDropdownModel.value.data!.carConditions,
                            function: (CarConditions carConditions){
                              addController.conditionID = carConditions.carConditionId!;
                              print(carConditions.carConditionId);
                              seeAllController.update();
                              addController.update();
                            },
                            validation: (condition) => Validation.normalValidation(condition),
                          ),
                          // DropdownPopup(listItems: listItems, labelText: 'Condition*', labelBackColor: ColorConst.back, hintText: 'Select Condition', selected: condition),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 25),
                              child: Text('Address', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                          ),
                          CustomDropDownnn(
                            labelText: 'Country*',
                            controller: vehicleController.countryController,
                            titleList: seeAllController.rOPModel.value.data == null?
                            []: seeAllController.rOPModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                            objectList: seeAllController.rOPModel.value.data == null?
                            []: seeAllController.rOPModel.value.data!.countries,
                            function: (Countries countries){
                              vehicleController.regionController.clear();
                              vehicleController.cityController.clear();
                              vehicleController.currencyController.text = countries.currencySymbol!;
                              addController.countryID = countries.countryId!;
                              print(countries.countryId);
                              seeAllController.update();
                              addController.update();
                              seeAllController.getStateListData(countryID: addController.countryID);
                            },
                            validation: (country) => Validation.normalValidation(country),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            enablePopup: vehicleController.countryController.text == ''? false : true,
                            dropdownMsg: 'Country',
                            labelText: 'Region*',
                            controller: vehicleController.regionController,
                            titleList: seeAllController.stateModel.value.data == null?
                            []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                            objectList: seeAllController.stateModel.value.data == null?
                            []: seeAllController.stateModel.value.data!.states,
                            function: (States states){
                              vehicleController.cityController.clear();
                              print('ggg');
                              print(states.stateName);
                              addController.stateID = states.stateId!;
                              print(states.stateId);
                              seeAllController.update();
                              addController.update();
                              seeAllController.getCityListData(stateID: addController.stateID);
                            },
                            validation: (state) => Validation.normalValidation(state),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            enablePopup: vehicleController.regionController.text == ''? false : true,
                            dropdownMsg: vehicleController.countryController.text == '' && vehicleController.regionController.text == ''?
                            'Country & Region':
                            vehicleController.regionController.text == ''?
                            'Region': '',
                            labelText: 'City*',
                            controller: vehicleController.cityController,
                            titleList: seeAllController.cityModel.value.data == null?
                            []: seeAllController.cityModel.value.data!.cities!.map((e) => e.cityName.toString()).toList(),
                            objectList: seeAllController.cityModel.value.data == null?
                            []: seeAllController.cityModel.value.data!.cities!,
                            function: (Cities cities){
                              addController.cityID = cities.cityId!;
                              print(cities.cityId);
                              seeAllController.update();
                              addController.update();
                            },
                            validation: (city) => Validation.normalValidation(city),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 25),
                              child: Text('Details', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                          ),
                          CustomInputField2(controller: vehicleController.dateController, labelText: 'Manufacture Year*', suffixIcon: ImageConst.calender, labelBackColor: ColorConst.back, readOnly: true, hint: 'Select Manufacture Year',
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
                                // DateFormat.y().format(pickedDate);
                                vehicleController.dateController.text = formattedDate;
                              }else{}
                            },
                            validation: (MD) => Validation.normalValidation(MD),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            labelText: 'Fuel Type*',
                            controller: vehicleController.fTypeController,
                            titleList: seeAllController.carDropdownModel.value.data!.carFuelType!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carDropdownModel.value.data!.carFuelType,
                            function: (CarFuelType carFuelType){
                              addController.fuelID = carFuelType.carFuelTypeId!;
                              print(carFuelType.carFuelTypeId);
                              seeAllController.update();
                              addController.update();
                            },
                            validation: (fType) => Validation.normalValidation(fType),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            labelText: 'Gear Box*',
                            controller: vehicleController.gearController,
                            titleList: seeAllController.carDropdownModel.value.data!.carGearBox!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carDropdownModel.value.data!.carGearBox,
                            function: (CarGearBox carGearBox){
                              addController.gearBoxID = carGearBox.carGearBoxId!;
                              print(carGearBox.carGearBoxId);
                              seeAllController.update();
                              addController.update();
                            },
                            validation: (gear) => Validation.normalValidation(gear),
                          ),
                          // DropdownPopup(listItems: listItems, labelText: 'Gear Box*', labelBackColor: ColorConst.back, hintText: 'Select Type of Gear Box', selected: gear),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            labelText: 'Color*',
                            controller: vehicleController.colorController,
                            titleList: seeAllController.carDropdownModel.value.data!.carColor!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carDropdownModel.value.data!.carColor,
                            function: (CarColor color){
                              addController.colorID = color.carColorId!;
                              print(color.carColorId);
                              seeAllController.update();
                              addController.update();
                            },
                            validation: (color) => Validation.normalValidation(color),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            labelText: 'Engine Size*',
                            controller: vehicleController.engineController,
                            titleList: seeAllController.carDropdownModel.value.data!.carEngineSize!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carDropdownModel.value.data!.carEngineSize,
                            function: (CarEngineSize engine){
                              addController.engineSizeID = engine.carEngineSizeId!;
                              print(engine.carEngineSizeId);
                              seeAllController.update();
                              addController.update();
                            },
                            validation: (engine) => Validation.normalValidation(engine),
                          ),
                          // DropdownPopup(listItems: listItems, labelText: 'Engine Size*', labelBackColor: ColorConst.back, hintText: 'Select Engine Size', selected: engine),
                          const SizedBox(height: 17),
                          CustomInputField2(
                            controller: vehicleController.descController,
                            prefixIcon: '',
                            labelText: 'Description*',
                            maxLine: 4,
                            labelBackColor: ColorConst.back,
                            iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ,./]"))],
                            validation: (desc) => Validation.normalValidation(desc),
                          ),
                          const SizedBox(height: 17),
                          CustomInputField2(
                            controller: vehicleController.mileageController,
                            prefixIcon: '',
                            labelText: 'Mileage*',
                            labelBackColor: ColorConst.back,
                            iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                            validation: (mileage) => Validation.normalValidation(mileage),
                          ),
                          const SizedBox(height: 17),
                          // CustomInputField2(controller: currencyController, prefixIcon: '', labelText: 'Currency*', labelBackColor: ColorConst.back, readOnly: true),
                          CustomDropDownnn(
                            labelText: 'Currency*',
                            controller: vehicleController.currencyController,
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
                            validation: (currency) => Validation.normalValidation(currency),
                          ),
                          // DropdownPopup(listItems: listItems, labelText: 'Currency*', labelBackColor: ColorConst.back, hintText: 'Select Currency', selected: currency),
                          const SizedBox(height: 17),
                          CustomInputField2(
                            controller: vehicleController.priceController,
                            prefixIcon: '',
                            labelText: 'Price*',
                            labelBackColor: ColorConst.back,
                            type: TextInputType.number,
                            validation: (price) => Validation.normalValidation(price),
                          ),
                          const SizedBox(height: 17),
                          CustomInputField2(
                            controller: vehicleController.urlController,
                            prefixIcon: '',
                            labelText: 'Youtube Video URL (optional)',
                            labelBackColor: ColorConst.back,
                            validation: (state) => Validation.normalValidation2(state),
                          ),
                          const SizedBox(height: 17),
                          CustomDropDownnn(
                            labelText: 'When to start*',
                            controller: vehicleController.wtsController,
                            titleList: seeAllController.carDropdownModel.value.data!.whenToStart!.map((e) => e.title.toString()).toList(),
                            objectList: seeAllController.carDropdownModel.value.data!.whenToStart,
                            iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                            function: (WhenToStart wts){
                              addController.whenToStartID = wts.whenToStartId!;
                              seeAllController.update();
                              addController.update();
                            },
                          ),
                          // DropdownPopup(listItems: listItems, labelText: 'When to start*', labelBackColor: ColorConst.back, hintText: 'Select when to start', selected: start),
                          const SizedBox(height: 50),
                          Center(child: navigationFrom == 'add'?
                          Buttons.actionButtons(title: 'ADD', event: (){
                            if(formKey.currentState!.validate()){
                              addController.addVehicleData(
                                  vehiclePrimaryImage: addController.uploadedPicture.value,
                                  vehicleImages: addController.selectedImages,
                                  carMakerId: addController.carMakerID,
                                  carModelId: addController.carModelID,
                                  carTypeId: addController.vehicleTypeID,
                                  carConditionId: addController.conditionID,
                                  countryId: addController.countryID,
                                  stateId: addController.stateID,
                                  cityId: addController.cityID,
                                  manufacturingYear: vehicleController.dateController.text,
                                  carFuelTypeId: addController.fuelID,
                                  carGearBoxId: addController.gearBoxID,
                                  carColorId: addController.colorID,
                                  carEngineSizeId: addController.engineSizeID,
                                  description: vehicleController.descController.text,
                                  mileage: vehicleController.mileageController.text,
                                  currency: vehicleController.currencyController.text,
                                  price: vehicleController.priceController.text,
                                  youtubeUrl: vehicleController.urlController.text,
                                  whenToStartId: addController.whenToStartID
                              );
                            }
                          }):
                          Buttons.actionButtons(title: 'UPDATE', event: (){
                            if(formKey.currentState!.validate()){
                              updateController.updateVehicleData(
                                  vehicleID: navigationFrom,
                                  vehiclePrimaryImage: addController.uploadedPicture.value,
                                  vehicleImages: addController.selectedImages,
                                  carMakerId: addController.carMakerID,
                                  carModelId: addController.carModelID,
                                  carTypeId: addController.vehicleTypeID,
                                  carConditionId: addController.conditionID,
                                  countryId: addController.countryID,
                                  stateId: addController.stateID,
                                  cityId: addController.cityID,
                                  manufacturingYear: vehicleController.dateController.text,
                                  carFuelTypeId: addController.fuelID,
                                  carGearBoxId: addController.gearBoxID,
                                  carColorId: addController.colorID,
                                  carEngineSizeId: addController.engineSizeID,
                                  description: vehicleController.descController.text,
                                  mileage: vehicleController.mileageController.text,
                                  currency: vehicleController.currencyController.text,
                                  price: vehicleController.priceController.text,
                                  youtubeUrl: vehicleController.urlController.text,
                                  whenToStartId: addController.whenToStartID
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
