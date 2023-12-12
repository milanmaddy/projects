import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:kawawa_motors/Constraints/text_style.dart';
import 'package:kawawa_motors/GlobalWidgets/buttons.dart';
import 'package:kawawa_motors/Routes/app_route.dart';
import '../../Constraints/image_const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Shared Pref/sharedpref_utils.dart';

class Intro extends StatelessWidget {
  Intro({Key? key}) : super(key: key);

  var pageIndex = 0.obs;
  var isEnd = false.obs;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellowAccent,
      body: Stack(
        children: [
          SvgPicture.asset(
            ImageConst.loginBack,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: PageView(
                      // physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        pageIndex.value = index;
                        print(index);
                      },
                      controller:_controller,
                      children: [
                        Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 130),
                                child: SvgPicture.asset(
                                  ImageConst.intro1,
                                  height: 280,
                                  width: 400,
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 140),
                            Text('WHAT WILL YOUR NEXT CAR BE?', style: AppTextStyle.introTitle),
                            const SizedBox(height: 35),
                            // Icon(Icons.check, weight: 50,)
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConst.check),
                                const SizedBox(width: 15),
                                Text('Access many vehicles on sell within seconds', style: AppTextStyle.introSubTitle)
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConst.check),
                                const SizedBox(width: 15),
                                Text('Compare prices from many sellers', style: AppTextStyle.introSubTitle)
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConst.check),
                                const SizedBox(width: 15),
                                Text('View reputable dealers', style: AppTextStyle.introSubTitle)
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConst.check),
                                const SizedBox(width: 15),
                                Text('Make enquiries and chat with car sellers', style: AppTextStyle.introSubTitle)
                              ],
                            ),

                          ],
                        ),
                        Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 170),
                                child: Image.asset(
                                  ImageConst.intro22,
                                  height: 280,
                                  width: 420,
                                  // fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(height: 100),
                            Text('NEED TO SELL YOUR CAR QUICKLY?', style: AppTextStyle.introTitle),
                            const SizedBox(height: 35),
                            // Icon(Icons.check, weight: 50,)
                            Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(ImageConst.check),
                                const SizedBox(width: 15),
                                Text('Showcase to millions of potential\nbuyers with a single Click.', style: AppTextStyle.introSubTitle)
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConst.check),
                                const SizedBox(width: 15),
                                Text('Save on advertising costs', style: AppTextStyle.introSubTitle)
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConst.check),
                                const SizedBox(width: 15),
                                Text('Respond to enquiries and directly\nchat with buyers.', style: AppTextStyle.introSubTitle)
                              ],
                            ),

                          ],
                        ),
                        Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 130),
                                child: SvgPicture.asset(
                                  ImageConst.intro3,
                                  height: 290,
                                  width: 290,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 130),
                            Text('OPEN ACCOUNT', style: AppTextStyle.introTitle),
                            const SizedBox(height: 35),
                            Text('Set up an account to start selling and buying\nvehicles, making full use of all features on Kawawa\nMotors',
                            style: AppTextStyle.introSubTitle),
                          ],
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30).copyWith(left: 45),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothPageIndicator(
              controller:_controller,
              count: 3,
              effect: SlideEffect(
                activeDotColor: ColorConst.blue1,
                dotColor: Colors.grey,
                // dotHeight: 8, dotWidth: 55,
              ),
            ),

            Obx(() => pageIndex.value == 2?
              Buttons.actionButtons(title: 'Get Started', event: (){slideToNextPage();}):
              GestureDetector(onTap: (){slideToNextPage();},
              child: Container(
                height: 50, width: 50,
                decoration: BoxDecoration(
                    color: ColorConst.button,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: ColorConst.button.withOpacity(0.8),
                          blurRadius: 5,
                          spreadRadius: 1.5,
                          offset: const Offset(1, 5)
                      )
                    ]
                ),
                child: const Icon(Icons.arrow_forward_ios_rounded, size: 25, color: Colors.white),
              ),
            ))
          ],
        ),
      ),
    );
  }
  void slideToNextPage(){
    if(pageIndex<2){
      _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease);}
    else{
      SharedPrefUtils.saveStr("showIntroduction", "true");
      Get.toNamed(AppRoute.dashBoard);
    }
    //pageIndex.value++;
  }
}
