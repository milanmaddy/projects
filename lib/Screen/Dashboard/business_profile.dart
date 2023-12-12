import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Controller/profile_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/appbar_withoutback.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';
import 'package:kawawa_motors/Screen/PopUp/change_pass_popup.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import '../../Constraints/image_const.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/dropdown_popup.dart';
import '../../GlobalWidgets/input_field_2.dart';
import '../../GlobalWidgets/loader.dart';
import '../../Model/city_list_model.dart';
import '../../Model/state_list_model.dart';
import '../../Routes/app_route.dart';
import '../Authentication/validation.dart';
import '../PopUp/upload_image.dart';

class BusinessProfile extends StatelessWidget {
  BusinessProfile({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  ProfileController profileController = Get.put(ProfileController());
  MeController meController = Get.put(MeController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    passwordController.text = 'ssssssss';
    return Scaffold(
      appBar: //CustomAppBar(title: 'Edit Business Profile'),
      AppBarBack(title: 'Business Profile'),
      backgroundColor: ColorConst.back,
      body: RefreshIndicator(
        onRefresh: ()async{
          meController.getMeData();
        },
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
            child: GetBuilder(
              init: seeAllController,
              initState: (controller){
                meController.getMeData();
                seeAllController.getCountryListData();
                seeAllController.getStateListData(countryID: meController.meModel.value.data!.user!.country!.countryId!, showLoader: false);
                seeAllController.getCityListData(stateID: meController.meModel.value.data!.user!.state!.stateId!, showLoader: false);
                // profileController.businessProfileLogo.value = meController.meModel.value.data!.user!.businessAccount!.businessLogoUrl!;
              },
              builder: (value){
                return seeAllController.rOPModel.value.data == null?
                SizedBox(height: Get.height,
                    child: PRLoader.normalLoader()):
                  Form(key: formKey,
                    child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10, right: 10),
                                child: Container(height: 110, width: 110,
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: ColorConst.grey2,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:
                                  // Padding(
                                  //   padding: const EdgeInsets.all(30.0),
                                  //   child: SvgPicture.asset(ImageConst.camera),
                                  // )
                                  // Image.asset(ImageConst.man, fit: BoxFit.fill)
                                  Obx(() => profileController.profilePath2.value?
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorConst.grey2,
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(image: FileImage(File(profileController.businessProfileLogo.value)), fit: BoxFit.cover)
                                    ),
                                  ):
                                  SharedPrefUtils.getBusinessLogo() != null && SharedPrefUtils.getBusinessLogo() != 'null'?
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ColorConst.grey2,
                                        image: DecorationImage(image: CachedNetworkImageProvider(SharedPrefUtils.getBusinessLogo()!), fit: BoxFit.cover)
                                    ),
                                  ):
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: SvgPicture.asset(ImageConst.camera),
                                  ),
                                  //     SharedPrefUtils.getBusinessLogo() == null || SharedPrefUtils.getBusinessLogo() == ''?
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.green,
                                  //       image: DecorationImage(image: CachedNetworkImageProvider(SharedPrefUtils.getBusinessLogo()!))
                                  //   ),
                                  ))
                                ),
                              Positioned(right: 0, top: 5,
                                  child: GestureDetector(onTap: (){
                                    Get.bottomSheet(UploadImage(uploadFrom: 'businessProfile',));
                                  },
                                      child: SvgPicture.asset(ImageConst.pencil)))
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Your Business Logo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorConst.label)),
                              Text('uploding your Logo', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: ColorConst.blue1)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      // Text(SharedPrefUtils.getUserId().toString()),
                      // Text(SharedPrefUtils.getBusinessTypeName().toString()),
                      CustomDropDownnn(
                        labelText: 'Country*',
                        controller: profileController.businessCountryController,
                        titleList: seeAllController.rOPModel.value.data == null?
                        []:seeAllController.rOPModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                        objectList: seeAllController.rOPModel.value.data == null?
                        []: seeAllController.rOPModel.value.data!.countries,
                        function: (Countries countries){
                          // profileController.bPhoneCodeController.text = countries.telephoneCode!;
                          // profileController.phoneCodeController.text = countries.telephoneCode!;
                          seeAllController.countryID = countries.countryId!;
                          // SharedPrefUtils.setCountryId(countries.countryId!);
                          // SharedPrefUtils.setPhoneCode(countries.telephoneCode!);
                          // SharedPrefUtils.setBusinessPhoneCode(countries.telephoneCode!);
                          // print(countries.countryId!);
                          profileController.businessRegionController.clear();
                          profileController.businessCityController.clear();
                          seeAllController.update();
                          seeAllController.getStateListData(countryID: countries.countryId!, showLoader: true);
                        },
                        validation: (country) => Validation.normalValidation(country),
                      ),
                      const SizedBox(height: 17),
                      CustomDropDownnn(
                        labelText: 'Region*',
                        controller: profileController.businessRegionController,
                        titleList: seeAllController.stateModel.value.data == null?
                        []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                        objectList: seeAllController.stateModel.value.data == null?
                        []: seeAllController.stateModel.value.data!.states,
                        function: (States states){
                          seeAllController.stateID = states.stateId!;
                          SharedPrefUtils.setStateId(states.stateId!);
                          profileController.businessCityController.clear();
                          seeAllController.update();
                          seeAllController.getCityListData(stateID: states.stateId!, showLoader: true);

                        },
                        validation: (state) => Validation.normalValidation(state),
                      ),
                      const SizedBox(height: 17),
                      // CustomInputField2(controller: stateController, prefixIcon: '', labelText: 'Region*', labelBackColor: ColorConst.back),
                      CustomDropDownnn(
                        labelText: 'City*',
                        controller: profileController.businessCityController,
                        titleList: seeAllController.cityModel.value.data == null?
                        []: seeAllController.cityModel.value.data!.cities!.map((e) => e.cityName.toString()).toList(),
                        objectList: seeAllController.cityModel.value.data == null?
                        []: seeAllController.cityModel.value.data!.cities,
                        function: (Cities cities){
                          // dropController.isValueSelected = true;
                          seeAllController.cityID = cities.cityId!;
                          SharedPrefUtils.setCityId(cities.cityId!);
                          seeAllController.update();
                          // seeAllController.getSeeAllDealerData(
                          //     countryId: homeController.newCountryID,
                          //     stateId: seeAllController.stateID,
                          //     cityId: seeAllController.cityID,
                          //     businessId: ''
                          // );
                        },
                        validation: (city) => Validation.normalValidation(city),
                      ),
                      const SizedBox(height: 17),
                      CustomDropDownnn(
                        labelText: 'Business Type*',
                        controller: profileController.businessTypeController,
                        titleList: seeAllController.rOPModel.value.data == null?
                        []: seeAllController.rOPModel.value.data!.businessTypes!.map((e) => e.description.toString()).toList(),
                        objectList: seeAllController.rOPModel.value.data == null?
                        []: seeAllController.rOPModel.value.data!.businessTypes!,
                        function: (BusinessTypes businessType){
                          seeAllController.businessTypeID = businessType.businessTypeId!;
                          SharedPrefUtils.setBusinessType(businessType.businessTypeId!);
                          print('business type id is: ${seeAllController.businessTypeID}');
                          print('business type is: ${businessType.title}');
                          seeAllController.update();
                        },
                        validation: (bType) => Validation.normalValidation(bType),
                      ),
                      const SizedBox(height: 17),
                      CustomInputField2(
                        controller: profileController.businessName,
                        prefixIcon: '',
                        iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                        labelText: 'Business Name*',
                        labelBackColor: ColorConst.back,
                        validation: (bName) => Validation.nameValidation(bName),
                      ),
                      const SizedBox(height: 17),
                      Row(
                        children: [
                          SizedBox(width: 100,
                            child: CustomDropDownnn(
                              labelText: 'Code*',
                              controller: profileController.bPhoneCodeController,
                              titleList: seeAllController.rOPModel.value.data == null?
                              []:seeAllController.rOPModel.value.data!.countries!.map((e) => e.telephoneCode.toString()).toList(),
                              objectList: seeAllController.rOPModel.value.data == null?
                              []: seeAllController.rOPModel.value.data!.countries,
                              function: (Countries phoneCode){
                                seeAllController.bPhoneCodeID = phoneCode.telephoneCode!;
                                SharedPrefUtils.setBusinessPhoneCode(phoneCode.telephoneCode!);
                                seeAllController.update();
                              },
                              validation: (bCode) => Validation.normalValidation(bCode),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              child: CustomInputField2(
                                  controller: profileController.businessContactNo,
                                  prefixIcon: '',
                                  labelText: 'Business Contact Number*',
                                  type: TextInputType.number,
                                  labelBackColor: ColorConst.back,
                                validation: (bContact) => Validation.nameValidation(bContact),
                              )),
                        ],
                      ),
                      const SizedBox(height: 17),
                      CustomInputField2(
                        controller: profileController.businessPersonName,
                        prefixIcon: '',
                        iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                        labelText: 'Business Contact Person Name*',
                        labelBackColor: ColorConst.back,
                        validation: (name) => Validation.nameValidation(name),
                      ),
                      const SizedBox(height: 17),
                      CustomInputField2(
                        controller: profileController.businessEmailController,
                        prefixIcon: '',
                        labelText: 'Email ID*',
                        readOnly: true,
                        iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]"))],
                        labelBackColor: ColorConst.back,
                        validation: (email) => Validation.emailValidation(email),
                      ),
                      const SizedBox(height: 17),
                      Row(
                        children: [
                          SizedBox(width: 100,
                            child: CustomDropDownnn(
                              labelText: 'Code*',
                              controller: profileController.phoneCodeController,
                              titleList: seeAllController.rOPModel.value.data == null?
                              []:seeAllController.rOPModel.value.data!.countries!.map((e) => e.telephoneCode.toString()).toList(),
                              objectList: seeAllController.rOPModel.value.data == null?
                              []: seeAllController.rOPModel.value.data!.countries,
                              function: (Countries phoneCode){
                                seeAllController.bPhoneCodeID = phoneCode.telephoneCode!;
                                SharedPrefUtils.setPhoneCode(phoneCode.telephoneCode!);
                                seeAllController.update();
                              },
                              validation: (code) => Validation.normalValidation(code),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomInputField2(
                              controller: profileController.personalContactNo,
                              prefixIcon: '', labelText: 'Personal Contact No*',
                              type: TextInputType.number,
                              labelBackColor: ColorConst.back,
                              validation: (phone) => Validation.phoneValidation(phone),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 17),
                      CustomInputField2(
                        controller: profileController.urlController,
                        prefixIcon: '',
                        labelText: 'Website URL',
                        iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                        labelBackColor: ColorConst.back,
                        validation: (url) => Validation.normalValidation2(url),
                      ),
                      const SizedBox(height: 17),
                      PasswordField(
                          controller: passwordController,
                          prefixIcon: '',
                          name: 'Password*',
                          hint: '', event: (){Get.bottomSheet(ChangePasswordPopup(), enableDrag: true, isDismissible: false);}, readOnly: true,
                        validation: (pass) => Validation.normalValidation2(pass),
                      ),

                      const SizedBox(height: 40),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 110),
                        child: Buttons.primaryButtons(title: 'UPDATE', event: (){
                          if(formKey.currentState!.validate()){
                            profileController.updatePrivateToBusinessProfile(
                                logo:
                                // SharedPrefUtils.getBusinessLogo().toString(),
                                profileController.businessProfileLogo.value,
                                country: SharedPrefUtils.getCountryId().toString(),
                                region: SharedPrefUtils.getStateId().toString(),
                                city: SharedPrefUtils.getCityId().toString(),
                                businessType: SharedPrefUtils.getBusinessType().toString(),
                                businessName: profileController.businessName.text,
                                phoneCode: SharedPrefUtils.getPhoneCode().toString(),
                                businessPhoneCode: SharedPrefUtils.getBusinessPhoneCode().toString(),
                                personalContactNo: profileController.personalContactNo.text,
                                businessContactNo: profileController.businessContactNo.text,
                                businessPersonName: profileController.businessPersonName.text,
                                website: profileController.urlController.text
                            );
                            print(profileController.businessProfileLogo.value);
                            print(SharedPrefUtils.getCountryId().toString());
                            print(SharedPrefUtils.getStateId().toString());
                            print(SharedPrefUtils.getCityId().toString());
                            print(SharedPrefUtils.getBusinessType().toString());
                            print(profileController.businessName.text);
                            print(SharedPrefUtils.getPhoneCode().toString());
                            print(SharedPrefUtils.getBusinessPhoneCode().toString());
                            print(profileController.personalContactNo.text);
                            print(profileController.businessContactNo.text);
                            print(profileController.businessPersonName.text);
                            print(profileController.urlController.text);

                          }
                        }),
                      )
                    ],
                ),
                  );
              },
            )
          ),
        ),
      ),
    );
  }
}
