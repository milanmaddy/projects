import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Model/dashboard_model.dart';


class SlideController extends GetxController{

  Timer? _timer;
  ScrollController scrollController = ScrollController();
  ScrollController scrollControllerO = ScrollController();
  PageController pageController = PageController();
  final screenWidth = MediaQuery.of(Get.context!).size.width;
  var currentPage = 0.obs;
  var homeModel = HomePageModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit

    // Future.delayed(const Duration(seconds: 3), () {
    //   scrollController.animateTo(scrollController.position.maxScrollExtent,
    //       duration: Duration(seconds: 30), curve: Curves.linear);
    // });

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     // Scroll has reached the end, reset the position to the beginning.
    //     scrollController.jumpTo(scrollController.position.minScrollExtent);
    //   }
    // });

    super.onInit();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   double minScrollExtent1 = scrollController.position.minScrollExtent;
    //   double maxScrollExtent1 = scrollController.position.maxScrollExtent;
    //
    //   animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 15,
    //       scrollController);
    //
    // });

    startAutoScroll();
    // update();
    // scrollToNextPage();
    update();
    // startAutoSlide();
    // startAutoScrollO();


  }

  // ScrollController scrollController = ScrollController();
  //
  // animateToMaxMin(double max, double min, double direction, int seconds,
  //     ScrollController scrollController) {
  //   scrollController
  //       .animateTo(direction,
  //       duration: Duration(seconds: seconds), curve: Curves.linear)
  //       .then((value) {
  //     direction = direction == max ? min : max;
  //     animateToMaxMin(max, min, direction, seconds, scrollController);
  //   });
  // }

  // void scrollToNextPage() {
  //   // pageController.;
  //   // pageController.initialPage: 0,
  //   const duration = Duration(seconds: 3);
  //   _timer = Timer.periodic(duration, (Timer timer) {
  //     if (currentPage < homeModel.value.data!.trustedPartners!.length - 1) {
  //       currentPage++;
  //     } else {
  //       currentPage.value = 0;
  //     }
  //     pageController.animateToPage(
  //       currentPage.value,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   });
  // }

  void startAutoSlide() {
    final screenWidthInPixels = screenWidth * MediaQuery.of(Get.context!).devicePixelRatio;
    final sub = (18.50 / 100) * screenWidthInPixels;
    final radius = 200.0; // Adjust the radius as needed
    double angle = 0.0;

    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      final centerX = screenWidthInPixels / 2;
      final centerY = sub + radius;

      // Calculate the new X and Y positions using circular motion equations
      final newX = centerX + radius * cos(angle);
      final newY = centerY + radius * sin(angle);

      angle += 0.05; // Adjust the angular speed as needed

      // Scroll the list view to the calculated position
      scrollController.jumpTo(newY);
    });
  }











  void startAutoScroll() {
    final screenWidthInPixels = screenWidth * MediaQuery.of(Get.context!).devicePixelRatio;
    final sub = (16.00 / 100) * screenWidthInPixels;
    print("hd45");
    print(screenWidthInPixels);
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // final maxScrollExtent = scrollController.position.maxScrollExtent;
      // final currentScrollPosition = scrollController.position.pixels;
      // final itemExtent = scrollController.position.viewportDimension;
      //
      // if (currentScrollPosition + itemExtent >= maxScrollExtent) {
      //   scrollController.animateTo(
      //     scrollController.position.pixels + 315.0,
      //     duration: Duration(milliseconds: 2000),
      //     curve: Curves.fastOutSlowIn, // Use a custom animation curve
      //   );
      // } else {
      //   scrollController.animateTo(
      //     scrollController.position.pixels + 315.0,
      //     duration: Duration(milliseconds: 500),
      //     curve: Curves.fastOutSlowIn, // Use a custom animation curve
      //   );
      // }
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        scrollController.jumpTo(0.0);
      } else {
        scrollController.animateTo(
          scrollController.position.pixels + sub,//315.0,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  void startAutoScrollO() {
    final screenWidthInPixels = screenWidth * MediaQuery.of(Get.context!).devicePixelRatio;
    final sub = (15.85 / 100) * screenWidthInPixels;
    // _timer = Timer.periodic(Duration(seconds: 2), (timer) {
    //   final maxScrollExtent = scrollControllerO.position.maxScrollExtent;
    //   final currentScrollPosition = scrollControllerO.position.pixels;
    //   final itemExtent = scrollControllerO.position.viewportDimension;
    //
    //   if (currentScrollPosition + itemExtent >= maxScrollExtent) {
    //     scrollControllerO.animateTo(0,
    //         duration: Duration(milliseconds: 500),
    //         curve: Curves.easeInOut);
    //   } else {
    //     scrollControllerO.animateTo(currentScrollPosition + itemExtent,
    //         duration: Duration(milliseconds: 500),
    //         curve: Curves.easeInOut);
    //   }
    // });
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (scrollControllerO.position.pixels ==
          scrollControllerO.position.maxScrollExtent) {
        scrollControllerO.jumpTo(16.0);
      } else {
        scrollControllerO.animateTo(
          scrollControllerO.position.pixels + sub,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

}