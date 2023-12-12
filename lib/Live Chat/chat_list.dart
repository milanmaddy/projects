import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/chat_controller.dart';
import 'package:kawawa_motors/Routes/app_route.dart';

import '../Model/chatlist_model.dart';

class ChatList extends StatelessWidget {
  ChatList({Key? key, required this.chat}) : super(key: key);
  ChatController chatController = Get.put(ChatController());

  LeftMenuList chat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      chatController.messageModel.value.data = null;
      Get.toNamed(AppRoute.chatPage,
          arguments: [chat.inboxId, chat.profileImageUrl, chat.fullName, chat.isOnline, chat.userId, '', '']);
      },
      child: Container(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                  offset: const Offset(0,2)
              )
            ]
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Stack(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(50),
                  child: Image.network(chat.profileImageUrl!)
              ),
              Positioned(right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: chat.isOnline == true?
                    Colors.green : Colors.red,
                    radius: 6,
                  ),
                ),
              )
            ],
          ),
          title: Text(chat.fullName!, style: AppTextStyle.black14_600,),
          subtitle: Text(chat.lastMessage!, style: AppTextStyle.grey12_400),
          trailing: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CircleAvatar(
              //   radius: 6, backgroundColor: Colors.red,
              // ),
              SizedBox(height: 30),
              Text(DateFormat.jm().format(DateTime.parse(chat.lastMessageTime.toString()).toLocal()))
            ],
          ),
        )
        // Row(
        //   children: [
        //     CircleAvatar(
        //       radius: 35,
        //       backgroundImage: AssetImage(ImageConst.maddy),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
