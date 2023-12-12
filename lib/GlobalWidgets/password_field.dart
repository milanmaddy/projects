import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constraints/color_const.dart';
import '../Constraints/text_style.dart';

class CustomPasswordField extends StatelessWidget {
  CustomPasswordField(
      {Key? key,
        required this.controller,
        required this.hint,
        this.prefixIcon = "",
        this.inputAction,
        this.label,
        this.letterSpace = 0,
        this.validation})
      : super(key: key);
  String prefixIcon;
  String hint;
  String? label;
  double letterSpace;
  TextEditingController controller;
  Function? validation;
  TextInputAction? inputAction;
  var visible = true.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
      controller: controller,
      validator: (value){
        if(validation!=null){
          return validation!(value);
        }
        return null;
      },

      keyboardType: TextInputType.text,
      obscureText: visible.value,
      obscuringCharacter: '*',
      style: TextStyle(letterSpacing: letterSpace),

      mouseCursor: MouseCursor.defer,
      textInputAction: inputAction,
      decoration:
      InputDecoration(

        labelText: label,
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),

        floatingLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorConst.label),
        errorStyle: const TextStyle(),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),

        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2)),
// OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.red, width: 2,  style: BorderStyle.solid)),
// UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),

        hintText: hint,
        hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey, height: 2),
          // errorStyle: const TextStyle(),
          // contentPadding: const EdgeInsets.symmetric(vertical: 20),

          suffixIcon: GestureDetector(
            onTap: (){
              visible.value=!visible.value;
            },
            child: Container(
              // height: 20,width: 20,
              // color:Colors.red,
                padding: const EdgeInsets.only(right: 10, top: 20),
                child: !visible.value?
                const Icon(Icons.visibility, size: 30): const Icon(Icons.visibility_off, size: 30)
            ),
          ),
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(6.0)),
          // enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
          //
          // hintText: hint,
          // hintStyle: AppTextStyle.hintText
      ),
    ));
  }
}