import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Model/my_spare_parts_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../../../Constraints/image_const.dart';
import '../../../../Constraints/text_style.dart';
import '../../../../Controller/add_controller.dart';
import '../../../../Controller/sp_controller.dart';
import '../../../PopUp/delete_popup.dart';

class SellSPList extends StatelessWidget {
  SellSPList({Key? key, required this.spareParts}) : super(key: key);

  AddController addController = Get.put(AddController());
  SparePartsController spController = Get.put(SparePartsController());

  SpareParts spareParts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      spController.spModel.value.data = null;
      Get.toNamed(AppRoute.spDetails, arguments: spareParts.sparePartId);
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
                      Image.network(spareParts.sparePartPrimaryImageUrl!, height: 115, width: 130, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(ImageConst.noimage, height: 105, width: 115, fit: BoxFit.cover);
                        })),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 250,
                            child: Text('${spareParts.maker!.carMakerName} - ${spareParts.model!.carModelName}', style: AppTextStyle.header, overflow: TextOverflow.ellipsis)),
                        const SizedBox(height: 8),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'SF'), //style for all textspan
                                children: [
                                  TextSpan(text:"${spareParts.currency![spareParts.currency!.length - 1]} ", style: AppTextStyle.details),
                                  TextSpan(text:"${spareParts.price}", style: AppTextStyle.detailsBlue),
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                                children: [
                                  TextSpan(text:"Location: ", style: AppTextStyle.details),
                                  TextSpan(text:"${spareParts.city!.cityName}, ${spareParts.state!.stateName}, ${spareParts.country!.countryName}", style: AppTextStyle.details),
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                                children: [
                                  TextSpan(text:"Category: ", style: AppTextStyle.details),
                                  TextSpan(text:"${spareParts.category!.categoryTitle}", style: AppTextStyle.details),
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(fontFamily: 'SF', color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600), //style for all textspan
                                children: [
                                  TextSpan(text:"Sub Category: ", style: AppTextStyle.details),
                                  TextSpan(text:"${spareParts.subCategory!.subCategoryTitle}", style: AppTextStyle.details),
                                ]
                            )
                        ),
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
                    child: Text(choice, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
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
        spController.spModel.value.data = null;
        addController.selectedImages = [];
        Get.toNamed(AppRoute.addSP, arguments: spareParts.sparePartId!);
        break;
      case 'Delete':
        Get.bottomSheet(DeleteItemPopup(type: 'Spare Part', id: spareParts.sparePartId!, deleteFrom: 'SP',));
        // vehicleController.deleteVehicle(vehicleID: vehicles.vehicleId!);
        break;
    }
  }
}
