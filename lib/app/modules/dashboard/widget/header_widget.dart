import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/profile_model/profile_get_model.dart';
import 'package:shop_villa_seller/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:shop_villa_seller/app/modules/dashboard/widget/circle.dart';
import 'package:shop_villa_seller/app/modules/financial_status/widget/charts/bar_chart.dart';
import 'package:shop_villa_seller/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/widgets/product_labels.dart';
import 'package:shop_villa_seller/app/modules/support/controllers/support_controller.dart';
import 'package:shop_villa_seller/app/routes/app_pages.dart';
import 'package:shop_villa_seller/global/cashed_image_helper.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/methods/get_currency.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/badges_widget.dart';

Widget headerWidget(BuildContext context) {
  final profileController = Get.put(ProfileController());
  final dashBoardController = Get.put(DashboardController());
  final supportController = Get.put(SupportController());
  return Container(
    color: ColorName.bgColor,
    child: SizedBox(
      height: 0.60.sh,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 280.h,
              color: ColorName.primaryColor,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 55.h,
                          child: Obx(() {
                            final ProfileGetModel profile =
                                profileController.profileDetails.value;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                circularImage(
                                    imgUrl: profile.data?.image == null
                                        ? 'public/frontend/images/user/avatar.png'
                                        : profile.data!.image!,
                                    radius: 22.r,
                                    imgRadius: 50.r),
                                SizedBox(width: 10.w),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    labels(
                                        text: profile.data?.name == null
                                            ? 'User'
                                            : profile.data!.name!.capitalize,
                                        color: ColorName.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                    labels(
                                        text: profile.data?.email == null
                                            ? 'user@mail.com'
                                            : profile.data!.email!,
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          StackCircle(
            top: 100.h,
            left: -60.w,
          ),
          StackCircle(
            top: -80.h,
            right: -80.w,
          ),
          Positioned(
            top: 0.14.sh,
            left: 20.w,
            right: 20.w,
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(15.r),
              child: Container(
                padding: EdgeInsets.only(top: 12.w),
                width: double.infinity,
                height: 205.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Obx(() {
                  if (!dashBoardController.isDailyOrderLoading.value) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: AppTextStyle(
                            text:
                            '${'Total Weekly Order'.tr} : ${GetCurrency.concatWithCurrency(dashBoardController.weeklyOrder.value.totalOrderPrice.toString(), GetCurrency.currencySymbol)}',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Expanded(
                          child: BarChart1(),
                        ),
                      ],
                    );
                  } else {
                    return loadingAnimationWidget();
                  }
                }),
              ),
            ),
          ),

          ///                   Message Icon                    ////
          Positioned(
            right: 58.w,
            top: 30.h,
            child: Obx(
              () => badgeWidget(
                count: supportController.messageNotificationCount.value,
                onTap: () {
                  Get.toNamed(Routes.SUPPORT);
                },
                icon: SvgPicture.asset(
                  Assets.images.support,
                  colorFilter:
                      const ColorFilter.mode(ColorName.white, BlendMode.srcIn),
                  fit: BoxFit.fill,
                  height: 30.h,
                  width: 30.w,
                ),
              ),
            ),
          ),

          ///                   Notification Icon                ///
          Positioned(
            right: 10.w,
            top: 30.h,
            child: Obx(
              () => badgeWidget(
                count: dashBoardController.totalNotificationCount.value,
                onTap: () {
                  Get.toNamed(Routes.NOTIFICATION);
                },
                icon: SvgPicture.asset(
                  Assets.icons.notification,
                  colorFilter:
                      const ColorFilter.mode(ColorName.white, BlendMode.srcIn),
                  fit: BoxFit.fill,
                  height: 30.h,
                  width: 30.w,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
