import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/socket_controller.dart';
import 'package:kawawa_motors/Model/chatlist_model.dart';
import 'package:kawawa_motors/Model/inbox_chat_model.dart';
import 'package:kawawa_motors/Model/sent_message_model.dart';
import 'package:kawawa_motors/Services/chat_services.dart';

class ChatController extends GetxController{

  SocketController socketController = Get.put(SocketController());

  var chatModel = ChatListModel().obs;
  var messageModel = InboxChatModel().obs;
  var sentFileModel = SentMessageModel().obs;

  Future<ChatListModel> myChatList() async {
    var data = await ChatServices.getChatList();
    chatModel.value = ChatListModel.fromJson(data);
    update();
    return chatModel.value;
  }

  Future<InboxChatModel> oneToOneChat({required String inboxID}) async {
    var data = await ChatServices.getMyInbox(inboxID: inboxID);
    messageModel.value = InboxChatModel.fromJson(data);
    update();
    return messageModel.value;
  }

  // Future sendTextMsg({required String inboxID, required String message, required String recieverID, required TextEditingController msg})async{
  //   var data = await ChatServices.sendTextMsg(inboxID: inboxID, message: message, recieverID: recieverID);
  //   if(data['statusCode'] == 201){
  //     // Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
  //     oneToOneChat(inboxID: inboxID);
  //     myChatList();
  //     msg.clear();
  //     // Get.toNamed(AppRoute.dashBoard);
  //     update();
  //   }else{
  //     Get.snackbar("ERROR", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.red);
  //   }
  //   update();
  //   return data;
  // }

  Future<SentMessageModel> sentMessage({required String inboxID, required List file, required String message, required String recieverID, required TextEditingController msg}) async {
    var data = await ChatServices.sendTextMsg(inboxID: inboxID, file: file, message: message, recieverID: recieverID);
    sentFileModel.value = SentMessageModel.fromJson(data);
    if(data['statusCode'] == 201){
      // var data2 = await ChatServices.getMyInbox(inboxID: inboxID);
      // Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.green[600]);
      socketController.socketEmit(inboxID, sentFileModel.value.data!.conversion!);
      socketController.socketListener();
      // if(data2['statusCode'] == 201){
      //   // messageModel.value = InboxChatModel.fromJson(data);
      //
      //   // print('socket');
      // }
      oneToOneChat(inboxID: inboxID);
      // socketController.socketEmit(inboxID, messageModel.value.data!.conversion!);
      // socketController.socketListener();
      // print('socket');
      myChatList();
      msg.clear();
    }
    update();
    return sentFileModel.value;
  }

}

