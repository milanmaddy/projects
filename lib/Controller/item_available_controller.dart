import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kawawa_motors/Model/item_available_model.dart';
import 'package:kawawa_motors/Services/item_services.dart';

class ItemAvailableController extends GetxController{

  var itemModel = ItemAvailableModel().obs;

  Future<ItemAvailableModel> getItemData() async {
  var data = await ItemService.getItemData();
  try {
    itemModel.value = ItemAvailableModel.fromJson(data);
    // if(itemModel.v)
  } catch (e) {
  print(e);
  }
  update();
  return itemModel.value;
  }
}