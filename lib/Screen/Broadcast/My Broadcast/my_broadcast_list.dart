import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/Controller/broadcast_controller.dart';
import 'package:kawawa_motors/Screen/PopUp/delete_broadcast_popup.dart';

import '../../../Model/my_broadcast_model.dart';

class MyBroadcastList extends StatelessWidget {
  MyBroadcastList({Key? key, required this.myBroadcasts}) : super(key: key);

  MyBroadcasts myBroadcasts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
          decoration: BoxDecoration(
            color: ColorConst.label,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15))
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Broadcast Type: ${myBroadcasts.broadcastType}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17)),
              GestureDetector(onTap: (){
                Get.bottomSheet(DeleteBroadcast(broadcastID: myBroadcasts.broadcastId!));
                // broadcastController.deleteBroadcastData(bID: myBroadcasts.broadcastId!);
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0x40FFFFFF),
                  child: SvgPicture.asset(ImageConst.del, height: 25),
                ),
              )
            ],
          ),
        ),
        Container(padding: const EdgeInsets.all(15).copyWith(left: 30),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(myBroadcasts.broadcastText!,
              style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 25),
              Text('${DateFormat.yMMMMd().format(DateTime.parse(myBroadcasts.postedAt.toString()))}, ${DateFormat.jm().format(DateTime.parse(myBroadcasts.postedAt.toString()).toLocal())}', style: AppTextStyle.dateTime)
            ],
          ),
        )
      ],
    );
  }
}
