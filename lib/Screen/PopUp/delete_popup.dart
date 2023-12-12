import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kawawa_motors/Controller/garage_controller.dart';
import 'package:kawawa_motors/Controller/sp_controller.dart';

import '../../Constraints/text_style.dart';
import '../../Controller/vehicle_controller.dart';
import '../../GlobalWidgets/buttons.dart';

class DeleteItemPopup extends StatelessWidget {
  DeleteItemPopup({Key? key, required this.type, required this.id, required this.deleteFrom}) : super(key: key);

  VehicleController vehicleController = Get.put(VehicleController());
  SparePartsController spController = Get.put(SparePartsController());
  GarageController garageController = Get.put(GarageController());

  String type;
  String id;
  String deleteFrom;

  @override
  Widget build(BuildContext context) {
    return Container(height: 320,
      padding: const EdgeInsets.all(15).copyWith(bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 35,),
              Text('Delete $type', style: AppTextStyle.black18_700),
              IconButton(onPressed: (){Get.back();},
                  icon: const Icon(Icons.cancel_rounded, size: 42)
              )
            ],
          ),
          const SizedBox(height: 50),
          Text('Are you sure you want to delete\nthe ${type.toLowerCase()}?', textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 23)),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Buttons.popupButton2(title: 'No', event: (){Get.back();}, width: 250)),
                const SizedBox(width: 30),
                Expanded(child: Buttons.popupButton(title: 'Yes', event: (){
                  Get.back();
                  if(deleteFrom == 'SP'){
                    spController.deleteSparePart(spID: id);
                  }else if(deleteFrom == 'V'){
                    vehicleController.deleteVehicle(vehicleID: id);
                  }else if(deleteFrom == 'G'){
                    garageController.deleteGarage(garageID: id);
                  }
                }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
