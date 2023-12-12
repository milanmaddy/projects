import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Controller/chat_controller.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Controller/socket_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/GlobalWidgets/chat_bubble_reciever.dart';
import 'package:kawawa_motors/GlobalWidgets/chat_bubble_sender.dart';
import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../GlobalWidgets/loader.dart';
import '../../GlobalWidgets/trim_name.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  SocketController socketController = Get.put(SocketController());

  TextEditingController messageController = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  MeController meController = Get.put(MeController());

  String inboxID = Get.arguments[0];
  String profilePic = Get.arguments[1];
  String userName = Get.arguments[2];
  bool onlineStatus = Get.arguments[3];
  String receiverID = Get.arguments[4];
  String nameColor = Get.arguments[5];
  String background = Get.arguments[6];

  @override
  Widget build(BuildContext context) {
    print(inboxID);
    print(receiverID);
    return Scaffold(
      backgroundColor: ColorConst.back,
      body: GetBuilder(
        init: chatController,
          initState: (controller){
          chatController.oneToOneChat(inboxID: inboxID);
          meController.getMeData();
          },
          builder: (value){
            return chatController.messageModel.value.data == null?
            SizedBox(height: Get.height,
                child: PRLoader.normalLoader()):
            meController.meModel.value.data == null?
            SizedBox(height: Get.height,
                child: PRLoader.normalLoader()):
            Column(
              children: [
                Container(padding: const EdgeInsets.symmetric(vertical: 50).copyWith(bottom: 15),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                      color: Colors.white
                  ),
                  child: ListTile(
                    leading: GestureDetector(onTap: (){Get.back();},

                      child: Container(padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                  offset: const Offset(0,2)
                              )
                            ]
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF455A64), size: 30,),
                      ),
                    ),
                    title: Text(userName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConst.blue2)),
                    subtitle: Text(onlineStatus == true?
                        'Online' : 'Offline',
                        style: TextStyle(color: ColorConst.blue5)),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Stack(
                        children: [
                          profilePic == ''?
                          CircleAvatar(
                            backgroundColor: Color(int.parse(background.replaceFirst('#', "0XFF"))),
                            child: Center(
                              child: Text(TrimName.getInitials(userName.toUpperCase()),
                                style: TextStyle(color: Color(int.parse(nameColor.replaceFirst('#', '0XFF'))),),
                              ),
                            ),
                            // backgroundImage: NetworkImage(profilePic),
                          ):
                          CircleAvatar(
                            backgroundImage: NetworkImage(profilePic),
                          ),
                          // ClipRRect(borderRadius: BorderRadius.circular(50),
                          //     child: Image.network(profilePic, height: 46,)
                          // ),
                          Positioned(right: 0,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: onlineStatus == true?
                                Colors.green : Colors.redAccent,
                                radius: 6,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(20).copyWith(top: 30),
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          reverse: true,
                          physics:  const AlwaysScrollableScrollPhysics(),
                          itemCount: value.messageModel.value.data!.conversion!.length,
                          itemBuilder: (context, index){
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: [
                                    // Text(profilePic),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(bottom: 10),
                                    //   child: Text(value.messageModel.value.data!.conversion![index].messagedAt!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: ColorConst.grey6),),
                                    // ),
                                    value.messageModel.value.data!.conversion![index].type == 1?
                                    ChatBubbleSender(
                                      dp: meController.meModel.value.data!.user!.profileImageUrl!,
                                      msg: value.messageModel.value.data!.conversion![index].content!.message!,
                                      time: DateFormat.jm().format(DateTime.parse(value.messageModel.value.data!.conversion![index].messagedAt!.toString()).toLocal()),
                                      // image: value.messageModel.value.data!.conversion![index].content!.files![index].fileUrl!,
                                      image: '',
                                      nameHex: meController.meModel.value.data!.user!.userColor!.userNameColorHexCode!,
                                      backHex: meController.meModel.value.data!.user!.userColor!.backgroundHexCode!,
                                      name: meController.meModel.value.data!.user!.fullName
                                    ):
                                    ChatBubbleReceiver(
                                      image: profilePic,
                                      msg: value.messageModel.value.data!.conversion![index].content!.message!,
                                      time: DateFormat.jm().format(DateTime.parse(value.messageModel.value.data!.conversion![index].messagedAt!.toString()).toLocal()),
                                    ),
                                  ],
                                )
                            );
                          }
                      ),
                      // chatController.messageModel.value.data.conversion.


                      // const SizedBox(height: 10),
                      // ChatBubbleReceiver(msg: 'It was all a dream, i used to read Word Up magazine Salt’n’ Pepa and Heavy D up in the', time: '18:11'),
                      // SizedBox(height: 10),
                      // ChatBubbleReceiver(msg: 'It goes a little something like this.', time: '18:11'),
                      // SizedBox(height: 10),
                      //
                      // SizedBox(height: 10,),


                      // Bubble(
                      //   margin: const BubbleEdges.only(top: 10),
                      //   alignment: Alignment.topLeft,
                      //   nipWidth: 8,
                      //   nipHeight: 24,
                      //   nip: BubbleNip.leftTop,
                      //   child: const Text(
                      //     'I am fine. And you?',
                      //     style: TextStyle(fontSize: 17),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            );
          }
      ),

      bottomSheet: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        // height: 130,
        // width: MediaQuery.of(context).size.width,
        color: ColorConst.back,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            meController.meModel.value.data!.user!.profileImageUrl == ''?
            CircleAvatar(
              radius: 27,
              backgroundColor: Color(int.parse(meController.meModel.value.data!.user!.userColor!.backgroundHexCode!.replaceFirst('#', "0XFF"))),
              // backgroundImage: NetworkImage(meController.meModel.value.data!.user!.profileImageUrl!),
              child: Center(
                child: Text(
                  TrimName.getInitials(meController.meModel.value.data!.user!.fullName!.toUpperCase()),
                  style: TextStyle(color: Color(int.parse(meController.meModel.value.data!.user!.userColor!.userNameColorHexCode!.replaceFirst('#', "0XFF"))),),
                ),
              ),
            ):
            CircleAvatar(
              radius: 27,
              backgroundImage: NetworkImage(meController.meModel.value.data!.user!.profileImageUrl!),
            ),
            const SizedBox(width: 20),
            Expanded(child: Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Colors.grey.shade300,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Write a message',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12).copyWith(left: 20),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(50))),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(50))),
                  // filled: true,
                  // fillColor: ColorConst.button,

                  suffixIcon: GestureDetector(onTap: (){
                    // Get.back();
                    // chatController.sendTextMsg(
                    //     inboxID: inboxID,
                    //     message: messageController.text,
                    //     recieverID: receiverID,
                    //   msg: messageController
                    // );
                    chatController.sentMessage(
                        inboxID: inboxID,
                        file: [],
                        message: messageController.text,
                        recieverID: receiverID,
                        msg: messageController
                    );
                    FocusScope.of(context).unfocus();
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(ImageConst.send)),
                  ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            SvgPicture.asset(ImageConst.gallery)
  ]
  ),
  )
  );
  }
}
