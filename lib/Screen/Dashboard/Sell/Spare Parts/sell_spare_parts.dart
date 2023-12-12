import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/sp_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Spare%20Parts/sell_spare_parts_list.dart';
import '../../../../Constraints/image_const.dart';
import 'package:get/get.dart';

import '../../../../Controller/see_all_controller.dart';
import '../../../../GlobalWidgets/loader.dart';

class SellSP extends StatelessWidget {
  SellSP({Key? key}) : super(key: key);

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController(type: 'msp'));
  AddController addController = Get.put(AddController());
  SparePartsController spController = Get.put(SparePartsController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Spare Parts'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        controller: seeAllController.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            children: [
              GestureDetector(onTap: (){
                spController.spModel.value.data = null;
                addController.uploadedPicture.value = '';
                addController.selectedImages = [];
                Get.toNamed(AppRoute.addSP, arguments: 'add');
                },
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Create', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConst.label)),
                    const SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios_rounded, color: ColorConst.label, size: 15)
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GetBuilder(
                  init: seeAllController,
                  initState: (controller){
                    seeAllController.getMySparePartsListData();
                  },
                  builder: (value){
                    return  seeAllController.mySparePartsList.value.data == null?
                    SizedBox(height: Get.height,
                        child: PRLoader.normalLoader()):
                    seeAllController.mySparePartsList.value.data!.spareParts!.isEmpty?
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child:
                          Stack(
                            children: [
                              SvgPicture.asset(ImageConst.noSP, height: 350),
                              const Positioned(right: 0, left: 0, bottom: 30,
                                child: Center(child: Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25))),
                              )
                            ],
                          )
                      ),
                    ):
                    ListView.builder(
                        shrinkWrap: true,
                        physics:  const NeverScrollableScrollPhysics(),
                        itemCount: value.mySparePartsList.value.data!.spareParts!.length,
                        itemBuilder: (context, index){
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SellSPList(spareParts: value.mySparePartsList.value.data!.spareParts![index]),
                          );
                        }
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
