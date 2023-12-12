import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/profile_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/GlobalWidgets/input_field_2.dart';
import 'package:kawawa_motors/Model/login_model.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';
// import 'package:kawawa_motors/Model/item_available_model.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';
import 'package:kawawa_motors/Screen/PopUp/upgrade_profile_popup.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import '../../../Controller/home_controller.dart';
import '../../../Controller/me_controller.dart';
import '../../../GlobalWidgets/appbar_withoutback.dart';
import '../../../Constraints/image_const.dart';
import '../../../GlobalWidgets/dropdown_popup.dart';
import '../../../GlobalWidgets/loader.dart';
import '../../../GlobalWidgets/trim_name.dart';
import '../../../Model/city_list_model.dart';
import '../../../Model/state_list_model.dart';
import '../../PopUp/change_pass_popup.dart';
import '../../PopUp/upload_image.dart';

class PrivateProfile extends StatelessWidget {
  PrivateProfile({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  HomeController homeController = Get.put(HomeController());
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());
  ProfileController profileController = Get.put(ProfileController());
  MeController meController = Get.put(MeController());
  var loginModel = LoginModel().obs;

  @override
  Widget build(BuildContext context) {
    passwordController.text = 'ssssssss';
    return Scaffold(
      appBar: AppBarBack(title: 'Profile'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        child: GetBuilder(
          init: seeAllController,
          initState: (controller){
            meController.getMeData();
            seeAllController.getCountryListData();
            seeAllController.getStateListData(countryID: meController.meModel.value.data!.user!.country!.countryId!, showLoader: false);
            seeAllController.getCityListData(stateID: meController.meModel.value.data!.user!.state!.stateId!, showLoader: false);
          },
          builder: (value){
            return
              seeAllController.rOPModel.value.data == null || meController.meModel.value.data == null?
            SizedBox(height: Get.height,
                child: PRLoader.normalLoader()):
              Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 70),
                child: Form(key: formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Obx(() => CircleAvatar(
                              radius: 84,
                              backgroundColor: ColorConst.label,
                              ///fffffffff////
                              child:
                              profileController.profilePath.value?
                              CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.white,
                                  backgroundImage: FileImage(profileController.localProfile.value)
                              ):
                              SharedPrefUtils.getProfilePic() == '' || SharedPrefUtils.getProfilePic() == null?
                              CircleAvatar(
                                radius: 80,
                                // backgroundColor: Colors.white,
                                // backgroundImage: AssetImage(ImageConst.man),
                                backgroundColor: Color(int.parse(meController.meModel.value.data!.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                                child: Center(
                                  child: meController.meModel.value.data!.user!.fullName == "    "?
                                  Text(''):
                                  Text(TrimName.getInitials(meController.meModel.value.data!.user!.fullName!.toUpperCase()),
                                    style: TextStyle(color: Color(int.parse(meController.meModel.value.data!.user!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                                        fontWeight: FontWeight.w600, fontSize: 45

                                    ),
                                  ),
                                ),
                              ):
                              // profileController.profileImage.value != ''?
                              CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:CachedNetworkImageProvider(SharedPrefUtils.getProfilePic()!)
                              )
                            ))
                          ),
                          Positioned(right: 0, top: 30,
                            child: GestureDetector(onTap: (){Get.bottomSheet(UploadImage(uploadFrom: 'privateProfile',));},
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(ImageConst.camera, height: 22, color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('If you want to upgrade to a business', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 5),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           const Text('profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                          const SizedBox(width: 7),
                          GestureDetector(onTap: (){
                            Get.bottomSheet(const UpgradeProfile());
                          },
                              child: Text('Click Here', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConst.button))),
                        ],
                      ),
                      const SizedBox(height: 50),

                      CustomInputField2(controller: profileController.nameController,
                          prefixIcon: '', labelText: 'Name*', labelBackColor: ColorConst.back,
                          iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                        validation: (name) => Validation.normalValidation2(name)
                      ),
                      const SizedBox(height: 17),
                      CustomInputField2(controller: profileController.emailController, prefixIcon: '', labelText: 'Email ID*', labelBackColor: ColorConst.back, readOnly: true,
                        validation: (email) => Validation.emailValidation(email),
                      ),
                      const SizedBox(height: 17),
                      Row(
                        children: [
                          SizedBox(width: 100,
                            child: CustomDropDownnn(
                              labelText: 'Code*',
                              controller: profileController.codeController,
                              titleList: seeAllController.rOPModel.value.data == null?
                              []:seeAllController.rOPModel.value.data!.countries!.map((e) => e.telephoneCode.toString()).toList(),
                              objectList: seeAllController.rOPModel.value.data == null?
                              []: seeAllController.rOPModel.value.data!.countries,
                              function: (Countries phoneCode){
                                seeAllController.phoneCodeID = phoneCode.telephoneCode!;
                                // regionController.clear();
                                // cityController.clear();
                                seeAllController.update();
                                // seeAllController.getStateListData(countryID: phoneCode.countryId!, showLoader: true);
                              },
                              validation: (code) => Validation.normalValidation(code),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomInputField2(controller: profileController.phoneController, prefixIcon: '', labelText: 'Contact No*', type: TextInputType.number, labelBackColor: ColorConst.back,
                              validation: (phone) => Validation.phoneValidation(phone),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 17),
                      CustomDropDownnn(
                        labelText: 'Country*',
                        controller: profileController.countryController,
                        titleList: seeAllController.rOPModel.value.data == null?
                        []:seeAllController.rOPModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                        objectList: seeAllController.rOPModel.value.data == null?
                        []: seeAllController.rOPModel.value.data!.countries,
                        function: (Countries countries){
                          // profileController.codeController.text = countries.telephoneCode!;
                          seeAllController.countryID = countries.countryId!;
                          SharedPrefUtils.setCountryId(countries.countryId!);
                          print(countries.countryId!);
                          profileController.regionController.clear();
                          profileController.cityController.clear();
                          seeAllController.update();
                          seeAllController.getStateListData(countryID: countries.countryId!, showLoader: true);
                        },
                        validation: (country) => Validation.normalValidation(country),
                      ),
                      const SizedBox(height: 17),
                      // CustomInputField2(controller: countryController, prefixIcon: '', labelText: 'Country Name*', labelBackColor: ColorConst.back),
                      CustomDropDownnn(
                        labelText: 'Region*',
                        controller: profileController.regionController,
                        titleList: seeAllController.stateModel.value.data == null?
                        []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                        objectList: seeAllController.stateModel.value.data == null?
                        []: seeAllController.stateModel.value.data!.states,
                        function: (States states){
                          seeAllController.stateID = states.stateId!;
                          SharedPrefUtils.setStateId(states.stateId!);
                          profileController.cityController.clear();
                          seeAllController.update();
                          seeAllController.getCityListData(stateID: states.stateId!, showLoader: true);

                        },
                        validation: (state) => Validation.normalValidation(state),
                      ),
                      const SizedBox(height: 17),
                      // CustomInputField2(controller: stateController, prefixIcon: '', labelText: 'Region*', labelBackColor: ColorConst.back),
                      CustomDropDownnn(
                        labelText: 'City*',
                        controller: profileController.cityController,
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
                      PasswordField(controller: passwordController, prefixIcon: '', name: 'Password*', hint: 'Password', event: (){Get.bottomSheet(ChangePasswordPopup(), enableDrag: true, isDismissible: false);}, readOnly: true,
                        validation: (pass) => Validation.normalValidation2(pass),),
                      const SizedBox(height: 40),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 110),
                        child: Buttons.primaryButtons(title: 'UPDATE', event: (){
                          if(formKey.currentState!.validate()){
                          profileController.updateUserProfile(
                          name: profileController.nameController.text,
                          code: profileController.codeController.text,
                          phone: profileController.phoneController.text,
                          country: SharedPrefUtils.getCountryId().toString(),
                          region: SharedPrefUtils.getStateId().toString(),
                          city: SharedPrefUtils.getCityId().toString()
                          );
                          }
                        }),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ),
    );
  }
}
