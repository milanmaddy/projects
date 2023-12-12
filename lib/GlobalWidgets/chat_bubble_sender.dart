import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kawawa_motors/GlobalWidgets/trim_name.dart';

import '../Constraints/color_const.dart';
import '../Constraints/image_const.dart';

class ChatBubbleSender extends StatelessWidget {
  ChatBubbleSender({Key? key,
    this.dp,
    required this.msg,
    required this.time,
    required this.image,
    required this.backHex,
    required this.name,
    required this.nameHex,
  }) : super(key: key);

  String? dp;
  String msg;
  String time;
  String image;
  String backHex;
  String? name;
  String nameHex;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(15).copyWith(right: 20),
            decoration: BoxDecoration(
                color: ColorConst.label,
                borderRadius: BorderRadius.circular(15).copyWith(bottomRight: const Radius.circular(0))
            ),
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // image == ""?
                //     SizedBox():
                // Padding(
                //   padding: EdgeInsets.only(bottom: 7),
                //   child: ClipRRect(borderRadius: BorderRadius.circular(8),
                //       child: Image.network(image)
                //       // Image.asset(ImageConst.maddy, height: 80, width: 150, fit: BoxFit.cover)
                //       // Container(height: 150, width: 80,
                //       //   decoration: BoxDecoration(
                //       //     image: DecorationImage(image: CachedNetworkImageProvider(image))
                //       //   ),
                //       // )
                //   ),
                // ),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(constraints: BoxConstraints(maxWidth: 220),
                      child: Text(msg,
                          textAlign: TextAlign.right, style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(time, style: TextStyle(fontSize: 10, color: Colors.grey.shade300, fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          dp == ''?
          CircleAvatar(
            radius: 24,
            backgroundColor: Color(int.parse(backHex.replaceFirst('#', "0XFF"))),
            // backgroundImage: NetworkImage(dp),
            child: Center(
              child: Text(TrimName.getInitials(name!.toUpperCase()),
                style: TextStyle(color: Color(int.parse(nameHex.replaceFirst('#', "0XFF"))), fontSize: 15),
              ),
            ),
          ):
          // ClipRRect(borderRadius: BorderRadius.circular(50),
          //     child: Image.network(dp, height: 40,)),
          CircleAvatar(
            radius: 24,
            // backgroundColor: Color(int.parse(backHex.replaceFirst('#', "0XFF"))),
            backgroundImage: NetworkImage(dp!),
            // child: Center(
            //   child: Text(TrimName.getInitials(name!.toUpperCase()),
            //     style: TextStyle(color: Color(int.parse(nameHex.replaceFirst('#', "0XFF"))), fontSize: 15),
            //   ),
            // ),
          )
        ]
    );
  }
}
