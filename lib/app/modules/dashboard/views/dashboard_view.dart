import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/dashboard/widget/getExpandedHeight.dart';
import 'package:shop_villa_seller/app/modules/dashboard/widget/header_widget.dart';
import 'package:shop_villa_seller/app/modules/dashboard/widget/home_body.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import '../../../../appConfig.dart';
import '../../../../global/app_text_style.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return DraggableHome(
      backgroundColor: ColorName.bgColor,
      scrollController: controller.scrollController,
      leading: IconButton(
        onPressed: () {
          controller.scrollToTop();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: AppTextStyle(
            text: AppConfig.appName.capitalize!,
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.5,),
      ),
      appBarColor: ColorName.primaryColor,
      headerWidget: headerWidget(context),
      headerExpandedHeight: getExpandedHeight(context),
      body: [
        homepageBody(),
      ],
    );
  }
}
