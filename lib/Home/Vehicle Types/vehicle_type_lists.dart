import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';

import '../../Constraints/text_style.dart';
import '../../Routes/app_route.dart';

class VehicleTypeList extends StatelessWidget {
  VehicleTypeList({Key? key}) : super(key: key);

  String getFirstWords(String sentence, int wordCounts) {
    return sentence.split(" ").sublist(0, wordCounts).join(" ");
  }

  VehicleController vehicleController = Get.put(VehicleController());
  HomeController homeController = Get.put(HomeController());

  String title = Get.arguments[0];
  String vTypeId = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    print(homeController.newCountryID);
    return Scaffold(
      backgroundColor: ColorConst.back,
      appBar: CustomAppBar(title: title),
      body: GetBuilder(
        init: vehicleController,
          initState: (controller){
            vehicleController.getVehicleTypeData(vTypeID: vTypeId, countryID: homeController.newCountryID);
          },
          builder: (value){
            return vehicleController.vehicleTypeModel.value.data == null?
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
                child: Center(child: PRLoader.normalLoader())):
            Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: vehicleController.scrollController,
                  physics:  const BouncingScrollPhysics(),
                  itemCount: value.vehicleTypeModel.value.data!.vehicles!.length,
                  itemBuilder: (context, index){
                    return  Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: GestureDetector(onTap: (){vehicleController.vehicleModel.value.data = null;
                        Get.toNamed(AppRoute.carDetails, arguments: value.vehicleTypeModel.value.data!.vehicles![index].vehicleId!);},
                        child: Container(
                          //padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                                    child:
                                    Image.network(value.vehicleTypeModel.value.data!.vehicles![index].vehiclePrimaryImageUrl!,
                                      height: 115,
                                      width: 130,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(ImageConst.noimage, height: 115, width: 130, fit: BoxFit.cover);
                                      },
                                    )
                                ),
                                // Image.asset(ImageConst.benz, height: 120, width: 150),
                                // VerticalDivider(width: 40, color: Colors.grey.shade300, thickness: 2, indent: 5, endIndent: 5),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${value.vehicleTypeModel.value.data!.vehicles![index].maker!.carMakerName!} - ${value.vehicleTypeModel.value.data!.vehicles![index].model!.carModelName!}',
                                            style: AppTextStyle.header),
                                        const SizedBox(height: 10),
                                        Text('${value.vehicleTypeModel.value.data!.vehicles![index].carFuelType!.carFuelTypeName!} | '
                                            '${value.vehicleTypeModel.value.data!.vehicles![index].engineSize!.carEngineSizeName!} | '
                                            '${DateFormat('dd-MM-yyyy').format(DateTime.parse(value.vehicleTypeModel.value.data!.vehicles![index].manufacturingYear!))} | '
                                            '${value.vehicleTypeModel.value.data!.vehicles![index].condition!.carConditionName!}', style: AppTextStyle.details),
                                        RichText(
                                            text: TextSpan(
                                                style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                                                children: [
                                                  TextSpan(text:"${value.vehicleTypeModel.value.data!.vehicles![index].currency![value.vehicleTypeModel.value.data!.vehicles![index].currency!.length - 1]} ", style: AppTextStyle.details),
                                                  TextSpan(text:"${value.vehicleTypeModel.value.data!.vehicles![index].price}", style: AppTextStyle.detailsBlue),
                                                ]
                                            )
                                        ),
                                        Text('Mileage : ${value.vehicleTypeModel.value.data!.vehicles![index].mileage!} mph', style: AppTextStyle.details),
                                        Text('${getFirstWords(vehicleController.vehicleTypeModel.value.data!.vehicles![index].user!.role!.roleName!, 1)} Seller', style: AppTextStyle.details),
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),

            );
          }
      )



      
    );
  }
}
