import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import 'package:kawawa_motors/Screen/PopUp/bottomsheet_popup_2.dart';

import '../Constraints/color_const.dart';
import '../Constraints/text_style.dart';
import '../Screen/PopUp/bottomsheet_popup_3.dart';

class DropdownPopup extends StatelessWidget {
  DropdownPopup({Key? key,
    this.listItems,
    // this.newList,
    required this.hintText,
    required this.selected,
    this.labelBackColor,
    required this.labelText
  }) : super(key: key);

  DropDownController dropController = Get.put(DropDownController());
  TextEditingController searchController = TextEditingController();

  RxString selected;
  String hintText;
  List <String>? listItems;
  Color? labelBackColor = ColorConst.back;
  String labelText;
  // List<dynamic>?newList;
  // String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        GestureDetector(
          onTap: (){
          searchController.clear();
          // dropController.listItems = dropController.emptyList;
          Get.bottomSheet(POPUP(
            // newList!
          ), enableDrag: false, isScrollControlled: true);},
          child:
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(//height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13).copyWith(right: 10),
              decoration: BoxDecoration(
                // color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade600)
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => selected.value == ''?
                  Text(hintText, style: const TextStyle(fontSize: 18, color: Colors.grey),):
                  Text(selected.toString(), style: const TextStyle(fontSize: 18)),),
                  Icon(Icons.expand_more_outlined, color: Colors.grey.shade600,)
                ],
              ),
            ),
          ),
        ),
        Positioned(left: 14,
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 8),
                color: labelBackColor,
                child: Text(labelText, style: AppTextStyle.label2,)))

      ],
    );
  }

  Widget POPUP(
      // List<dynamic>newList
      ){

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      padding: const EdgeInsets.only(right: 10),
      height: 470,
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 35,),
              labelText == 'Make*'?
              Text('Select Make'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Model*'?
              Text('Select Model'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Vehicle Type*'?
              Text('Select vehicle type'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Condition*'?
              Text('Select Condition'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Country*'?
              Text('Select Country'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Region*'?
              Text('Select Region'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'City*'?
              Text('Select City'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Fuel Type*'?
              Text('Select Fuel Type'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Gear Box*' || labelText == 'Gear Box'?
              Text('Select Type of gear box'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Color*'?
              Text('Select Color'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Engine Size*'?
              Text('Select Engine Size'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Currency*'?
              Text('Select Currency'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'When to start*'?
              Text('Select When to start'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              Text('Select ${labelText}'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),

              IconButton(onPressed: (){Get.back();},
                  icon: const Icon(Icons.cancel_rounded, size: 42)
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(top: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  onChanged: (value){
                    dropController.filterSearch(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 25).copyWith(right: 20),
                    hintText: 'Search',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(ImageConst.glass),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey))
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(height: 300,
                  child:
                  GetBuilder(
                    init: dropController,
                    initState: (value){
                      // dropController.emptyList = newList;


                      dropController.listItems;
                      dropController.filterSearch(searchController.text);
                    },
                    builder: (val){
                      return ListView.builder(
                          itemCount: dropController.listItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                child: Container(padding: const EdgeInsets.symmetric(vertical: 12). copyWith(left: 10),
                                    color: selected.value == dropController.listItems[index]?
                                    ColorConst.select: Colors.transparent,
                                    child: Text(dropController.listItems[index], style: const TextStyle(fontSize: 18),)),
                                onTap: () {
                                  selected.value = dropController.listItems[index];
                                  print('Value is : ${selected}');
                                  Get.back();
                                }
                            );
                          }
                      );
                    },

                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class DropDownPopup2 extends StatelessWidget {
  DropDownPopup2({Key? key,
    required this.controller,
    this.objectList,
    required this.titleList,
    required this.labelText,
    this.function,
    this.validation,
    required this.enablePopup,
    this.dropdownMsg
  }) : super(key: key);

  // String hintText;
  List <dynamic>? objectList;
  List <String> titleList;
  String labelText;
  TextEditingController controller;
  Function? function;
  Function? validation;
  String? dropdownMsg;
  bool? enablePopup;

  TextEditingController searchController = TextEditingController();
  DropDownController dropController = Get.put(DropDownController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // searchController.clear();
        // dropController.listItems = dropController.emptyList;
        // Get.bottomSheet(POPUP(
        //     newList!, function
        // ), enableDrag: false, isScrollControlled: true);
        },
      child: TextFormField(
        style: const TextStyle(),
        controller: controller,
        onTap: (){
          searchController.clear();
          dropController.listItems = dropController.emptyList;
          if(enablePopup == true){
            Get.bottomSheet(
                BottomPopup2(
                    labelText: labelText,
                    searchController: searchController,
                    controller: controller,
                    objectList: objectList!,
                    titleList: titleList,
                    function: function!
                ),
                enableDrag: false, isScrollControlled: true);
          }else{
            // Get.snackbar('ERROR', 'please select ${dropdownMsg} first', colorText: Colors.redAccent, borderRadius: 5);
            Fluttertoast.showToast(msg: 'please select $dropdownMsg first', fontSize: 16);
          }
        },
        readOnly: true,
        validator: (value){
          if(validation!=null){
            return validation!(value);
          }
          return null;
        },
        decoration:
        InputDecoration(
          suffixIcon: Icon(Icons.expand_more_outlined, color: ColorConst.grey3),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),

          floatingLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorConst.label),
          errorStyle: const TextStyle(),
          hintText: '',
          hintStyle: const TextStyle(fontSize: 18, height: 2),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2)),
        ),

      ),
    );
  }

  Widget POPUP(List <dynamic> objectList, function, titleList){

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      padding: const EdgeInsets.only(right: 10),
      height: 470,
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 35,),
              labelText == 'Country Name*'?
              const Text('SELECT COUNTRY', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Region*'?
              const Text('SELECT REGION', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Code*'?
              Text('Select Country Code'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'Business Type*'?
              Text('Select Business Type'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              labelText == 'City*'?
              Text('Select City'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              Text('Select $labelText'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
              IconButton(onPressed: (){Get.back();},
                  icon: const Icon(Icons.cancel_rounded, size: 42)
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(top: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  onChanged: (value){
                    // dropController.filterSearch(value);
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 25).copyWith(right: 20),
                      hintText: 'Search',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(ImageConst.glass),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey))
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(height: 300,
                    child:
                    GetBuilder(
                      init: dropController,
                      initState: (value){
                        dropController.emptyList = objectList;
                        // dropController.listItems;
                        // dropController.filterSearch(searchController.text);
                      },
                      builder: (val){
                        return ListView.builder(
                            itemCount: objectList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  child: Container(padding: const EdgeInsets.symmetric(vertical: 12). copyWith(left: 10),
                                      color: controller.text == titleList[index]?
                                      ColorConst.select: Colors.transparent,
                                      child: Text(titleList[index], style: const TextStyle(fontSize: 18))),
                                  onTap: () {
                                    controller.text = titleList[index];
                                    Get.back();
                                    function(objectList[index]);


                                  }
                              );
                            }
                        );
                      },

                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class CustomDropDownnn extends StatelessWidget {
  CustomDropDownnn({Key? key,
    required this.labelText,
    required this.controller,
    this.objectList,
    this.titleList,
    this.function,
    this.validation,
    this.enablePopup = true,
    this.dropdownMsg,
    this.count,
    this.iF,
    this.fToast,
  }) : super(key: key);

  Color? labelBackColor = ColorConst.back;
  String labelText;
  TextEditingController controller;
  List <dynamic>? objectList;
  List <String>? titleList;
  Function? function;
  Function? validation;
  String? dropdownMsg;
  bool? enablePopup;
  RxInt? count;
  List<TextInputFormatter>? iF;

  DropDownController dropController = Get.put(DropDownController());
  TextEditingController searchController = TextEditingController();
  FToast? fToast;

  @override
  Widget build(BuildContext context) {
    // controller.text = selected.value;
    return TextFormField(
      validator: (value){
        if(validation!=null){
          return validation!(value);
        }
        return null;
      },
      inputFormatters: iF,
      focusNode: AlwaysDisabledFocusNode(),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 18, bottom: 18, left: 15),
        labelText: labelText,
        labelStyle: AppTextStyle.hintText,
        suffixIcon: Icon(Icons.expand_more_outlined, color: ColorConst.grey3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.grey)),
        floatingLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorConst.label),
      ),
      onTap: (){
        if(enablePopup == true){
          Get.bottomSheet(
              BottomPopup3(
                controller: controller,
                searchController: searchController,
                function: function!,
                titleList: titleList!,
                labelText: labelText,
                objectList: objectList!,
              ),
              enableDrag: false,
              isScrollControlled: true);
        }else{
          // Get.snackbar('ERROR', 'please select $dropdownMsg first', colorText: Colors.redAccent, borderRadius: 5, duration: Duration(milliseconds: 800), isDismissible: true);
          Fluttertoast.showToast(msg: 'please select $dropdownMsg first', fontSize: 16);

          // fToast?.showToast(
          //   child: Text('data'),
          //   gravity: ToastGravity.BOTTOM,
          //   toastDuration: Duration(seconds: 2),
          // );

        }
        // if(controller != ''){
        //   count!.value + 1;
        // }else{
        //   count!.value - 1;
        // }
        },
      readOnly: true,
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}


