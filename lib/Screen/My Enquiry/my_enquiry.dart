import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/enquiry_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'package:kawawa_motors/Screen/My%20Enquiry/my_enquiry_list.dart';

import '../../Constraints/image_const.dart';
import '../../Controller/me_controller.dart';
import '../../GlobalWidgets/icon_dropdown.dart';

class MyEnquiry extends StatelessWidget {
  MyEnquiry({Key? key}) : super(key: key);

  EnquiryController enqController = Get.put(EnquiryController());
  MeController meController = Get.put(MeController());

  var type = ''.obs;
  String valType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Enquiry'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: enqController.scrollController,
        child: Padding(padding: const EdgeInsets.all(30),
          child: GetBuilder(
            init: enqController,
            initState: (controller){
              enqController.myEnquiryListData(enquiryType: 'all', showLoader: false);
            },
            builder: (value){
              return enqController.myEnqModel.value.data == null?
                  SizedBox(
                    height: Get.height,
                    child: PRLoader.normalLoader(),
                  ):
              Column(
                children: [
                  IconDropdownPopup(
                    enablePopup: true,
                    selected: type,
                    hintText: 'All ',
                    titleList: ['All', 'Vehicles', 'Spare Parts', 'Garages'],
                    apiList: ['all', 'vehicle', 'spare-part', 'garage'],
                    function: (valueType){
                      valType = valueType;
                      print(valType);
                      print(type.value);
                      enqController.myEnquiryListData(enquiryType: valType);
                    },

                    img: ImageConst.city,
                  ),
                  const Divider(height: 30),
                  const SizedBox(height: 10),
                  enqController.myEnqModel.value.data!.enquiries!.isEmpty?
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child:
                        Stack(
                          children: [
                            SvgPicture.asset(ImageConst.noResult, height: 350),
                            const Positioned(right: 0, left: 0, bottom: 20,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
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
                      itemCount: value.myEnqModel.value.data!.enquiries!.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: MyEnquiryList(enquiries: value.myEnqModel.value.data!.enquiries![index],),
                        );
                      }
                  ),
                ],
              );
            },
          )
        ),
      ),
    );
  }
}
