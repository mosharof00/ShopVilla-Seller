import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import '../../../../appConfig.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashScreenController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.bgColor,
        body: Center(
          child: Image.asset(
            AppConfig.appLogo,
            height: 200.h,
            width: 200.w,
          ),
        ),
      ),
    );
  }
}
