import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/see_all_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Vehicle/sell_vehicle_list.dart';
import 'package:get/get.dart';
import '../../../../Constraints/image_const.dart';
import '../../../../GlobalWidgets/loader.dart';

class SellVehicle extends StatelessWidget {
  SellVehicle({Key? key}) : super(key: key);

  SeeAllAndListController seeAllController = Get.put(SeeAllAndListController(type: 'mv'));
  AddController addController = Get.put(AddController());
  VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Vehicles'),
      backgroundColor: ColorConst.back,
      body: SingleChildScrollView(
        controller: seeAllController.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            children: [
              GestureDetector(onTap: (){
                vehicleController.vehicleModel.value.data = null;
                addController.uploadedPicture.value = '';
                addController.uploadedLogo.value = '';
                addController.selectedImages = [];
                Get.toNamed(AppRoute.addCar, arguments: 'add');},
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Create', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConst.label)),
                    const SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios_rounded, color: ColorConst.label, size: 15)
                  ],
                ),
              ),
              const SizedBox(height: 15),

              GetBuilder(
                init: seeAllController,
                initState: (controller){
                  seeAllController.getMyVehicleListData();
                },
                  builder: (value){
                    return  seeAllController.myVehicleList.value.data == null?
                    SizedBox(height: Get.height,
                        child: PRLoader.normalLoader()):
                        seeAllController.myVehicleList.value.data!.vehicles!.isEmpty?
                        Center(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child:
                              Stack(
                                children: [
                                  SvgPicture.asset(ImageConst.noVehicle, height: 350),
                                  const Positioned(right: 0, left: 0, bottom: 30,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
                                        // SizedBox(height: 5),
                                        // Text("I can't find what you are looking", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
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
                        itemCount: value.myVehicleList.value.data!.vehicles!.length,
                        itemBuilder: (context, index){
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SellVehicleList(vehicles: value.myVehicleList.value.data!.vehicles![index]),
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
