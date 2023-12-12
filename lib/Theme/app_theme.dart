import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';

ThemeData lightThemeData(BuildContext context){
  return ThemeData(
    primaryColor: Colors.white,
    // ColorConst.primary,
    colorScheme:  ColorScheme.light(
        primary: ColorConst.blue1, secondary: Colors.black),
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    fontFamily: "SF",
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: Color.fromARGB(255, 112, 112, 112),
    canvasColor: Colors.white,
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    errorColor: Colors.red,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    tabBarTheme: const TabBarTheme(
      //unselectedLabelStyle: AppTextStyle.normalGrey12,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      // labelStyle: AppTextStyle.normalBlack12,
    ),
  );
}