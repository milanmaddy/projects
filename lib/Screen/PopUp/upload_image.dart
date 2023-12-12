import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kawawa_motors/Controller/add_controller.dart';
import 'package:kawawa_motors/Controller/profile_controller.dart';
import '../../Constraints/text_style.dart';
import '../../GlobalWidgets/buttons.dart';
import '../../Routes/app_route.dart';

class UploadImage extends StatelessWidget {
  UploadImage({Key? key, this.uploadFrom}) : super(key: key);

  String? uploadFrom = Get.arguments;

  ProfileController profileController = Get.put(ProfileController());
  AddController addController = Get.put(AddController());

  @override
  Widget build(BuildContext context) {
    return Container(height: 320,
      padding: const EdgeInsets.all(15).copyWith(bottom: 10),
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
              Text('UPLOAD IMAGE', style: AppTextStyle.black18_700),
              IconButton(onPressed: (){Get.back();},
                  icon: const Icon(Icons.cancel_rounded, size: 42)
              )
            ],
          ),
          const SizedBox(height: 50),
          const Text('Please select image from\nCamera or Gallery', textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23)),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Buttons.popupButton2(title: 'Camera', event: (){
                  Get.back();
                  if(uploadFrom == 'privateProfile'){
                    profileController.updateProfilePicture(ims: ImageSource.camera);
                  }else if(uploadFrom == 'businessProfile'){
                    profileController.updateBusinessLogo(ims: ImageSource.camera);
                  }else if(uploadFrom == 'addVehicle'){                    // profileController.localLogo.value.delete();
                    addController.uploadPicture(ims: ImageSource.camera);
                  }else if(uploadFrom == 'addGarage'){                    // profileController.localLogo.value.delete();
                    addController.uploadLogo(ims: ImageSource.camera);
                  }else if(uploadFrom == 'addVehicle2'){                    // profileController.localLogo.value.delete();
                    addController.uploadMultiplePicture(ims: ImageSource.camera);
                  }
                }, width: 250)),
                const SizedBox(width: 30),
                Expanded(child: Buttons.popupButton(title: 'Gallery', event: (){
                  Get.back();
                  if(uploadFrom == 'privateProfile'){
                    profileController.updateProfilePicture(ims: ImageSource.gallery);
                  }else if(uploadFrom == 'businessProfile'){                    // profileController.localLogo.value.delete();
                    profileController.updateBusinessLogo(ims: ImageSource.gallery);
                  }else if(uploadFrom == 'addVehicle'){                    // profileController.localLogo.value.delete();
                    addController.uploadPicture(ims: ImageSource.gallery);
                  }else if(uploadFrom == 'addGarage'){                    // profileController.localLogo.value.delete();
                    addController.uploadLogo(ims: ImageSource.gallery);
                  }else if(uploadFrom == 'addVehicle2'){                    // profileController.localLogo.value.delete();
                    addController.uploadMultiplePicture(ims: ImageSource.gallery);
                  }
                }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
