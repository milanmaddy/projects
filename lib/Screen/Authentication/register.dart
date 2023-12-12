import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/authentication_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/dropdown.dart';
import 'package:kawawa_motors/GlobalWidgets/dropdown_popup.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/GlobalWidgets/password_field.dart';
import 'package:kawawa_motors/Model/city_list_model.dart';
import 'package:kawawa_motors/Model/register_option_model.dart';
import 'package:kawawa_motors/Model/state_list_model.dart';
import 'package:kawawa_motors/Screen/Authentication/validation.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../GlobalWidgets/input_field.dart';
import '../../GlobalWidgets/input_field_2.dart';
import '../../Routes/app_route.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  AuthenticationController authController = Get.put(AuthenticationController());
  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController());

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessPhoneController = TextEditingController();
  TextEditingController privateNameController = TextEditingController();
  TextEditingController businessPersonNameController = TextEditingController();
  TextEditingController privateEmailController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController privatePhoneController = TextEditingController();
  TextEditingController businessPersonalPhoneController = TextEditingController();
  TextEditingController privatePass1Controller = TextEditingController();
  TextEditingController privatePass2Controller = TextEditingController();
  TextEditingController businessPass1Controller = TextEditingController();
  TextEditingController businessPass2Controller = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  TextEditingController privateCountryController = TextEditingController();
  TextEditingController businessCountryController = TextEditingController();
  TextEditingController privateRegionController = TextEditingController();
  TextEditingController businessRegionController = TextEditingController();
  TextEditingController privateCityController = TextEditingController();
  TextEditingController businessCityController = TextEditingController();
  TextEditingController privateCodeController = TextEditingController();
  TextEditingController businessPersonalPhoneCodeController = TextEditingController();
  TextEditingController businessPhoneCodeController = TextEditingController();
  TextEditingController bTypeController = TextEditingController();


  final formKey = GlobalKey<FormState>();
  var check = false.obs;
  var check2 = true.obs;
  var check3 = false.obs;
  var check4 = true.obs;

  var country = ''.obs;
  var country2 = ''.obs;
  var state = ''.obs;
  var state2 = ''.obs;
  var bType = ''.obs;
  var pCode = ''.obs;
  var bCode = ''.obs;
  var pCode2 = ''.obs;

  RxString selectedValue = 'Private Account'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageConst.backPng2,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Obx(() => Column(
                children: [
                  Align(alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: GestureDetector(onTap: (){Get.back();},
                        child: Container(padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 3,
                                    spreadRadius: 2,
                                    offset: const Offset(0,2)
                                )
                              ]
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF455A64), size: 22)
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 5),
                  Image.asset(ImageConst.logoP),
                  const SizedBox(height: 20),
                  Text("SIGN UP", style: AppTextStyle.black20_600),
                  const SizedBox(height: 0),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          DropdownButtonFormField<String>(
                            value: selectedValue.value,
                            onChanged: (newValue) {
                              selectedValue.value = newValue!;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'SF', fontSize: 20),
                            icon: const Icon(Icons.expand_more_outlined, color: Colors.black,),
                            // hint: Text('Please select Account Type', style: TextStyle(color: Colors.black),),
                            items: ['Private Account', 'Business Account']
                                .map((value) => DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                  color: value == selectedValue.value? Colors.transparent:Colors.transparent,
                                  child: Text(value)),
                            )).toList(),
                            // dropdownColor: Colors.pink,
                            // focusColor: Colors.green,
                            // elevation: 0,
                          ),
                          const SizedBox(height: 30),
                          GetBuilder(
                            init: seeAllController,
                            initState: (controller){
                              seeAllController.getCountryListData();
                            },
                              builder: (value){
                                return seeAllController.rOPModel.value.data == null?
                                    Padding(
                                      padding: const EdgeInsets.only(top: 250),
                                      child: PRLoader.normalLoader(),
                                    ):
                                SizedBox(
                                  child: selectedValue.value == 'Private Account'?
                                  Form(key: formKey,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DropDownPopup2(
                                          enablePopup: true,
                                          labelText: 'Country Name*',
                                          validation: (country) => Validation.normalValidation(country),
                                          controller: privateCountryController,
                                          titleList: seeAllController.rOPModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                                          objectList: seeAllController.rOPModel.value.data!.countries,
                                          function: (Countries countries){
                                            // privateCodeController.text = countries.telephoneCode!;
                                            privateRegionController.clear();
                                            privateCityController.clear();
                                            seeAllController.countryID = countries.countryId!;
                                            print('country id is: ${seeAllController.countryID}');
                                            seeAllController.update();
                                            seeAllController.getStateListData(countryID: seeAllController.countryID);
                                            // seeAllController.getCityListData(stateID: '');
                                          },
                                        ),
                                        const SizedBox(height: 17),
                                        DropDownPopup2(
                                          enablePopup: privateCountryController.text == ''? false : true,
                                          dropdownMsg: 'Country',
                                          labelText: 'Region*',
                                          validation: (region) => Validation.normalValidation(region),
                                          controller: privateRegionController,
                                          titleList: seeAllController.stateModel.value.data == null?
                                              []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                                          objectList: seeAllController.stateModel.value.data == null?
                                          []: seeAllController.stateModel.value.data!.states,
                                          function: (States states){
                                            privateCityController.clear();
                                            print('ggg');
                                            print(states.stateName);
                                            seeAllController.stateID = states.stateId!;
                                            print('state id is: ${seeAllController.stateID}');
                                            seeAllController.update();
                                            seeAllController.getCityListData(stateID: seeAllController.stateID);
                                          },
                                        ),
                                        const SizedBox(height: 17),
                                        DropDownPopup2(
                                          enablePopup: privateRegionController.text == ''? false : true,
                                          dropdownMsg: privateCountryController.text == '' && privateRegionController.text == ''?
                                          'Country & Region':
                                          privateRegionController.text == ''?
                                          'Region': '',
                                          labelText: 'City*',
                                          validation: (city) => Validation.normalValidation(city),
                                          controller: privateCityController,
                                          titleList: seeAllController.cityModel.value.data == null?
                                          []: seeAllController.cityModel.value.data!.cities!.map((e) => e.cityName.toString()).toList(),
                                          objectList: seeAllController.cityModel.value.data == null?
                                          []: seeAllController.cityModel.value.data!.cities!,
                                          function: (Cities cities){
                                            seeAllController.cityID = cities.cityId!;
                                            print('city id is: ${seeAllController.cityID}');
                                            seeAllController.update();
                                          },

                                        ),
                                        const SizedBox(height: 10),
                                        CustomInputField(controller: privateNameController, prefixIcon: '', label: 'Full Name*', iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                                            validation: (name) => Validation.nameValidation(name)),
                                        const SizedBox(height: 10),
                                        CustomInputField(controller: privateEmailController, prefixIcon: '', label: 'Email ID*',
                                            validation: (email) => Validation.emailValidation(email), inputAction: TextInputAction.next, iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]"))],),
                                        const SizedBox(height: 10),
                                        Row(crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(width: 100,
                                                child: DropDownPopup2(
                                                  enablePopup: true,
                                                  labelText: 'Code*',
                                                  validation: (code) => Validation.normalValidation(code),
                                                  controller: privateCodeController,
                                                  titleList: seeAllController.rOPModel.value.data == null?
                                                  []: seeAllController.rOPModel.value.data!.countries!.map((e) => e.telephoneCode.toString()).toList(),
                                                  objectList: seeAllController.rOPModel.value.data == null?
                                                    []: seeAllController.rOPModel.value.data!.countries,
                                                  function: (Countries phoneCode){
                                                    print('COUNTRY CODE IS: ${phoneCode.telephoneCode}');
                                                    seeAllController.phoneCodeID = phoneCode.telephoneCode!;
                                                    seeAllController.update();
                                                  },


                                                )),
                                            const SizedBox(width: 15),
                                            Expanded(flex: 1,
                                              child: CustomInputField(controller: privatePhoneController, prefixIcon: '', type: TextInputType.number, label: 'Personal Contact No*',
                                                validation: (phone) => Validation.phoneValidation(phone),),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        CustomPasswordField(controller: privatePass1Controller, hint: '', label: 'Password*',
                                          validation: (pass1) => Validation.passwordValidation(pass1),),
                                        const SizedBox(height: 10),
                                        CustomPasswordField(controller: privatePass2Controller, hint: '', label: 'Confirm Password*',
                                          validation: (pass2)=> Validation.confirmPasswordValidation(pass2, privatePass1Controller.text, ''),),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                height: 20.0,
                                                width: 20.0,
                                                child: Obx(() => Checkbox(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                    activeColor: ColorConst.label,
                                                    // side: BorderSide(color: ColorConst.inputFilled),

                                                    value: check.value,
                                                    onChanged: (bool? value) {
                                                      check.value = value!;
                                                      check2.value=value;
                                                    }))),
                                            const SizedBox(width: 10),
                                            FormField<bool>(
                                              builder: (state) {
                                                return Flexible(
                                                  child: RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(text: 'I agree to the ',
                                                            style: TextStyle(color: ColorConst.grey4, fontSize: 15, fontFamily: 'SF')),
                                                        TextSpan(text: 'Terms & Condition ',
                                                            recognizer: TapGestureRecognizer()..onTap = (){Get.toNamed(AppRoute.termsCondition);
                                                            },
                                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ColorConst.label, fontFamily: 'SF')
                                                        ),
                                                        TextSpan(text: '& ',
                                                            style: TextStyle(color: ColorConst.grey4, fontSize: 15,fontFamily: 'SF')
                                                        ),
                                                        TextSpan(text: 'Privacy Policy',
                                                            recognizer: TapGestureRecognizer()..onTap = (){Get.toNamed(AppRoute.privacyPolicy);
                                                            },
                                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ColorConst.label, fontFamily: 'SF'))
                                                      ])),
                                                );
                                              },
                                              validator: (value) {
                                                if (!check.value) {
                                                  check2.value=false;
                                                  // Fluttertoast.showToast(msg:"You need to accept Terms & Conditions & Privacy Policy" );
                                                  return "You need to accept terms & conditions";
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                        Obx(() =>check2.value?const SizedBox(): const Align(alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text("You need to accept terms & conditions",
                                                  style: TextStyle(fontSize: 12,color: Colors.redAccent)),
                                            ))),
                                        const SizedBox(height: 40),
                                        Center(
                                            child: Buttons.actionButtons(
                                                title: 'SIGN UP',
                                                event: (){
                                                  // formKey.currentState!.validate();
                                                  authController.signUpPrivate(
                                                      key: formKey,
                                                      roleID: seeAllController.rOPModel.value.data!.roles![1].roleId!,
                                                      countryID: seeAllController.countryID,
                                                      stateID: seeAllController.stateID,
                                                      cityID: seeAllController.cityID,
                                                      name: privateNameController.text,
                                                      email: privateEmailController.text,
                                                      countryCode: '+${privateCodeController.text}',
                                                      phone: privatePhoneController.text,
                                                      password: privatePass1Controller.text,
                                                      confirmPassword: privatePass2Controller.text);
                                                  // print(seeAllController.countryID);
                                                  // print(seeAllController.stateID);
                                                  // print(seeAllController.cityID);
                                                  // print('+${privateCodeController.text}');
                                                })),
                                        const SizedBox(height: 30),
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text("Already have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                            const SizedBox(width: 5),
                                            GestureDetector(onTap: (){Get.toNamed(AppRoute.login);},
                                              child: Text('Sign in', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConst.button)),
                                            ),
                                          ],
                                        ),
                                        // Container(height: 150, width: 150, color: Colors.green)
                                      ],
                                    ),
                                  ) :
                                  Form(key: formKey,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DropDownPopup2(
                                          enablePopup: true,
                                          labelText: 'Country Name*',
                                          controller: businessCountryController,
                                          validation: (country) => Validation.normalValidation(country),
                                          titleList: seeAllController.rOPModel.value.data!.countries!.map((e) => e.countryName.toString()).toList(),
                                          objectList: seeAllController.rOPModel.value.data!.countries,
                                          function: (Countries countries){
                                            // businessPhoneCodeController.text = countries.telephoneCode!;
                                            // businessPersonalPhoneCodeController.text = countries.telephoneCode!;
                                            businessRegionController.clear();
                                            businessCityController.clear();
                                            seeAllController.countryID = countries.countryId!;
                                            print('business country id is: ${seeAllController.countryID}');
                                            print('business phone code is: +${businessPhoneCodeController.text}');
                                            seeAllController.update();
                                            seeAllController.getStateListData(countryID: seeAllController.countryID);
                                            // seeAllController.getCityListData(stateID: '');
                                          },
                                        ),
                                        const SizedBox(height: 17),
                                        DropDownPopup2(
                                          enablePopup: businessCountryController.text == ''? false : true,
                                          dropdownMsg: 'Country',
                                          labelText: 'Region*',
                                          controller: businessRegionController,
                                          validation: (region) => Validation.normalValidation(region),
                                          titleList: seeAllController.stateModel.value.data == null?
                                          []: seeAllController.stateModel.value.data!.states!.map((e) => e.stateName.toString()).toList(),
                                          objectList: seeAllController.stateModel.value.data == null?
                                          []: seeAllController.stateModel.value.data!.states,
                                          function: (States states){
                                            businessCityController.clear();
                                            print('ggg');
                                            print(states.stateName);
                                            seeAllController.stateID = states.stateId!;
                                            print('business state id is: ${seeAllController.stateID}');
                                            seeAllController.update();
                                            seeAllController.getCityListData(stateID: seeAllController.stateID);
                                          },
                                        ),
                                        const SizedBox(height: 17),
                                        DropDownPopup2(
                                          enablePopup: businessRegionController.text == ''? false : true,
                                          dropdownMsg: businessCountryController.text == '' && businessRegionController.text == ''?
                                          'Country & Region':
                                          businessRegionController.text == ''?
                                          'Region' : '',
                                          labelText: 'City*',
                                          controller: businessCityController,
                                          validation: (city) => Validation.normalValidation(city),
                                          titleList: seeAllController.cityModel.value.data == null?
                                          []: seeAllController.cityModel.value.data!.cities!.map((e) => e.cityName.toString()).toList(),
                                          objectList: seeAllController.cityModel.value.data == null?
                                          []: seeAllController.cityModel.value.data!.cities!,
                                          function: (Cities cities){
                                            seeAllController.cityID = cities.cityId!;
                                            print('business city id is: ${seeAllController.cityID}');
                                            seeAllController.update();
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        DropDownPopup2(
                                          enablePopup: true,
                                          labelText: 'Business Type*',
                                          controller: bTypeController,
                                          validation: (bType) => Validation.normalValidation(bType),
                                          titleList: seeAllController.rOPModel.value.data == null?
                                          []: seeAllController.rOPModel.value.data!.businessTypes!.map((e) => e.description.toString()).toList(),
                                          objectList: seeAllController.rOPModel.value.data == null?
                                          []: seeAllController.rOPModel.value.data!.businessTypes!,
                                          function: (BusinessTypes businessType){
                                            seeAllController.businessTypeID = businessType.businessTypeId!;
                                            print('business type id is: ${seeAllController.businessTypeID}');
                                            print('business type is: ${businessType.title}');
                                            seeAllController.update();
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        // Text('Business Name*', style: AppTextStyle.label),
                                        CustomInputField(controller: businessNameController, prefixIcon: '', label: 'Business Name*', iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                                            validation: (name) => Validation.nameValidation(name)),
                                        const SizedBox(height: 10),
                                        // Text('Business Contact No*', style: AppTextStyle.label),
                                        Row(crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(width: 100,
                                              child: DropDownPopup2(
                                                enablePopup: true,
                                                labelText: 'Code*',
                                                controller: businessPhoneCodeController,
                                                validation: (code) => Validation.normalValidation(code),
                                                titleList: seeAllController.rOPModel.value.data == null?
                                                []: seeAllController.rOPModel.value.data!.countries!.map((e) => e.telephoneCode.toString()).toList(),
                                                objectList: seeAllController.rOPModel.value.data == null?
                                                []: seeAllController.rOPModel.value.data!.countries,
                                                function: (Countries phoneCode){
                                                  seeAllController.phoneCodeID = phoneCode.telephoneCode!;
                                                  seeAllController.update();
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: CustomInputField(controller: businessPhoneController, prefixIcon: '', type: TextInputType.number, label: 'Business Contact No*',
                                                  validation: (contact) => Validation.phoneValidation(contact)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        // Text('Business Contact Person Name*', style: AppTextStyle.label),
                                        CustomInputField(controller: businessPersonNameController, prefixIcon: '', label: 'Business Contact Person Name*', iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                                            validation: (name) => Validation.nameValidation(name)),
                                        const SizedBox(height: 10),
                                        // Text('Email ID*', style: AppTextStyle.label),
                                        CustomInputField(controller: businessEmailController, prefixIcon: '', label: 'Email ID*', iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]"))],
                                            validation: (email) => Validation.emailValidation(email), inputAction: TextInputAction.next),
                                        const SizedBox(height: 10),
                                        // Text('Personal Contact No', style: AppTextStyle.label),
                                        Row(crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(width: 100,
                                              child: DropDownPopup2(
                                                enablePopup: true,
                                                labelText: 'Code*',
                                                controller: businessPersonalPhoneCodeController,
                                                validation: (code) => Validation.normalValidation(code),
                                                titleList: seeAllController.rOPModel.value.data == null?
                                                []: seeAllController.rOPModel.value.data!.countries!.map((e) => e.telephoneCode.toString()).toList(),
                                                objectList: seeAllController.rOPModel.value.data == null?
                                                []: seeAllController.rOPModel.value.data!.countries,
                                                function: (Countries phoneCode){
                                                  seeAllController.phoneCodeID = phoneCode.telephoneCode!;
                                                  seeAllController.update();
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                                child: CustomInputField(controller: businessPersonalPhoneController, prefixIcon: '', type: TextInputType.number, label: 'Personal Contact No*',
                                                  validation: (pNumber) => Validation.phoneValidation(pNumber),)),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        CustomInputField(controller: websiteController, prefixIcon: '', label: 'Website URL', iF: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))],
                                          validation: (web) => Validation.normalValidation2(web),
                                        ),
                                        const SizedBox(height: 10),
                                        // Text('Password*', style: AppTextStyle.label),
                                        CustomPasswordField(controller: businessPass1Controller, hint: '', label: 'Password*',
                                          validation: (pass1) => Validation.passwordValidation(pass1),),
                                        const SizedBox(height: 10),
                                        // Text('Confirm Password*', style: AppTextStyle.label),
                                        CustomPasswordField(controller: businessPass2Controller, hint: '', label: 'Confirm Password*',
                                          validation: (pass2)=> Validation.confirmPasswordValidation(pass2, businessPass1Controller.text, ''),),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                height: 20.0,
                                                width: 20.0,
                                                child: Obx(() => Checkbox(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                    activeColor: ColorConst.label,
                                                    // side: BorderSide(color: ColorConst.inputFilled),

                                                    value: check3.value,
                                                    onChanged: (bool? value) {
                                                      check3.value = value!;
                                                      check4.value=value;
                                                    }))),
                                            const SizedBox(width: 10),
                                            FormField<bool>(
                                              builder: (state) {
                                                return Flexible(
                                                  child: RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(text: 'I agree to the ',
                                                            style: TextStyle(color: ColorConst.grey4, fontSize: 15, fontFamily: 'SF')),
                                                        TextSpan(text: 'Terms & Condition ',
                                                            recognizer: TapGestureRecognizer()..onTap = (){Get.toNamed(AppRoute.termsCondition);
                                                            },
                                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ColorConst.label, fontFamily: 'SF')
                                                        ),
                                                        TextSpan(text: '& ',
                                                            style: TextStyle(color: ColorConst.grey4, fontSize: 15,fontFamily: 'SF')
                                                        ),
                                                        TextSpan(text: 'Privacy Policy',
                                                            recognizer: TapGestureRecognizer()..onTap = (){Get.toNamed(AppRoute.privacyPolicy);
                                                            },
                                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ColorConst.label, fontFamily: 'SF'))
                                                      ])),
                                                );
                                              },
                                              validator: (value) {
                                                if (!check3.value) {
                                                  check4.value=false;
                                                  // Fluttertoast.showToast(msg:"You need to accept Terms & Conditions & Privacy Policy" );
                                                  return "You need to accept terms & conditions";
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                        Obx(() =>check4.value?const SizedBox(): const Align(alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text("You need to accept terms & conditions",
                                                  style: TextStyle(fontSize: 12,color: Colors.redAccent)),
                                            ))),
                                        const SizedBox(height: 40),
                                        Center(child: Buttons.actionButtons(title: 'SIGN UP', event: (){
                                          // formKey.currentState!.validate(); print('Business Account');
                                          authController.signUpBusiness(
                                              key: formKey,
                                              roleID: seeAllController.rOPModel.value.data!.roles![0].roleId!,
                                              countryID: seeAllController.countryID,
                                              stateID: seeAllController.stateID,
                                              cityID: seeAllController.cityID,
                                              businessTypeID: seeAllController.businessTypeID,
                                              businessName: businessNameController.text,
                                              businessPhoneCountryCode: '+${businessPhoneCodeController.text}',
                                              businessPhone: businessPhoneController.text,
                                              name: businessPersonNameController.text,
                                              email: businessEmailController.text,
                                              phoneCountryCode: '+${businessPersonalPhoneCodeController.text}',
                                              phone: businessPersonalPhoneController.text,
                                              website: websiteController.text,
                                              password: businessPass1Controller.text,
                                              confirmPassword: businessPass2Controller.text
                                          );
                                          // print(seeAllController.rOPModel.value.data!.roles![0].roleId);
                                          // print(seeAllController.countryID);
                                          // print(seeAllController.stateID);
                                          // print(seeAllController.cityID);
                                          // print(seeAllController.businessTypeID);
                                          // print(businessNameController.text);
                                          // print(businessPhoneCodeController.text);
                                          // print(businessPhoneController.text);
                                          // print(businessPersonNameController.text);
                                          // print(businessEmailController.text);
                                          // print(businessPersonalPhoneCodeController.text);
                                          // print(businessPersonalPhoneController.text);
                                          // print(websiteController.text);
                                          // print(businessPass1Controller.text);
                                          // print(businessPass2Controller.text);
                                        })),
                                        const SizedBox(height: 30),
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text("Already have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                            const SizedBox(width: 5),
                                            GestureDetector(onTap: (){Get.toNamed(AppRoute.login);},
                                              child: Text('Sign in', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConst.button)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
              )
            ),
          ),
        ],
      ),
    );
  }
}
