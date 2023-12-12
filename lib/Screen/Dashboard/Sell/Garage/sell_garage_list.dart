import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/garage_controller.dart';
import 'package:kawawa_motors/Model/my_garage_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../../../Constraints/image_const.dart';
import '../../../../Constraints/text_style.dart';
import '../../../PopUp/delete_popup.dart';

class SellGarageList extends StatelessWidget {
  SellGarageList({Key? key, required this.garages}) : super(key: key);

  AddController addController = Get.put(AddController());
  GarageController garageController = Get.put(GarageController());

  Garages garages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      garageController.garageModel.value.data = null;
      Get.toNamed(AppRoute.garageDetails, arguments: garages.garageId);
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  garages.garagePrimaryImageUrl == null?
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(int.parse(garages.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                  ):
                  CircleAvatar(
                      radius: 45,
                      // backgroundColor: Color(int.parse(garages.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                      backgroundImage: NetworkImage(garages.garagePrimaryImageUrl!)
                    // AssetImage(ImageConst.g1),
                  ),
                  VerticalDivider(width: 40, color: Colors.grey.shade300, thickness: 2, indent: 5, endIndent: 5),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(garages.garageName!, style: AppTextStyle.header),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConst.call),
                          const SizedBox(width: 7),
                          Text(garages.contactPersonNumber!, style: AppTextStyle.details)
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConst.mail),
                          const SizedBox(width: 7),
                          Text(garages.contactPersonEmail!, style: AppTextStyle.details)
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConst.web),
                          const SizedBox(width: 7),
                          SizedBox(width: 240,
                            child: Text(garages.websiteUrl == null?
                            'N/A':garages.websiteUrl.toString(), style: AppTextStyle.details, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConst.pin),
                          const SizedBox(width: 7),
                          Text('${garages.city!.cityName}, ${garages.state!.stateName}, ${garages.country!.countryName}', style: AppTextStyle.details)
                        ],
                      ),

                    ],
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
        garageController.garageModel.value.data = null;
        addController.selectedImages = [];
        Get.toNamed(AppRoute.addGarage, arguments: garages.garageId!);
        break;
      case 'Delete':
        Get.bottomSheet(DeleteItemPopup(type: 'Garage', id: garages.garageId!, deleteFrom: 'G',));
        // vehicleController.deleteVehicle(vehicleID: vehicles.vehicleId!);
        break;
    }
  }
}
