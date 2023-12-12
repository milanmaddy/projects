import 'package:flutter/material.dart';

import '../Constraints/color_const.dart';
import '../Constraints/image_const.dart';

class ChatBubbleReceiver extends StatelessWidget {
  ChatBubbleReceiver({Key? key, this.image = '', required this.msg, required this.time}) : super(key: key);

  String image;
  String msg;
  String time;


  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image == ''?SizedBox(width: 40):
        ClipRRect(borderRadius: BorderRadius.circular(50),
            child: Image.network(image, height: 40,)),
        const SizedBox(width: 15),
        Container(padding: const EdgeInsets.all(15).copyWith(right: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15).copyWith(bottomLeft: const Radius.circular(0)),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                color: Colors.grey.shade200,
                offset: Offset(0, 2)
              )
            ]
          ),
          constraints: const BoxConstraints(maxWidth: 300),
          child: Row(mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(constraints: BoxConstraints(maxWidth: 220),
                  child: Text(msg, style: TextStyle(fontSize: 15, color: ColorConst.blue4))),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(time, style: TextStyle(fontSize: 10, color: ColorConst.grey6, fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ),

      ],
    );
  }
}
