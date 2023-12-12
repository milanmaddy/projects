import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constraints/color_const.dart';
import '../Constraints/text_style.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({Key? key,
    required this.controller,
    required this.prefixIcon,
    // required this.hint,
    this.type = TextInputType.text,
    this.inputAction,
    this.label,
    this.validation,
    this.readOnly = false,
    this.obsecure = false,
    this.maxLine = 1,
    this.iF,
    this.suffixIcon = ""}) : super(key: key);
  String prefixIcon;
  String suffixIcon;
  String? label;
  // String hint;
  int maxLine;
  bool readOnly;
  bool obsecure;
  TextEditingController controller;
  TextInputType type;
  TextInputAction? inputAction;
  Function? validation;
  List<TextInputFormatter>? iF;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      obscureText: obsecure,
      maxLines: maxLine,
      controller: controller,
      keyboardType: type,
      obscuringCharacter: '●',
      mouseCursor: MouseCursor.defer,
      inputFormatters: iF,
      validator: (value){
        if(validation!=null){
          return validation!(value);
        }
        return "";
      },
      style: const TextStyle(),
      // cursorColor: ColorConst.primary,
      textInputAction: inputAction,
      decoration:
      InputDecoration(
        labelText: label,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),

          floatingLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorConst.label),
          errorStyle: const TextStyle(),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),

          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2)),
          // OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.red, width: 2,  style: BorderStyle.solid)),
          // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),

          hintText: '',
          hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey, height: 2),
      ),
    );
  }
}