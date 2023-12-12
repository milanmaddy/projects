import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';

import '../../GlobalWidgets/trim_name.dart';
import '../../Model/my_enquiry_model.dart';
import '../../Routes/app_route.dart';

class MyEnquiryList extends StatelessWidget {
  MyEnquiryList({Key? key, required this.enquiries}) : super(key: key);

  Enquiries enquiries;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              color: ColorConst.label
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // enquiries.from!.businessAccount == null || enquiries.from!.businessAccount == ''?
                    // enquiries.from!.businessAccount!.businessLogoUrl == null || enquiries.from!.businessAccount!.businessLogoUrl == ''?
                    enquiries.from!.profileImageUrl == null || enquiries.from!.profileImageUrl == ''?
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(int.parse(enquiries.from!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                      // backgroundImage: AssetImage(ImageConst.applep),
                      child: Center(
                        child: enquiries.from!.fullName == "    "?
                        Text(''):
                        Text(TrimName.getInitials(enquiries.from!.fullName!.toUpperCase()),
                          style: TextStyle(color: Color(int.parse(enquiries.from!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                              fontWeight: FontWeight.w600, fontSize: 22
                          ),
                        ),
                      ),
                    ):
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(int.parse(enquiries.from!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                      backgroundImage: NetworkImage(enquiries.from!.profileImageUrl!)
                      // child: Center(
                      //   child: Text(TrimName.getInitials(enquiries.from!.fullName!.toUpperCase()),
                      //     style: TextStyle(color: Color(int.parse(enquiries.from!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                      //         fontWeight: FontWeight.w600, fontSize: 22
                      //
                      //     ),
                      //   ),
                      // ),
                    ),
                    // CircleAvatar(
                    //     radius: 30,
                    //     backgroundColor: Color(int.parse(enquiries.from!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                    //     backgroundImage: NetworkImage(enquiries.from!.businessAccount!.businessLogoUrl!)
                    // ):
                    // enquiries.from!.profileImageUrl == null || enquiries.from!.profileImageUrl == ''?
                    // CircleAvatar(
                    //   radius: 30,
                    //   backgroundColor: Color(int.parse(enquiries.from!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                    //   // backgroundImage: AssetImage(ImageConst.applep),
                    //   child: Center(
                    //     child: Text(TrimName.getInitials(enquiries.from!.fullName!.toUpperCase()),
                    //       style: TextStyle(color: Color(int.parse(enquiries.from!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                    //           fontWeight: FontWeight.w600, fontSize: 22
                    //
                    //       ),
                    //     ),
                    //   ),
                    // ):
                    // CircleAvatar(
                    //     radius: 30,
                    //     backgroundColor: Color(int.parse(enquiries.from!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                    //     backgroundImage: NetworkImage(enquiries.from!.profileImageUrl!)
                    //   // child: Center(
                    //   //   child: Text(TrimName.getInitials(enquiries.from!.fullName!.toUpperCase()),
                    //   //     style: TextStyle(color: Color(int.parse(enquiries.from!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                    //   //         fontWeight: FontWeight.w600, fontSize: 22
                    //   //
                    //   //     ),
                    //   //   ),
                    //   // ),
                    // ),
                    const SizedBox(width: 10),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                            children: [
                              enquiries.from!.businessAccount == null?
                              TextSpan(
                                  text: enquiries.from!.fullName == ''?
                                  "":
                                  "${enquiries.from!.fullName} ",
                                  style: const TextStyle(color: Colors.white, fontSize: 18)
                                // recognizer: TapGestureRecognizer()..onTap = (){
                                //   if(enquiries.from!.role!.roleName == 'Business'){
                                //     Get.toNamed(AppRoute.dealerDetails, arguments: enquiries.from!.userId);
                                //   }
                                // }
                              ):
                              TextSpan(
                                text:"${enquiries.from!.businessAccount!.businessName} ",  style: const TextStyle(color: Colors.white, fontSize: 18)
                                  // recognizer: TapGestureRecognizer()..onTap = (){
                                  //   if(enquiries.from!.role!.roleName == 'Business'){
                                  //     Get.toNamed(AppRoute.dealerDetails, arguments: enquiries.from!.userId);
                                  //   }
                                  // }
                              ),
                              const TextSpan(text: ' '),
                              enquiries.enquiryType == 'vehicle'?
                              TextSpan(
                                  text:"${enquiries.vehicle!.maker!.carMakerName} - ${enquiries.vehicle!.model!.carModelName}", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                      Get.toNamed(AppRoute.carDetails, arguments: enquiries.vehicle!.vehicleId);
                                  }
                              ):
                              enquiries.enquiryType == 'garage'?
                              TextSpan(text:"${enquiries.garage!.garageName}", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    Get.toNamed(AppRoute.garageDetails, arguments: enquiries.garage!.garageId);
                                  }
                              ):
                              TextSpan(text:"${enquiries.sparepart!.maker!.carMakerName} - ${enquiries.sparepart!.model!.carModelName}", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    Get.toNamed(AppRoute.spDetails, arguments: enquiries.sparepart!.sparePartId);
                                  }
                              ),
                            ]
                        )
                    )
                  ],
                ),
                Text(DateFormat.jm().format(DateTime.parse(enquiries.postedAt.toString()).toLocal()), style: const TextStyle(color: Colors.white, fontSize: 14),)
              ],
            ),
          ),
          Container(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                color: Colors.white
            ),
            child: enquiries.enquiryType == 'vehicle'?
            Text(enquiries.enquiryText!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)):
            enquiries.enquiryType == 'garage'?
            Text(enquiries.enquiryText!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)):
            Text(enquiries.enquiryText!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}
