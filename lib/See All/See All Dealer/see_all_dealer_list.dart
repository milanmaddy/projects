import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Model/see_all_dealer_model.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/trim_name.dart';

class SeeAllDealerList extends StatelessWidget {
  SeeAllDealerList({Key? key, required this.dealers}) : super(key: key);

  Businesses dealers;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){Get.toNamed(AppRoute.dealerDetails, arguments: dealers.userId);},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              dealers.businessAccount!.businessLogoUrl == ''?
              CircleAvatar(
                radius: 50,
              backgroundColor: //Colors.red,
              Color(int.parse(dealers.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                child: Center(
                  child: Text(TrimName.getInitials(dealers.businessAccount!.businessName!.toUpperCase()),
                      style: TextStyle(color: Color(int.parse(dealers.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                        fontWeight: FontWeight.w600, fontSize: 27

                      ),
                  ),
                ),
              ):
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(dealers.businessAccount!.businessLogoUrl!),
              ),
              VerticalDivider(width: 40, color: Colors.grey.shade300, thickness: 2, indent: 5, endIndent: 5),
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 240,
                      child: Text(dealers.businessAccount!.businessName!, style: AppTextStyle.header, overflow: TextOverflow.ellipsis)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(ImageConst.call),
                      const SizedBox(width: 7),
                      SizedBox(width: 240,
                          child: Text('${dealers.businessAccount!.businessPhoneCountryCode} ${
                              dealers.businessAccount!.businessPhoneNumber == ''?
                              dealers.phoneNumber:dealers.businessAccount!.businessPhoneNumber
                          } / ${dealers.phoneCountryCode} ${dealers.phoneNumber!}', style: AppTextStyle.details, overflow: TextOverflow.ellipsis,))
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageConst.mail),
                      const SizedBox(width: 7),
                      SizedBox(width: 240,
                          child: Text(dealers.emailAddress!, style: AppTextStyle.details, overflow: TextOverflow.ellipsis,))
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageConst.web),
                      const SizedBox(width: 7),
                      SizedBox(width: 240,
                        child: Text(dealers.businessAccount!.websiteUrl == null || dealers.businessAccount!.websiteUrl == ''?
                            'N/A':dealers.businessAccount!.websiteUrl.toString(), style: AppTextStyle.details, overflow: TextOverflow.ellipsis),
                      )
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
