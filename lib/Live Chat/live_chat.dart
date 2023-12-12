import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/chat_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/Live%20Chat/chat_list.dart';
import 'package:kawawa_motors/Model/me_model.dart';

import '../Constraints/color_const.dart';
import '../GlobalWidgets/loader.dart';

class LiveChat extends StatelessWidget {
  LiveChat({Key? key}) : super(key: key);

  ChatController chatController = Get.put(ChatController());
  MeController meController = Get.put(MeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Live Chat'),
      backgroundColor: ColorConst.back,
      body: RefreshIndicator(
        onRefresh: ()async{
          chatController.myChatList();
        },
        child: SingleChildScrollView(
          child: GetBuilder(
              init: chatController,
              initState: (controller){
                chatController.myChatList();
              },
              builder: (value){
                return chatController.chatModel.value.data == null?
                SizedBox(height: Get.height,
                    child: PRLoader.normalLoader()):
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      physics:  const NeverScrollableScrollPhysics(),
                      itemCount: value.chatModel.value.data!.leftMenuList!.length,
                      itemBuilder: (context, index){
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ChatList(chat: value.chatModel.value.data!.leftMenuList![index])
                        );
                      }
                  ),
                );
              }
          ),
        ),
      )
    );
  }
}
