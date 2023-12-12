import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'Binding/app_binding.dart';
import 'Routes/app_pages.dart';
import 'Routes/app_route.dart';
import 'Shared Pref/sharedpref_utils.dart';
import 'Theme/app_theme.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        // EasyLoading.init();
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        minWidth: kIsWeb ? 400 : 480,
        maxWidth: kIsWeb ? 400 : double.infinity,
        defaultName: MOBILE,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
          const ResponsiveBreakpoint.resize(600, name: MOBILE),
          const ResponsiveBreakpoint.resize(850, name: TABLET),
          const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        ],
        background: Container(
          color: Colors.white,
        ),
      ),
      //title: 'Flutter Demo',
      theme: lightThemeData(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      getPages: AppPages.routes,
      initialRoute: AppRoute.splashScreen,
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
