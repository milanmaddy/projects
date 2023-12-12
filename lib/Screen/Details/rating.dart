import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kawawa_motors/Constraints/color_const.dart';
import 'package:get/get.dart';
import 'package:kawawa_motors/Controller/rating_controller.dart';
import 'package:kawawa_motors/Controller/vehicle_controller.dart';

import '../../Controller/sp_controller.dart';

class Rating extends StatelessWidget {
  Rating({Key? key, this.ratingFrom, this.productID}) : super(key: key);

  RatingController ratingController = Get.put(RatingController());

  String? ratingFrom;
  String? productID;

  double newRating = 5;



  @override
  Widget build(BuildContext context) {
    // print(oldRating);
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
              // side: BorderSide(color: ColorConst.inputFilled, width: 2)
          ),
          titlePadding: EdgeInsets.zero,
          // shadowColor: Colors.red,

          title: Container(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20).copyWith(top: 30),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                RatingBar.builder(
                  initialRating: newRating,
                  minRating: 1,
                  // ignoreGestures: true,
                  itemSize: 50,
                  direction: Axis.horizontal,
                  // allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, _){
                    return const Icon(Icons.star, color: Colors.amber);
                  },
                  onRatingUpdate: (value) {
                    print(value);
                    newRating = value;
                  },
                ),
                const SizedBox(height: 15),
                Divider(color: Colors.grey.shade300, thickness: 2, height: 30),
                GestureDetector(onTap: (){print("Step 1");
                  print(newRating);
                  print(productID);
                  if(ratingFrom == 'SP'){
                    ratingController.giveSPRating(sparePartID: productID.toString(), rating: newRating);
                  }else if(ratingFrom == 'V'){
                    ratingController.giveVehicleRating(vID: productID.toString(), rating: newRating);
                  }else if(ratingFrom == 'G'){
                    ratingController.giveGarageRating(garageID: productID.toString(), rating: newRating);
                  }else if(ratingFrom == 'D'){
                    ratingController.giveDealerRating(dealerID: productID.toString(), rating: newRating);
                  }
                  Get.back(result: newRating);
                  },
                    child: Text('SUBMIT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorConst.label),))
              ],
            ),
          ),
        )
    );
  }
}
