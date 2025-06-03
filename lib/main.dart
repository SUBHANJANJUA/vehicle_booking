import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';
import 'package:vehicle_booking/app/modules/home/controllers/home_controller.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';
import 'package:vehicle_booking/theme.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(SignupController());
  Get.put(HomeController());
  configEasyLoading();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    Get.put(HomeController());
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: theme(context),
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}

void configEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.green
    ..indicatorColor = AppColors.lighGreen
    ..textColor = AppColors.lighGreen
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
