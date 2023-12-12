import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';

import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';

class BottomPopup2 extends StatelessWidget {
  BottomPopup2({Key? key,
    required this.labelText,
    required this.searchController,
    required this.controller,
    required this.objectList,
    required this.titleList,
    required this.function,

  }) : super(key: key);

  String labelText;
  TextEditingController searchController;
  TextEditingController controller;
  List<dynamic> objectList;
  List<String> titleList;
  Function function;

  DropDownController dropController = Get.put(DropDownController());

  @override
  Widget build(BuildContext context) {
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
                    child: GetBuilder(
                      init: dropController,
                      initState: (value){
                        dropController.emptyList = objectList;
                        dropController.searchList = titleList;
                        dropController.temporaryList = titleList;
                        // dropController.listItems;
                        // dropController.filterSearch(searchController.text);
                      },
                      builder: (val){
                        return ListView.builder(
                            itemCount: dropController.searchList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  child: Container(padding: const EdgeInsets.symmetric(vertical: 12). copyWith(left: 10),
                                      color: controller.text == dropController.searchList[index]?
                                      ColorConst.select: Colors.transparent,
                                      child: Text(dropController.searchList[index], style: const TextStyle(fontSize: 18))),
                                  onTap: () {
                                    // controller.text = titleList[index];
                                    // Get.back();
                                    // function(objectList[index]);
                                    controller.text = dropController.searchList[index];
                                    int i = dropController.temporaryList.indexOf(controller.text);
                                    Get.back();
                                    function(objectList[i]);


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