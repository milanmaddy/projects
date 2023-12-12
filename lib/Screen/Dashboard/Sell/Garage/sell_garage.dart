import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/garage_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Garage/sell_garage_list.dart';
import 'package:get/get.dart';
import '../../../../Constraints/image_const.dart';
import '../../../../GlobalWidgets/loader.dart';

class SellGarage extends StatelessWidget {
  SellGarage({Key? key}) : super(key: key);

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController(type: 'mg'));
  AddController addController = Get.put(AddController());
  GarageController garageController = Get.put(GarageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Garage'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        controller: seeAllController.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            children: [
              GestureDetector(onTap: (){
                garageController.garageModel.value.data = null;
                addController.uploadedPicture.value = '';
                addController.uploadedLogo.value = '';
                addController.selectedImages = [];
                Get.toNamed(AppRoute.addGarage, arguments: 'add');
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
                    seeAllController.getMyGarageListData();
                  },
                  builder: (value){
                    return  seeAllController.myGarageList.value.data == null?
                    SizedBox(height: Get.height,
                        child: PRLoader.normalLoader()):
                    seeAllController.myGarageList.value.data!.garages!.isEmpty?
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child:
                          Stack(
                            children: [
                              SvgPicture.asset(ImageConst.noGarage, height: 350),
                              const Positioned(right: 0, left: 0, bottom: 30,
                                child: Center(child: Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25))),
                              )
                            ],
                          )
                        // Text('No Data Found', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: ColorConst.label),)
                      ),
                    ):
                    ListView.builder(
                        shrinkWrap: true,
                        physics:  const NeverScrollableScrollPhysics(),
                        itemCount: value.myGarageList.value.data!.garages!.length,
                        itemBuilder: (context, index){
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SellGarageList(garages: value.myGarageList.value.data!.garages![index]),
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
