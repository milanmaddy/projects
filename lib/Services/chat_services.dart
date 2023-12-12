import 'package:dio/dio.dart' as dioClient;
import 'package:kawawa_motors/Model/chatlist_model.dart';
import 'package:kawawa_motors/Model/inbox_chat_model.dart';

import '../GlobalWidgets/loader.dart';
import '../Model/sent_message_model.dart';
import '../Shared Pref/sharedpref_utils.dart';
import 'base.dart';

class ChatServices{
  static getChatList()async{
    try{
      // PRLoader.show();
      print("== CHAT LIST DATA ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("chat/get-user-inbox",
        options: dioClient.Options(contentType: "application/json",
            headers: {
              "Authorization": "Bearer ${SharedPrefUtils.getToken()}"
            }
        ),
      );
      print(response);
      // PRLoader.hide();
      return response.data;
    }catch (e){
      // PRLoader.hide();
      print(e);
      return ChatListModel();
    }
  }

  static getMyInbox({required String inboxID, String page = '1'})async{
    try{
      // PRLoader.show();
      print("== INBOX CHAT LIST DATA ==");
      dioClient.Response response;
      response = await BaseUrl.getDio1().get("chat/get-all-message-list",
        queryParameters: {
        'inboxId' : inboxID,
        'page' : page,
        },
        options: dioClient.Options(contentType: "application/json",
            headers: {
              "Authorization": "Bearer ${SharedPrefUtils.getToken()}",
            }
        ),
      );
      print(response);
      // PRLoader.hide();
      return response.data;
    }catch (e){
      // PRLoader.hide();
      print(e);
      return InboxChatModel();
    }
  }

  static sendTextMsg({required String inboxID, required String message, required String recieverID, required List file }) async {
    try {
      // PRLoader.show();
      dioClient.Response response;
      dioClient.Options options = dioClient.Options(contentType: 'application/json',
          headers: {'Authorization':'Bearer ${SharedPrefUtils.getToken()}'}
      );
      var mData = {
        "inboxId": inboxID,
        "message": message,
        "file[]" : file,
        // "recieverId": recieverID
      };
      print({
        "inboxId": inboxID,
        "message": message,
        "files[]" : file,
        // "recieverId": recieverID
      });
      response = await BaseUrl.getDio1().post("chat/send-message-with-files",
          options: options,
          data: mData
      );
      // PRLoader.hide();
      print(response);
      return response.data;
    }catch (e){
      // PRLoader.hide();
      print(e);
      return SentMessageModel();
    }
  }
}