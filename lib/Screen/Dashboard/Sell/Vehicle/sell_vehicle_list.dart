import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';
import 'package:kawawa_motors/Model/my_vehicle_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import 'package:kawawa_motors/Screen/PopUp/delete_popup.dart';
import '../../../../Constraints/text_style.dart';

class SellVehicleList extends StatelessWidget {
  SellVehicleList({Key? key, required this.vehicles}) : super(key: key);
  VehicleController vehicleController = Get.put(VehicleController());
  AddController addController = Get.put(AddController());

  String getFirstWords(String sentence, int wordCounts) {
    return sentence.split(" ").sublist(0, wordCounts).join(" ");
  }

  Vehicles vehicles;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      vehicleController.vehicleModel.value.data = null;
      Get.toNamed(AppRoute.carDetails, arguments: vehicles.vehicleId);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                      child:
                      Image.network(vehicles.vehiclePrimaryImageUrl!,
                        height: 115,
                        width: 130,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(ImageConst.noimage, height: 115, width: 130, fit: BoxFit.cover);
                        },
                      )
                  ),
                  // VerticalDivider(width: 40, color: Colors.grey.shade300, thickness: 2, indent: 5, endIndent: 5),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 250,
                            child: Text('${vehicles.maker!.carMakerName} - ${vehicles.model!.carModelName}', style: AppTextStyle.header, overflow: TextOverflow.ellipsis)),
                        const SizedBox(height: 10),
                        Text('${vehicles.carFuelType!.carFuelTypeName!} | '
                            '${vehicles.engineSize!.carEngineSizeName!} | '
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
                        Text('Mileage : ${vehicles.mileage!} mph', style: AppTextStyle.details),
                        Text('${getFirstWords(vehicles.user!.role!.roleName!, 1)} Seller', style: AppTextStyle.details),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
          Positioned(right: 0, top: 2,
            child: PopupMenuButton<String>(
              onSelected: handleClick,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none
              ),

              itemBuilder: (BuildContext context) {
                return {'Edit', 'Delete'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }
  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        vehicleController.vehicleModel.value.data = null;
        addController.selectedImages = [];
        Get.toNamed(AppRoute.addCar, arguments: vehicles.vehicleId);
        break;
      case 'Delete':
        Get.bottomSheet(DeleteItemPopup(type: 'Vehicle', id: vehicles.vehicleId!, deleteFrom: 'V',));
        // vehicleController.deleteVehicle(vehicleID: vehicles.vehicleId!);
        break;
    }
  }
}
