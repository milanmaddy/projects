import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';

class Buttons {

  static Widget actionButtons(
      {required String title, required Function event, double height = 50, double width = 180}) {
    return ElevatedButton(
      onPressed: () async {
        await event();
      },
      style: ButtonStyle(elevation: MaterialStateProperty.all(12.0),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 30)
          ),
          shadowColor: MaterialStateProperty.all(
              ColorConst.button.withOpacity(0.8)),
          textStyle: MaterialStateProperty.all(AppTextStyle.buttonText),
          backgroundColor: MaterialStateProperty.all(ColorConst.button),
          minimumSize: MaterialStateProperty.all(Size(width, height)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide.none
            ),
          )),
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'SF', fontWeight: FontWeight.w600),),
    );
  }

  static Widget filterBtn(
      {required String title, required Function event, required String icon}) {
    return ElevatedButton(
      onPressed: () async {
        await event();
      },
      style: ButtonStyle(elevation: MaterialStateProperty.all(12.0),
          padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 30)
          ),
          shadowColor: MaterialStateProperty.all(
              ColorConst.button.withOpacity(0.8)),
          textStyle: MaterialStateProperty.all(AppTextStyle.buttonText),
          backgroundColor: MaterialStateProperty.all(ColorConst.button),
          minimumSize: MaterialStateProperty.all(Size(180, 50)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide.none
            ),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, color: Colors.white,),
          SizedBox(width: 10),
          Text(title.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'SF', fontWeight: FontWeight.w600))
        ],
      )
    );
  }

  static Widget primaryButtons(
      {required String title, required Function event, double height = 60, double width = 180}) {
    return GestureDetector(
      onTap: () async {
        await event();
      },
      // style: ButtonStyle(elevation: MaterialStateProperty.all(12.0),
      //     shadowColor: MaterialStateProperty.all(
      //         ColorConst.button.withOpacity(0.8)),
      //     textStyle: MaterialStateProperty.all(AppTextStyle.buttonText),
      //     backgroundColor: MaterialStateProperty.all(ColorConst.button),
      //     minimumSize: MaterialStateProperty.all(Size(width, height)),
      //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //       RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(22.0),
      //           side: BorderSide.none
      //       ),
      //     )),
      child: Container(
        height: 50, width: width,
        // constraints: BoxConstraints.expand(width: 250),
        decoration: BoxDecoration(
          color: ColorConst.button,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: ColorConst.button.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 2)
            )
          ]
        ),
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(title.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),),
        ))
      )
      // Text(title, style: TextStyle(color: Colors.white, fontSize: 17),),
    );
  }

  static Widget popupButton(
      {required String title, required Function event, double height = 60, double width = 180}) {
    return GestureDetector(
        onTap: () async {
          await event();
        },
        // style: ButtonStyle(elevation: MaterialStateProperty.all(12.0),
        //     shadowColor: MaterialStateProperty.all(
        //         ColorConst.button.withOpacity(0.8)),
        //     textStyle: MaterialStateProperty.all(AppTextStyle.buttonText),
        //     backgroundColor: MaterialStateProperty.all(ColorConst.button),
        //     minimumSize: MaterialStateProperty.all(Size(width, height)),
        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //       RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(22.0),
        //           side: BorderSide.none
        //       ),
        //     )),
        child: Container(
            height: 55, width: width,
            // constraints: BoxConstraints.expand(width: 250),
            decoration: BoxDecoration(
                color: ColorConst.button,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      color: ColorConst.button.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 2)
                  )
                ]
            ),
            child: Center(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(title.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),),
            ))
        )
      // Text(title, style: TextStyle(color: Colors.white, fontSize: 17),),
    );
  }

  static Widget popupButton2(
      {required String title, required Function event, double height = 50, double width = 180}) {
    return OutlinedButton(
      onPressed: () async {
        await event();
      },
      style:
      OutlinedButton.styleFrom(
        shape:
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        side: BorderSide(color: ColorConst.button, width: 2),
        // textStyle: AppTextStyle.buttonText2,
        minimumSize: Size(width, height)
      ),
      // ButtonStyle(elevation: MaterialStateProperty.all(12.0),
      //     // shadowColor: MaterialStateProperty.all(
      //     //     ColorConst.button.withOpacity(0.8)),
      //     textStyle: MaterialStateProperty.all(AppTextStyle.buttonText),
      //     backgroundColor: MaterialStateProperty.all(Colors.white),
      //     minimumSize: MaterialStateProperty.all(Size(width, height)),
      //
      //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //       RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(50.0),
      //           side: BorderSide(color: ColorConst.button, width: 2)
      //       ),
      //     )),
      child: Text(title.toUpperCase(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: ColorConst.button),),
    );
  }

}