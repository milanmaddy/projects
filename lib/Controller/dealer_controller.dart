import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kawawa_motors/Model/dealer_details_model.dart';
import 'package:kawawa_motors/Services/dealer_details_services.dart';
// import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';


class DealerController extends GetxController{
  var dealerModel = DealerDetailsModel().obs;

  Future getDealerDetailsData({required String dealerId}) async {
    var data = await DealerDetailsServices.getDealerDetails(dealerId);
    try {
      dealerModel.value = DealerDetailsModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    update();
    return dealerModel.value;
  }

}