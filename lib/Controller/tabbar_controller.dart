import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import 'package:kawawa_motors/Home/Tab%20Page/repair_garage_tab.dart';
import 'package:kawawa_motors/Home/Tab%20Page/spare_parts_tab.dart';
import 'package:kawawa_motors/Home/Tab%20Page/vehicle_tab.dart';
import 'package:kawawa_motors/Search/Search%20Dealer/search_dealer.dart';
import 'package:kawawa_motors/Search/Search%20Repair%20Garages/search_repair_garages.dart';
import 'package:kawawa_motors/Search/Search%20Spare%20Part/search_spare_part.dart';
import '../Search/Search Vehicle/search_vehicle.dart';

class TabBarController extends GetxController with GetSingleTickerProviderStateMixin{

  HomeController homeController = Get.put(HomeController());

  late TabController tabController;
  var tabsView;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);

    tabsView = [
      VehicleTab(),
      SparePartsTab(),
      RepairGarageTab(),
    ];

  }

}


class TabBarController2 extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController tabController2;
  var tabsView;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController2 = TabController(length: 4, vsync: this);

    tabsView = [
      SearchVehicle(),
      SearchSpareParts(),
      SearchRepairGarages(),
      SearchDealer()
    ];

  }

}