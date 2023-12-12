import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kawawa_motors/GlobalWidgets/app_bar.dart';
import '../Constraints/color_const.dart';
import '../Constraints/image_const.dart';
import '../Constraints/text_style.dart';
import '../GlobalWidgets/loader.dart';
import '../Model/cms_model.dart';
import '../Services/CMS_Services/cms_services.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policy'),
      backgroundColor: ColorConst.back,
      body: Padding(padding: const EdgeInsets.all(30).copyWith(top: 55),
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30, bottom: 80),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
            ),
            child: FutureBuilder(
              future: CMSServices.cms(pageName: 'privacy-policy'),
              builder: (context, AsyncSnapshot<CMSModel>snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: PRLoader.normalLoader()
                  );
                }if(snapshot.hasData){
                  return SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(child: SvgPicture.asset(ImageConst.error, height: 50)),
                        const SizedBox(height: 10),
                        Center(child: Text('Privacy Policy', style: AppTextStyle.introTitle)),
                        const SizedBox(height: 20),
                        Html(data: snapshot.data!.data!.pageContent!, style: {
                          "body": Style(
                            fontSize: FontSize(15),
                            fontWeight: FontWeight.w600,
                          ),
                        },)
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            )
          )
      ),
    );
  }
}
