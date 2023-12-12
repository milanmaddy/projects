import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/dropdown_controller.dart';

import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';

class BottomPopup extends StatelessWidget {
  BottomPopup({Key? key,
    required this.titleList,
    required this.objectList,
    required this.function,
    required this.selected,
    required this.hintText,
    required this.searchController,
  }) : super(key: key);

  List<dynamic> objectList;
  List<String> titleList;
  Function function;
  RxString selected;
  String hintText;
  TextEditingController searchController;

  DropDownController dropController = Get.put(DropDownController());
  // TextEditingController searchController = Get.put(TextEditingController());

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
              hintText == 'All'?
              Text('Select Broadcast Type'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              hintText == 'Type '?
              Text('Select Enquiry Type'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)):
              // hintText == 'Type'?
              Text('Select $hintText'.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
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
                        dropController.emptyList = objectList;
                        dropController.searchList = titleList;
                        dropController.temporaryList = titleList;
                      },
                      builder: (val){
                        return ListView.builder(
                            itemCount: dropController.searchList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  child: Container(padding: const EdgeInsets.symmetric(vertical: 12). copyWith(left: 10),
                                      color: selected.value == dropController.searchList[index]?
                                      ColorConst.select: Colors.transparent,
                                      child: Text(dropController.searchList[index], style: const TextStyle(fontSize: 18),)),
                                  onTap: () {
                                    selected.value = dropController.searchList[index];
                                    int i = dropController.temporaryList.indexOf(selected.value);
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

