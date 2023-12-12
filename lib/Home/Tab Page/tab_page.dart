import 'package:flutter/material.dart';
import 'package:kawawa_motors/Controller/tabbar_controller.dart';
import '../../Constraints/color_const.dart';
import 'package:get/get.dart';

class TabPage extends StatelessWidget {
  TabPage({Key? key}) : super(key: key);

  TabBarController tabBarController = Get.put(TabBarController());
  var i = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
      // height: MediaQuery.of(context).size.height,
      // color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: TabBar(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 43),
                // indicator: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                //   color: ColorConst.primary,
                // ),
                controller: tabBarController.tabController,
                indicatorColor: ColorConst.label,
                unselectedLabelColor: ColorConst.grey6,
                indicatorWeight: 3,
                // labelColor: Colors.red,
                onTap: (index) {
                  i.value = index;
                  print(i);
                },
                tabs: const [
                  Tab(
                    child: (
                        Text('Vehicles', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                    ),
                  ),
                  Tab(
                    child: (
                        Text('Spare Parts', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                    ),
                  ),
                  // SizedBox(width: 30),
                  Tab(
                    child: (
                        Text('Repair Garages', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                    ),
                  ),
                  // Tab(
                  //   child: (
                  //       Text('Dealers', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,))
                  //   ),
                  // ),

                ]),
          ),
          const SizedBox(height: 20),
          Obx(() => tabBarController.tabsView[i.value])
          // SizedBox(height: 500,
          //   child: TabBarView(children: tabBarController.tabsView[i]),
          // )
        ],
      ),
    );
  }
}
