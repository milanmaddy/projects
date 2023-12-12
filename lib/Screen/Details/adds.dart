import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Constraints/color_const.dart';
import '../../Constraints/image_const.dart';

class Adds extends StatelessWidget {
  Adds({Key? key}) : super(key: key);

  var aIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
          child: SizedBox(width: MediaQuery.of(context).size.height,
            child: CarouselSlider.builder(
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay:true,
                  onPageChanged: (index, reason) {
                    aIndex.value = index;
                  },
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int itemIndex,
                    int pageViewIndex) {
                  return Image.asset(ImageConst.vehicle, width: 600, fit: BoxFit.cover,);
                }),
          ),
        ),

        Positioned(
          bottom: 8,
          right: 0.0,
          left: 0.0,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:Obx(() =>  AnimatedSmoothIndicator(
                  activeIndex: aIndex.value,
                  count: 4,
                  effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 5,
                      activeDotColor: ColorConst.button,
                      dotColor: Colors.white),
                ))
            ),
          ),
        ),

        Positioned(right: 15, top: 15,
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: Colors.white,
              child: Icon(Icons.favorite, size: 20, color: Colors.grey),
            )
        )

      ],
    );
  }
}
