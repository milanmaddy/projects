import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Routes/app_route.dart';

import '../../GlobalWidgets/trim_name.dart';
import '../../Model/notification_list_model.dart';

class NotificationList extends StatelessWidget {
  NotificationList({Key? key, required this.notification}) : super(key: key);

  Notificationn notification;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          notification.from!.profileImageUrl == null || notification.from!.profileImageUrl == ''?
          Container(padding: const EdgeInsets.all(7),
            height: 60, width: 60,
            decoration: BoxDecoration(
              color: Color(int.parse(notification.from!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                ),
              ]
            ),
            child: Center(
              child: Text(TrimName.getInitials(notification.from!.fullName!.toUpperCase()),
                style: TextStyle(color: Color(int.parse(notification.from!.userColor!.userNameColorHexCode!.replaceFirst('#', '0XFF'))),
                    fontWeight: FontWeight.w600, fontSize: 27

                ),
              ),
            ),
          ):
          Container(padding: const EdgeInsets.all(7),
            height: 60, width: 60,
            decoration: BoxDecoration(
                color: Color(int.parse(notification.from!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(notification.from!.profileImageUrl!), fit: BoxFit.cover
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  ),
                ]

            ),
            // child: Image.asset(ImageConst.logo2, height: 55),
          ),
          const SizedBox(width: 15),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 330,
                child:
                // notification.notificationType == 'like'?
                // notification.from!.businessAccount != null?
                // notification.productDetails == null?
                // RichText(
                //     text: TextSpan(
                //         style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                //         children: [
                //           // TextSpan(text:"${notification.from!.businessAccount!.businessName} ", style: TextStyle(fontWeight: FontWeight.w600),
                //           //     recognizer: TapGestureRecognizer()..onTap = (){
                //           //       if(notification.from!.role!.roleName == 'Business'){
                //           //         Get.toNamed(AppRoute.dealerDetails, arguments: notification.fromUserId);
                //           //       }
                //           //     }
                //           // ),
                //           TextSpan(text:"${notification.message}"),
                //         ]
                //     )
                // ):
                // RichText(
                //     text: TextSpan(
                //         style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                //         children: [
                //           // TextSpan(text:"${notification.from!.businessAccount!.businessName} ",
                //           //     style: TextStyle(fontWeight: FontWeight.w600),
                //           //     recognizer: TapGestureRecognizer()..onTap = (){
                //           //       if(notification.from!.role!.roleName == 'Business'){
                //           //         Get.toNamed(AppRoute.dealerDetails, arguments: notification.fromUserId);
                //           //       }
                //           //     }
                //           // ),
                //           TextSpan(text:"${notification.message} "),
                //           TextSpan(text:"${notification.productDetails}", style: TextStyle(fontWeight: FontWeight.w600),
                //               recognizer: TapGestureRecognizer()..onTap = (){
                //                 if(notification.type == 'vehicle'){
                //                   Get.toNamed(AppRoute.carDetails, arguments: notification.link);
                //                 }else if(notification.type == 'repair-garage'){
                //                   Get.toNamed(AppRoute.garageDetails, arguments: notification.link);
                //                 }else if(notification.type == 'spare-part'){
                //                   Get.toNamed(AppRoute.spDetails, arguments: notification.link);
                //                 }
                //               }
                //           ),
                //         ]
                //     )
                // ):
                // notification.productDetails == null?
                // RichText(
                //     text: TextSpan(
                //         style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                //         children: [
                //           // TextSpan(text:"${notification.from!.fullName} "),
                //           TextSpan(text:"${notification.message}"),
                //         ]
                //     )
                // ):
                // RichText(
                //     text: TextSpan(
                //         style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                //         children: [
                //           // TextSpan(text:"${notification.from!.fullName} ", ),
                //           TextSpan(text:"${notification.message} "),
                //           TextSpan(text:"${notification.productDetails}", style: TextStyle(fontWeight: FontWeight.w600),
                //               recognizer: TapGestureRecognizer()..onTap = (){
                //                 if(notification.type == 'vehicle'){
                //                   Get.toNamed(AppRoute.carDetails, arguments: notification.link);
                //                 }else if(notification.type == 'repair-garage'){
                //                   Get.toNamed(AppRoute.garageDetails, arguments: notification.link);
                //                 }else if(notification.type == 'spare-part'){
                //                   Get.toNamed(AppRoute.spDetails, arguments: notification.link);
                //                 }
                //               }
                //           ),
                //         ]
                //     )
                // ):
                notification.from!.businessAccount != null?
                notification.productDetails == null?
                RichText(
                    text: TextSpan(
                        style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                        children: [
                          TextSpan(text:"${notification.from!.businessAccount!.businessName} ", style: TextStyle(fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              if(notification.from!.role!.roleName == 'Business'){
                                Get.toNamed(AppRoute.dealerDetails, arguments: notification.fromUserId);
                              }
                            }
                          ),
                          TextSpan(text:"${notification.message}"),
                        ]
                    )
                ):
                RichText(
                    text: TextSpan(
                        style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                        children: [
                          TextSpan(text:"${notification.from!.businessAccount!.businessName} ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()..onTap = (){
                            if(notification.from!.role!.roleName == 'Business'){
                              Get.toNamed(AppRoute.dealerDetails, arguments: notification.fromUserId);
                            }
                            }
                          ),
                          TextSpan(text:"${notification.message} "),
                          TextSpan(text:"${notification.productDetails}", style: TextStyle(fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                if(notification.type == 'vehicle'){
                                  Get.toNamed(AppRoute.carDetails, arguments: notification.link);
                                }else if(notification.type == 'repair-garage'){
                                  Get.toNamed(AppRoute.garageDetails, arguments: notification.link);
                                }else if(notification.type == 'spare-part'){
                                  Get.toNamed(AppRoute.spDetails, arguments: notification.link);
                                }
                              }
                          ),
                        ]
                    )
                ):
                notification.productDetails == null?
                RichText(
                    text: TextSpan(
                        style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                        children: [
                          TextSpan(text:"${notification.from!.fullName} "),
                          TextSpan(text:"${notification.message}"),
                        ]
                    )
                ):
                RichText(
                    text: TextSpan(
                        style: TextStyle(fontFamily: 'SF', color: ColorConst.blue1, fontSize: 16),
                        children: [
                          TextSpan(text:"${notification.from!.fullName} ", ),
                          TextSpan(text:"${notification.message} "),
                          TextSpan(text:"${notification.productDetails}", style: TextStyle(fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                if(notification.type == 'vehicle'){
                                  Get.toNamed(AppRoute.carDetails, arguments: notification.link);
                                }else if(notification.type == 'repair-garage'){
                                  Get.toNamed(AppRoute.garageDetails, arguments: notification.link);
                                }else if(notification.type == 'spare-part'){
                                  Get.toNamed(AppRoute.spDetails, arguments: notification.link);
                                }
                              }
                          ),
                        ]
                    )
                )
              ),
              const SizedBox(height: 10),
              Text('${DateFormat.yMMMMd().format(DateTime.parse(notification.createdAt.toString()))}, ${DateFormat.jm().format(DateTime.parse(notification.createdAt.toString()).toLocal())}',
                  style: TextStyle(fontSize: 16, color: ColorConst.label, fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),

    );
  }
}
