import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';
import '../../Constraints/text_style.dart';

class DealersTab extends StatelessWidget {
  DealersTab({Key? key}) : super(key: key);

  // final List img = [
  //   ImageConst.d1,
  //   ImageConst.d2,
  //   ImageConst.d3,
  //   ImageConst.d4,
  //   ImageConst.dealer,
  // ];
  //
  // final List name = [
  //   'Sell Car',
  //   'Kamrulz',
  //   'Mwaiku Investment',
  //   'Sell Car',
  //   'Mwaiku Investment',
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(onTap: (){Get.toNamed(AppRoute.dealerDetails);},
                      child: Container(padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 0.2, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12)
                          // image: DecorationImage(image: AssetImage(ImageConst.classic1))
                        ),
                        child: IntrinsicWidth(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: AssetImage(ImageConst.d1),
                                ),
                              ),
                              Divider(height: 40, color: ColorConst.grey6),
                              Text('Mercedes Benz', style: AppTextStyle.productTitle),
                              const SizedBox(height: 3),
                              Text('0999144762 / 1234567890', style: AppTextStyle.productSubTitle),
                            ],
                          ),
                        ),
                      ),
                    )
                );
              }),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(onTap: (){Get.toNamed(AppRoute.seeAllDealer);},
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Show all', style: AppTextStyle.grey15_600),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 12, color: ColorConst.grey3)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
