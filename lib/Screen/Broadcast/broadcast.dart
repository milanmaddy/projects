import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/broadcast_controller.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/icon_dropdown.dart';

class Broadcast extends StatelessWidget {
  Broadcast({Key? key}) : super(key: key);

  var type = ''.obs;
  String bType = '';
  var listItems = ['all', 'vehicle', 'spare-part', 'garage'];

  RxString selectedValue = 'all'.obs;
  BroadcastController broadcastController = Get.put(BroadcastController());
  MeController meController = Get.put(MeController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConst.back,
      appBar: CustomAppBar(title: 'Broadcasts'),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          controller: broadcastController.scrollController,
          physics: const BouncingScrollPhysics(),
          child: GetBuilder(
            init: broadcastController,
            initState: (controller){
              broadcastController.getBroadcastListData(showLoader: false);
              // broadcastController.update();
            },
              builder: (value){
                return broadcastController.broadcastModel.value.data == null?
                    SizedBox(
                      height: Get.height,
                      child: PRLoader.normalLoader(),
                    ):
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconDropdownPopup(
                        enablePopup: true,
                        selected: type,
                        titleList: ['All', 'Vehicles', 'Spare Parts', 'Garages'],
                        apiList: ['all', 'vehicle', 'spare-part', 'garage'],
                        function: (type){
                          bType = type;
                          print(bType);
                          broadcastController.getBroadcastListData(type: bType, showLoader: true);
                        },
                        hintText: 'All',
                        img: ImageConst.city,),
                      // DropdownButtonFormField<String>(
                      //   value: selectedValue.value,
                      //   onChanged: (newValue) {
                      //     selectedValue.value = newValue!;
                      //   },
                      //   decoration: InputDecoration(
                      //     contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      //     filled: true,
                      //     fillColor: Colors.transparent,
                      //     prefixIcon: Padding(
                      //       padding: const EdgeInsets.only(right: 10),
                      //       child: Container(
                      //           padding: const EdgeInsets.all(10),
                      //           decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: Colors.white,
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                     color: Colors.grey.shade500,
                      //                     spreadRadius: 1,
                      //                     blurRadius: 2,
                      //                     offset: const Offset(0, 2)
                      //                 )
                      //               ]
                      //           ),
                      //           child: SvgPicture.asset(ImageConst.city, height: 18)
                      //       ),
                      //     ),
                      //     enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      //     focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      //   ),
                      //   borderRadius: BorderRadius.circular(5),
                      //   // style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'SF', fontSize: 20),
                      //   icon: const Icon(Icons.expand_more_outlined, color: Colors.black,),
                      //   // hint: Text('Please select Account Type', style: TextStyle(color: Colors.black),),
                      //   items: listItems
                      //       .map((value) => DropdownMenuItem<String>(
                      //       value: value,
                      //       onTap: (){
                      //         type.value = value;
                      //         broadcastController.getBroadcastListData(type: type.value);
                      //         print('gg ${type.value}');
                      //       },
                      //       child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500),))).toList(),
                      // ),
                      const Divider(height: 30, thickness: 1.5, color: Colors.grey),
                      const SizedBox(height: 10),
                      // SvgPicture.asset(ImageConst.noResult),
                      broadcastController.broadcastModel.value.data!.broadcasts!.isEmpty?
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child:
                            Stack(
                              children: [
                                SvgPicture.asset(ImageConst.noResult, height: 350),
                                const Positioned(right: 0, left: 0, bottom: 0,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
                                      SizedBox(height: 5),
                                      Text("I can't find what you are looking", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                                    ],
                                  ),
                                )
                              ],
                            )
                          // Text('No Data Found', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: ColorConst.label),),
                        ),
                      ):
                      ListView.builder(
                          shrinkWrap: true,
                          physics:  const NeverScrollableScrollPhysics(),
                          itemCount: value.broadcastModel.value.data!.broadcasts!.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Column(
                                children: [
                                  Container(padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: ColorConst.label,
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15))
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Broadcast Type: ${value.broadcastModel.value.data!.broadcasts![index].broadcastType}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17)),

                                      ],
                                    ),
                                  ),
                                  Container(padding: const EdgeInsets.all(15).copyWith(left: 30),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
                                    ),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${value.broadcastModel.value.data!.broadcasts![index].broadcastText}',
                                            style: const TextStyle(fontSize: 17)),
                                        const SizedBox(height: 25),
                                        Text('${DateFormat.yMMMMd().format(DateTime.parse(value.broadcastModel.value.data!.broadcasts![index].postedAt.toString()))}, ${DateFormat.jm().format(DateTime.parse(value.broadcastModel.value.data!.broadcasts![index].postedAt.toString()).toLocal())}', style: AppTextStyle.dateTime)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
