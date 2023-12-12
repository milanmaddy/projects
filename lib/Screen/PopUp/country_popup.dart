import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kawawa_motors/Constraints/image_const.dart';
import 'package:kawawa_motors/Controller/home_controller.dart';
import '../../Constraints/text_style.dart';
import '../../Controller/item_available_controller.dart';
import '../../GlobalWidgets/loader.dart';

class CountryPopup extends StatelessWidget {
  CountryPopup({Key? key}) : super(key: key);
  ItemAvailableController itemController = Get.put(ItemAvailableController());
  HomeController homeController = Get.put(HomeController());


  final List state = [
    'India',
    'Australia',
    'England',
    'South Africa',
    'New Zealand',
  ];

  String? selectedCountryID;
  String? selectedCountryFlag;
  String? selectedCountryName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 350,
        padding: const EdgeInsets.all(15).copyWith(bottom: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 35,),
                Text('SELECT COUNTRY', style: AppTextStyle.black18_700),
                IconButton(onPressed: (){Get.back();},
                    icon: const Icon(Icons.cancel_rounded, size: 42)
                )
              ],
            ),
            const SizedBox(height: 30),
            GetBuilder(
              init: itemController,
                initState: (controller){
                itemController.getItemData();
                },
                builder: (value){
                  return itemController.itemModel.value.data == null?
                  SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: PRLoader.normalLoader(),
                      )):
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      // scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: itemController.itemModel.value.data!.countries!.length,
                      itemBuilder: (context,index){
                        return Container(
                          // color: selectedCountryID == itemController.itemModel.value.data!.countries![index].countryId!?
                          // Colors.yellow: Colors.green,
                          child: ListTile(
                            leading: Image.network(itemController.itemModel.value.data!.countries![index].countryFlagUrl!, width: 40, fit: BoxFit.cover, height: 25,),
                            title: Text(itemController.itemModel.value.data!.countries![index].countryName!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                            onTap: (){
                              selectedCountryID = itemController.itemModel.value.data!.countries![index].countryId!;
                              selectedCountryFlag = itemController.itemModel.value.data!.countries![index].countryFlagUrl!;
                              selectedCountryName = itemController.itemModel.value.data!.countries![index].countryName!;
                              // print(selectedCountry);
                              Get.back(result: [selectedCountryID, selectedCountryFlag, selectedCountryName]);
                              homeController.getHomePageData(
                                  countryID: selectedCountryID.toString(),
                                  date: DateFormat('yyyy-MM-dd').format(DateTime.now())
                              );
                              homeController.homeModel.value.data = null;
                              homeController.update();
                              },
                          ),
                        );
                      });

                }
            )


          ],
        ),
      ),
    );
  }
}
