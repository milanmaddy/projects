import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../Constraints/color_const.dart';
import '../Constraints/text_style.dart';

class CustomInputField2 extends StatelessWidget {
  CustomInputField2({Key? key,
    required this.controller,
    this.prefixIcon = '',
    this.labelText,
    this.hint,
    this.type = TextInputType.text,
    this.inputAction,
    this.validation,
    this.labelBackColor,
    this.onChanged,
    this.readOnly = false,
    this.maxLine = 1,
    this.event,
    this.iF,
    this.maxLength,
    this.suffixIcon = ""}) : super(key: key);
  String prefixIcon;
  String suffixIcon;
  String? hint;
  String? labelText;
  int maxLine;
  bool readOnly;
  Function? event;
  ValueChanged? onChanged;
  Color? labelBackColor = ColorConst.back;
  TextEditingController controller;
  TextInputType type;
  TextInputAction? inputAction;
  Function? validation;
  int? maxLength;
  List<TextInputFormatter>? iF;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      maxLines: maxLine,
      // maxLength: maxLength,
      controller: controller,
      keyboardType: type,
      mouseCursor: MouseCursor.defer,
      inputFormatters: iF,
      validator: (value){
        if(validation!=null){
          return validation!(value);
        }
        return "";
      },

      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      // cursorColor: ColorConst.primary,
      textInputAction: inputAction,
      decoration:
      InputDecoration(
        label: Text(labelText.toString()),
        // labelText: name,
        labelStyle: AppTextStyle.hintText,
        floatingLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorConst.label),
        suffixIcon: GestureDetector(onTap: ()async{await event!();},
          child: Padding(
            padding: const EdgeInsets.all(9).copyWith(right: 0),
            child: SvgPicture.asset(suffixIcon),
          ),
        ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey)),
          errorStyle: const TextStyle(),
          contentPadding: const EdgeInsets.symmetric(vertical: 18).copyWith(left: 15),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey)),
          hintText: hint,
          hintStyle: AppTextStyle.hintText,
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  PasswordField({Key? key,
    required this.controller,
    required this.prefixIcon,
    required this.name,
    required this.hint,
    required this.event,
    this.type = TextInputType.text,
    this.inputAction,
    this.validation,
    this.readOnly = false,
    this.maxLine = 1,
    this.suffixIcon = ""}) : super(key: key);
  String prefixIcon;
  String suffixIcon;
  Function event;
  String hint;
  String name;
  int maxLine;
  bool readOnly;
  TextEditingController controller;
  TextInputType type;
  TextInputAction? inputAction;
  Function? validation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            decoration: BoxDecoration(
              // color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey)
            ),
            child: TextFormField(
              readOnly: readOnly,
              maxLines: maxLine,
              controller: controller,
              keyboardType: type,
              mouseCursor: MouseCursor.defer,
              obscureText: true,
              obscuringCharacter: '*',
              validator: (value){
                if(validation!=null){
                  return validation!(value);
                }
                return "";
              },
              style: const TextStyle(color: Colors.black, fontSize: 25),
              // cursorColor: ColorConst.primary,
              textInputAction: inputAction,
              decoration:
              InputDecoration(
                // label: Text('hhhh'),
                // filled: true,
                // fillColor: Colors.red,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 14, right: 10),
                  child: GestureDetector(
                    onTap: () async {
                      await event();
                      },
                    child: Text('Change Password?', style: AppTextStyle.label),

                  ),
                ),
                errorStyle: const TextStyle(),
                contentPadding: const EdgeInsets.only(left: 6, top: 14),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConst.back, width: 2)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConst.back, width: 2)),
                hintText: hint,
                hintStyle: AppTextStyle.hintText,
              ),
            ),
          ),
        ),
        Positioned(left: 15,
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 8),
                color: ColorConst.back,
                child: Text(name, style: AppTextStyle.label)))
      ],
    );
  }
}