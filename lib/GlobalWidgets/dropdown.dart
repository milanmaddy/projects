import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import '../Constraints/color_const.dart';
import '../Constraints/text_style.dart';
import 'package:get/get.dart';

class CustomDropDown extends StatelessWidget{
  CustomDropDown({Key? key,
   // this.selectedVal,
    required this.listItems,
    required this.labelText,
    this.iconColor,
    this.validation,
    required this.onTap,
    this.labelBackColor,
    this.hint,
  }): super(key: key);

  DropDownController dropController = Get.put(DropDownController());

  String? selectedVal;
  List<String>? listItems;
  String labelText;
  String? hint;
  Color? iconColor = Colors.black;
  Color? labelBackColor = ColorConst.back;
  VoidCallback? onTap;
  Function? validation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(left: 22),
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade700)
            ),
            child: DropdownButtonFormField(
              onTap: onTap,
              borderRadius: BorderRadius.circular(5),
              style: AppTextStyle.hintText,
              // TextStyle(color: Colors.grey.shade700),
              elevation: 2,
              hint: Text(hint.toString(), style: AppTextStyle.hintText),
              // value: selectedVal,
              icon: Icon(Icons.expand_more_outlined, color: iconColor),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
              ),

              // validator: (value){
              //   if(validation!=null){
              //     return 'field required';
              //   }
              //   return validation!(value);
              // },
              // dropdownColor: Colors.green,

              onChanged: (newVal){
                selectedVal = newVal.toString();
                print('new value is: ${selectedVal}');
              },
              items: listItems!.map((val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(val, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
          ),
        ),
        Positioned(left: 15,
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 8),
                color: labelBackColor,
                child: Text(labelText, style: AppTextStyle.label2,)))
      ],
    );
  }

}


class CustomDropDown2 extends StatelessWidget{
  CustomDropDown2({Key? key,
    this.selectedVal,
    required this.listItems,
    // required this.labelText,
    this.iconColor,
    this.validation,
    required this.hint,
  }): super(key: key);

  String? selectedVal;
  List<String>? listItems;
  // String labelText;
  String hint;
  Function? validation;
  Color? iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: DropdownButtonFormField(
        // borderRadius: BorderRadius.circular(5),
        style: AppTextStyle.hintText,
        // TextStyle(color: Colors.grey.shade700),
        elevation: 2,
        hint: Text(hint.toString(), style: AppTextStyle.hintText),
        value: selectedVal,
        icon: Icon(Icons.expand_more_outlined, color: iconColor),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
        ),
        validator: (value){
          if(validation!=null){
            return validation!(value);
          }
          return "";
        },
        // dropdownColor: Colors.green,
        onChanged: (newVal){
          selectedVal = newVal.toString();
          print(selectedVal);
        },
        items: listItems!.map((val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val, style: TextStyle(color: Colors.black)),
          );
        }).toList(),
      ),
    );
  }

}