import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/me_controller.dart';
import 'package:kawawa_motors/Model/my_enquiry_model.dart';
import 'package:kawawa_motors/Services/enquiry_service.dart';

class EnquiryController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    enquiryScrollController();
  }
  ScrollController scrollController = Get.put(ScrollController());
  MeController meController = Get.put(MeController());

  var myEnqModel = MyEnquiryModel().obs;
  int pageNumber = 1;
  String pageType = '';

  Future postEnquiryData({
    required String toUserId,
    required String productId,
    required String enquiryType,
    required String enquiryText,
  })async{
    var data = await EnquiryServices.postEnquiry(
        toUserId: toUserId,
        productId: productId,
        enquiryType: enquiryType,
        enquiryText: enquiryText
    );
    if(data['statusCode'] == 200){
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.black);
    }else{
      Get.snackbar("SUCCESS", data['message'],borderRadius:5, snackPosition:SnackPosition.BOTTOM, colorText: Colors.redAccent);
    }
    update();
  }

  Future <MyEnquiryModel> myEnquiryListData({
    String enquiryType = 'all',
    bool showLoader = true
  })async{
    pageNumber = 1;
    pageType = enquiryType;
    var data = await EnquiryServices.getMyEnquiry(
        enquiryType: enquiryType,
        showLoader: showLoader,
        pageName: pageNumber.toString()
    );
    myEnqModel.value = MyEnquiryModel.fromJson(data);
    if(data['statusCode'] == 200){
      meController.getMeData();
    }
    print('NOW THE ENQUIRY LIST IS ${myEnqModel.value.data!.enquiries!.length}');
    pageNumber++;
    print('PAGE NUMBER IS: $pageNumber');
    update();
    return myEnqModel.value;
  }

  Future <MyEnquiryModel> myEnquiryListDataForNextPage({
    String enquiryType = 'all',
    required String page,
  })async{
    update();
    if(myEnqModel.value.data!.pagination!.lastPage! >= pageNumber){
      var data = await EnquiryServices.getMyEnquiry(
          enquiryType: enquiryType,
          showLoader: true,
          pageName: pageNumber.toString()
      );
      myEnqModel.value.data!.enquiries!.addAll(MyEnquiryModel.fromJson(data).data!.enquiries!);
      print('NOW THE ENQUIRY LIST IS ${myEnqModel.value.data!.enquiries!.length}');
      pageNumber++;
      print('NOW THE PAGE NUMBER IS: $pageNumber');
    }
    update();
    return myEnqModel.value;
  }

  enquiryScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        print('After Scroll Controller');
        myEnquiryListDataForNextPage(enquiryType: pageType, page: pageNumber.toString());
        print('========');
        print('pagenumber: $pageNumber');
      }
    });
  }

}