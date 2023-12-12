import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/broadcast_controller.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import 'package:kawawa_motors/GlobalWidgets/loader.dart';
import 'my_broadcast_list.dart';

class MyBroadcast extends StatelessWidget {
  MyBroadcast({Key? key}) : super(key: key);

  BroadcastController broadcastController = Get.put(BroadcastController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Broadcasts'),
      backgroundColor: ColorConst.back,
      body: Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: GetBuilder(
            init: broadcastController,
            initState: (controller){
              broadcastController.getMyBroadcastListData();
            },
              builder: (value){
                return broadcastController.myBroadcastModel.value.data == null?
                    SizedBox(
                      height: Get.height,
                      child: PRLoader.normalLoader(),
                    ):
                    broadcastController.myBroadcastModel.value.data!.broadcasts!.isEmpty?
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Stack(
                        children: [
                          SvgPicture.asset(ImageConst.noResult, height: 350),
                          const Positioned(right: 0, left: 0, bottom: 0,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('No Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
                                SizedBox(height: 5),
                                Text("I can't find what you are looking", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ):
                ListView.builder(
                    shrinkWrap: true,
                    physics:  const BouncingScrollPhysics(),
                    controller: broadcastController.scrollController,
                    itemCount: value.myBroadcastModel.value.data!.broadcasts!.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: MyBroadcastList(myBroadcasts: value.myBroadcastModel.value.data!.broadcasts![index],),
                      );
                    }
                );
              }
          )

        ),
    );
  }
}
