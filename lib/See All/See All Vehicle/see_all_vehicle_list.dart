import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Model/see_all_vehicle_model.dart';

import '../../Constraints/text_style.dart';
import '../../Routes/app_route.dart';

class SeeAllVehicleList extends StatelessWidget {
  SeeAllVehicleList({Key? key, required this.vehicles}) : super(key: key);
  HomeController homeController = Get.put(HomeController());



  String getFirstWords(String sentence, int wordCounts) {
    return sentence.split(" ").sublist(0, wordCounts).join(" ");
  }

  // Future <List<int>?> compressImage(String imageUrl) async {
  //   List<int>? compressedBytes = await FlutterImageCompress.compressWithFile(imageUrl, quality: 100);
  //   return compressedBytes;
  // }

  Vehicles vehicles;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(onTap: (){Get.toNamed(AppRoute.carDetails, arguments: vehicles.vehicleId);
      print('COUNTRY ID IS: ${vehicles.country!.countryId}');
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                  child:
                  Image.network(vehicles.vehiclePrimaryImageUrl!, height: 105, width: 115, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(ImageConst.noimage, height: 105, width: 115, fit: BoxFit.cover);
                  },)
                  ),
              const SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(width: 270,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${vehicles.maker!.carMakerName} - ${vehicles.model!.carModelName}', style: AppTextStyle.header, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 10),
                      Text('${vehicles.carFuelType!.carFuelTypeName} | '
                          '${vehicles.engineSize!.carEngineSizeName} | '
                          '${DateFormat('dd-MM-yyyy').format(DateTime.parse(vehicles.manufacturingYear!))} | '
                          '${vehicles.condition!.carConditionName!}', style: AppTextStyle.details),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                              children: [
                                TextSpan(text:"${vehicles.currency![vehicles.currency!.length - 1]} ", style: AppTextStyle.details),
                                TextSpan(text:"${vehicles.price}", style: AppTextStyle.detailsBlue),
                              ]
                          )
                      ),
                      // Row(
                      //   children: [
                      //     Text('K', style: AppTextStyle.details),
                      //     Text(' 12,000,000', style: AppTextStyle.detailsBlue),
                      //   ],
                      // ),
                      Text('Mileage : ${vehicles.mileage} miles', style: AppTextStyle.details),
                      Text('${getFirstWords(vehicles.user!.role!.roleName!, 1)} Seller', style: AppTextStyle.details),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
