import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/garage_controller.dart';
import 'package:kawawa_motors/Controller/update_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field_2.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';
import '../../../../Constraints/image_const.dart';
import '../../../../Constraints/text_style.dart';
import '../../../../Controller/add_controller.dart';
import '../../../../Controller/see_all_controller.dart';
import '../../../../GlobalWidgets/dropdown.dart';
import '../../../../GlobalWidgets/dropdown_popup.dart';
import '../../../../Model/city_list_model.dart';
import '../../../../Model/state_list_model.dart';
import '../../../Authentication/validation.dart';
import '../../../PopUp/upload_image.dart';

class AddGarage extends StatelessWidget {
  AddGarage({Key? key}) : super(key: key);



  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  AddController addController = Get.put(AddController());
  GarageController gController = Get.put(GarageController());
  UpdateController updateController = Get.put(UpdateController());

  TimeOfDay selectedTime = TimeOfDay.now();
  var multipleImage = false.obs;
  final formKey = GlobalKey<FormState>();
  String navigationFrom = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print('==============================');
    print(addController.countryID);
    return Scaffold(
      appBar: CustomAppBar(title: navigationFrom == 'add'? 'Add Garage':'Update Garage'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        child: GetBuilder(
          init: seeAllController,
          initState: (controller){
            seeAllController.getCountryListData();
            if(navigationFrom != 'add'){
              print('garage details calling...');
              gController.getGarageDetailsData(gid: navigationFrom);
            }
          },
          builder: (value){
            if(seeAllController.rOPModel.value.data == null){
              return SizedBox(
                height: Get.height,
                child: PRLoader.normalLoader(),
              );
            }else if(navigationFrom != 'add'){
              if(gController.garageModel.value.data == null){
                return SizedBox(
                  height: Get.height,
                  child: PRLoader.normalLoader(),
                );
              }else{}
            }
            return Column(
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
                                          addController.uploadedLogo.value == ''?
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
                                                image: DecorationImage(image: FileImage(File(addController.uploadedLogo.value)),
                                                    fit: BoxFit.cover)
                                            ),
                                            // child: SvgPicture.asset(ImageConst.upload)
                                          ):
                                          addController.uploadedLogo.value == gController.garageModel.value.data!.garage!.garagePrimaryImageUrl!?
                                          Container(height: 90, width: 105,
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: const Color(0xFFF1F1F1),
                                                image: DecorationImage(image: NetworkImage(addController.uploadedLogo.value), fit: BoxFit.cover)
                                            ),
                                          ):
                                          Container(height: 90, width: 105,
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: const Color(0xFFF1F1F1),
                                                image: DecorationImage(image: FileImage(File(addController.uploadedLogo.value)),
                                                    fit: BoxFit.cover)
                                            ),
                                            // child: SvgPicture.asset(ImageConst.upload)
                                          )
                                      ),
                                      Positioned(bottom: 1, right: 1,
                                        child: GestureDetector(onTap: (){Get.bottomSheet(UploadImage(uploadFrom: 'addGarage',));},
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
                                      Text('Upload Your Garage Logo', style: AppTextStyle.label2),
                                      const SizedBox(height: 5),
                                      Text('uploading more photos Increases\nyour chance of closing a deal', style: AppTextStyle.grid),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                          addController.uploadedPicture.value == gController.garageModel.value.data!.garage!.garageSecondaryImageUrl!?
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
                                      Text('Garage Image', style: AppTextStyle.label2),
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
                                                  )):
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
                                                        gController.deleteGarageImage(garageImgID: e.imageID!);
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
                          ));
                        }
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(20).copyWith(top: 40, bottom: 40),
                  child: Form(
                    key: formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInputField2(
                          controller: gController.garageController,
                          prefixIcon: '',
                          labelText: 'Garage Name*',
                          labelBackColor: ColorConst.back,
                          iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                          validation: (make) => Validation.normalValidation(make),
                        ),
                        const SizedBox(height: 17),
                        CustomInputField2(controller: gController.startTimeController, labelText: 'Start Time*', suffixIcon: ImageConst.calender, labelBackColor: ColorConst.back, readOnly: true, hint: 'Select Start Time',
                          event: ()async{
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,

                            );
                            if (pickedTime != null) {
                              String formattedTime = pickedTime.format(context);
                              gController.startTimeController.text = formattedTime;
                            } else {
                              print("Time is not selected");
                            }
                          },
                          validation: (make) => Validation.normalValidation(make),
                        ),
                        const SizedBox(height: 17),
                        CustomInputField2(controller: gController.endTimeController, labelText: 'End Time*', suffixIcon: ImageConst.calender, labelBackColor: ColorConst.back, readOnly: true, hint: 'Select End Time',
                          event: ()async{
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (pickedTime != null) {
                              String formattedTime = pickedTime.format(context);
                              gController.endTimeController.text = formattedTime;
                            } else {
                              print("Time is not selected");
                            }
                          },
                          validation: (make) => Validation.normalValidation(make),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 25),
                            child: Text('Contact', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                        ),
                        CustomInputField2(
                          controller: gController.personController,
                          validation: (make) => Validation.nameValidation(make),
                          prefixIcon: '', labelText: 'Contact Person*',  labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],),
                        const SizedBox(height: 17),
                        CustomInputField2(
                          controller: gController.emailController,
                          validation: (make) => Validation.emailValidation(make),
                          prefixIcon: '', labelText: 'Contact Email*',  labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z @.]"))],),
                        const SizedBox(height: 17),
                        CustomInputField2(
                          controller: gController.contactController,
                          validation: (make) => Validation.phoneValidation(make),
                          prefixIcon: '', labelText: 'Contact No*',  labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 25),
                            child: Text('Address', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                        ),
                        CustomDropDownnn(
                          labelText: 'Country*',
                          controller: gController.countryController,
                          titleList: seeAllController.rOPModel.value.data == null?
                          []: seeAllController.rOPModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                          objectList: seeAllController.rOPModel.value.data == null?
                          []: seeAllController.rOPModel.value.data!.countries,
                          function: (Countries countries){
                            gController.regionController.clear();
                            gController.cityController.clear();
                            addController.countryID = countries.countryId!;
                            seeAllController.update();
                            addController.update();
                            seeAllController.getStateListData(countryID: addController.countryID);
                          },
                          validation: (make) => Validation.normalValidation(make),
                        ),
                        const SizedBox(height: 17),
                        CustomDropDownnn(
                          enablePopup: gController.countryController.text == ''? false : true,
                          dropdownMsg: 'Country',
                          labelText: 'Region*',
                          controller: gController.regionController,
                          titleList: seeAllController.stateModel.value.data == null?
                          []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                          objectList: seeAllController.stateModel.value.data == null?
                          []: seeAllController.stateModel.value.data!.states,
                          function: (States states){
                            gController.cityController.clear();
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
                          enablePopup: gController.regionController.text == ''? false : true,
                          dropdownMsg: gController.countryController.text == '' && gController.regionController.text == ''?
                          'Country & Region':
                          gController.regionController.text == ''?
                          'Region': '',
                          labelText: 'City*',
                          controller: gController.cityController,
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
                            child: Text('Others', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                        ),
                        CustomInputField2(controller: gController.websiteController, prefixIcon: '', labelText: 'Website',  labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))], validation: (make) => Validation.normalValidation2(make),),
                        const SizedBox(height: 17),
                        CustomInputField2(controller: gController.serviceController, prefixIcon: '', labelText: 'Services', labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))], validation: (make) => Validation.normalValidation2(make),),
                        const SizedBox(height: 17),
                        CustomInputField2(controller: gController.descController, prefixIcon: '', labelText: 'Description',  maxLine: 4, labelBackColor: ColorConst.back, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))], validation: (make) => Validation.normalValidation2(make),),
                        const SizedBox(height: 50),
                        Center(child: navigationFrom == 'add'?
                        Buttons.actionButtons(title: 'ADD', event: (){
                          if(formKey.currentState!.validate()){
                            addController.addGarageData(
                                garagePrimaryImage: addController.uploadedLogo.value,
                                garageSecondaryImage: addController.uploadedPicture.value,
                                garageImages: addController.selectedImages,
                                countryId: addController.countryID,
                                stateId: addController.stateID,
                                cityId: addController.cityID,
                                garageName: gController.garageController.text,
                                garageStartTime: gController.startTimeController.text,
                                garageEndTime: gController.endTimeController.text,
                                personName: gController.personController.text,
                                personEmail: gController.emailController.text,
                                personNumber: gController.contactController.text,
                                websiteUrl: gController.websiteController.text,
                                services: gController.serviceController.text,
                                description: gController.descController.text
                            );
                          }
                        }):
                        Buttons.actionButtons(title: 'UPDATE', event: (){
                          if(formKey.currentState!.validate()){
                            updateController.updateGarageData(
                                garageID: navigationFrom,
                                garagePrimaryImage: addController.uploadedLogo.value,
                                garageSecondaryImage: addController.uploadedPicture.value,
                                garageImages: addController.selectedImages,
                                countryId: addController.countryID,
                                stateId: addController.stateID,
                                cityId: addController.cityID,
                                garageName: gController.garageController.text,
                                garageStartTime: gController.startTimeController.text,
                                garageEndTime: gController.endTimeController.text,
                                personName: gController.personController.text,
                                personEmail: gController.emailController.text,
                                personNumber: gController.contactController.text,
                                websiteUrl: gController.websiteController.text,
                                services: gController.serviceController.text,
                                description: gController.descController.text
                            );
                          }
                          // print(addController.selectedImages);
                          // print(navigationFrom);
                          // print(addController.uploadedLogo.value);
                          // print(addController.uploadedPicture.value);
                          // print(addController.countryID);
                          // print(addController.stateID);
                          // print(addController.cityID);
                        })
                        )
                      ],
                    ),
                  )
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
