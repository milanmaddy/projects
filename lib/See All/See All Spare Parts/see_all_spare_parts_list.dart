import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Model/see_all_spare_parts_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../Constraints/text_style.dart';

class SeeAllSPList extends StatelessWidget {
  SeeAllSPList({Key? key, required this.spareParts}) : super(key: key);


  SpareParts spareParts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){Get.toNamed(AppRoute.spDetails, arguments: spareParts.sparePartId);},
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
                  // CachedNetworkImage(imageUrl: spareParts.sparePartPrimaryImageUrl!, height: 115, width: 130, fit: BoxFit.cover,
                  //     placeholder: (context, url) {return SizedBox(
                  //       height: Get.height, width: Get.width, child: const Center(child: CircularProgressIndicator()),
                  //     );},
                  //     errorWidget: (context, url, error) {return const Icon(Icons.error);}
                  // ),
                  Image.network(spareParts.sparePartPrimaryImageUrl!, height: 115, width: 130, fit: BoxFit.cover)
              ),
              const SizedBox(width: 15,),
              // VerticalDivider(width: 40, color: Colors.grey.shade300, thickness: 2, indent: 5, endIndent: 5),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('${spareParts.maker!.carMakerName} - ${spareParts.model!.carModelName}', style: AppTextStyle.header),
                    const SizedBox(height: 10),
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
    );
  }
}
