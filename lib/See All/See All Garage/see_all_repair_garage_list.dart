import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Model/see_all_garage_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';

class SeeAllRepairGarageList extends StatelessWidget {
  SeeAllRepairGarageList({Key? key, required this.garages}) : super(key: key);

  // String car;
  Garages garages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){Get.toNamed(AppRoute.garageDetails, arguments: garages.garageId);},
      child: Container(
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
                radius: 50,
                backgroundColor: Color(int.parse(garages.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
              ):
              CircleAvatar(
                radius: 50,
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
                      Text(garages.user!.phoneNumber!, style: AppTextStyle.details)
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageConst.mail),
                      const SizedBox(width: 7),
                      Text(garages.user!.emailAddress!, style: AppTextStyle.details)
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageConst.web),
                      const SizedBox(width: 7),
                      SizedBox(width: 200,
                        child: Text(garages.websiteUrl == null?
                            'N/A':garages.websiteUrl.toString(), style: AppTextStyle.details, overflow: TextOverflow.ellipsis),
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
    );
  }
}
