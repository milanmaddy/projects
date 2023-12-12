import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kawawa_motors/Controller/profile_controller.dart';
import 'package:kawawa_motors/Model/me_model.dart';
import 'package:kawawa_motors/Services/me_services.dart';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';

import '../Services/dashboard_service.dart';

class MeController extends GetxController{

  var meModel = MeModel().obs;

  Future<MeModel> getMeData() async {
    var data = await MeService.getMyData();
    meModel.value = MeModel.fromJson(data);
    update();
    return meModel.value;
  }

}