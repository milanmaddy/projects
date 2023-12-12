import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';
import 'package:kawawa_motors/Model/city_list_model.dart';
import 'package:kawawa_motors/Screen/PopUp/bottomsheet_popup.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import '../Constraints/color_const.dart';
import '../Constraints/image_const.dart';
import '../Constraints/text_style.dart';

class IconDropDown extends StatelessWidget{
  IconDropDown({Key? key,
    this.selectedVal,
    required this.listItems,
    required this.logo,
    // required this.labelText,
    this.iconColor,
    this.hint,
  }): super(key: key);

  String? selectedVal;
  List<String>? listItems;
  String logo;
  // String labelText;
  String? hint;
  Color? iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(left: 22),
        // width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   // color: Colors.grey,
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(color: Colors.grey.shade700)
        // ),
        child: DropdownButtonFormField(
          borderRadius: BorderRadius.circular(5),
          style: AppTextStyle.hintText,
          // TextStyle(color: Colors.grey.shade700),
          elevation: 2,
          hint: Text(hint.toString(), style: AppTextStyle.hintText),
          value: selectedVal,
          icon: Icon(Icons.expand_more_outlined, color: iconColor),
          decoration: InputDecoration(
            // filled: true,
            // fillColor: iconColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )
                      ]
                  ),
                  child: SvgPicture.asset(logo, height: 18)
                // CircleAvatar(child: SvgPicture.asset(ImageConst.speaker, height: 22),
                //   backgroundColor: Colors.white,
                //
                // ),
              ),
            ),
            // prefixIconConstraints: BoxConstraints(maxWidth: 50),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          ),
          // dropdownColor: Colors.green,
          onChanged: (newVal){
            selectedVal = newVal.toString();
            print(selectedVal);
          },
          items: listItems!.map((val) {
            return DropdownMenuItem(
              value: val,
              child: Text(val, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
        ),
      ),
    );
  }

}

class IconDropdownPopup extends StatelessWidget {
  IconDropdownPopup({Key? key,
    required this.selected,
    required this.hintText,
    required this.img,
    this.titleList,
    this.dropdownMsg,
    this.apiList,
    this.storedID,
    this.width,
    this.function,
    this.enablePopup = false,
  }) : super(key: key);


  RxString selected;
  String? storedID;
  String hintText;
  String? dropdownMsg;
  double? width;
  bool? enablePopup;
  String img;
  List<dynamic>? apiList;
  List<String>? titleList;
  // String? storedId;
  // Iterable<List>? dataList;
  Function? function;

  TextEditingController searchController = TextEditingController();
  DropDownController dropController = DropDownController();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        searchController.clear();
        dropController.listItems = dropController.emptyList;
        // dropController.searchList = titleList!;
        if(enablePopup == true){
          Get.bottomSheet(
              BottomPopup(
                titleList: titleList!,
                objectList: apiList!,
                function: function!,
                hintText: hintText,
                selected: selected,
                searchController: searchController,
              ),
              enableDrag: false, isScrollControlled: true);
        }else{Get.snackbar('ERROR', 'please select ${dropdownMsg} first', colorText: Colors.redAccent, borderRadius: 5);}
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10).copyWith(top: 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ]
                          ),
                          child: SvgPicture.asset(img, height: 18)
                        // CircleAvatar(child: SvgPicture.asset(ImageConst.speaker, height: 22),
                        //   backgroundColor: Colors.white,
                        //
                        // ),
                      ),
                      const SizedBox(width: 10),
                      Obx(() => selected.value == ''?
                      Text(hintText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),):
                      SizedBox(width: width,
                          child: Text(selected.toString(), style: const TextStyle(fontSize: 18), overflow: TextOverflow.ellipsis)),),
                    ],
                  ),
                  Icon(Icons.expand_more_outlined, color: ColorConst.label)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget POPUP(List<dynamic>objectList, function, List<String>titleList){
  //
  //   return Container(
  //     decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20))
  //     ),
  //     padding: const EdgeInsets.only(right: 10),
  //     height: 470,
  //     alignment: Alignment.center,
  //     child: Column(
  //       children: [
  //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             const SizedBox(width: 35,),
  //             hintText == 'All'?
  //             Text('Select Broadcast Type'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
  //             hintText == 'Type '?
  //             Text('Select Enquiry Type'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
  //             // hintText == 'Type'?
  //             Text('Select $hintText'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
  //             IconButton(onPressed: (){Get.back();},
  //                 icon: const Icon(Icons.cancel_rounded, size: 42)
  //             )
  //           ],
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(top: 20),
  //           child: Column(
  //             children: [
  //               TextFormField(
  //                 controller: searchController,
  //                 onChanged: (value){
  //                   dropController.filterSearch(value);
  //                 },
  //                 decoration: InputDecoration(
  //                     contentPadding: const EdgeInsets.only(left: 25).copyWith(right: 20),
  //                     hintText: 'Search',
  //                     suffixIcon: Padding(
  //                       padding: const EdgeInsets.all(10.0),
  //                       child: SvgPicture.asset(ImageConst.glass),
  //                     ),
  //                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey)),
  //                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey)),
  //                     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.grey))
  //                 ),
  //               ),
  //               const SizedBox(height: 30),
  //               SizedBox(height: 300,
  //                   child:
  //                   GetBuilder(
  //                     init: dropController,
  //                     initState: (value){
  //                       dropController.emptyList = objectList;
  //                       dropController.searchList = titleList;
  //                       dropController.temporaryList = titleList;
  //                     },
  //                     builder: (val){
  //                       return ListView.builder(
  //                           itemCount: dropController.searchList.length,
  //                           itemBuilder: (context, index) {
  //                             return GestureDetector(
  //                                 child: Container(padding: const EdgeInsets.symmetric(vertical: 12). copyWith(left: 10),
  //                                     color: selected.value == dropController.searchList[index]?
  //                                     ColorConst.select: Colors.transparent,
  //                                     child: Text(dropController.searchList[index], style: const TextStyle(fontSize: 18),)),
  //                                 onTap: () {
  //                                   selected.value = dropController.searchList[index];
  //                                   // selectedID = dropController.listItems[index];
  //                                   print('ggggggggg');
  //                                   print(titleList[index]);
  //                                   Get.back();
  //                                   function(objectList[index]);
  //                                 }
  //                             );
  //                           }
  //                       );
  //
  //                     },
  //
  //                   )
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
