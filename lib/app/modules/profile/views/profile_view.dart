import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/auth/login/controllers/login_controller.dart';
import 'package:shop_villa_seller/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/app_text_style_over_flow.dart';
import 'package:shop_villa_seller/global/cashed_image_helper.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';
import '../widgets/logout_bottomsheet.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    final loginController = Get.put(LoginController());
    controller.onInit();
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    30.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        15.width,
                        Get.currentRoute != '/profile'
                            ? const AppTextStyle(
                          text: '',
                        )
                            : InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                    SafeArea(
                      child: FadeIn(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 700),
                        animate: true,
                        child: Container(
                          height: 170.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                              color: ColorName.primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border(
                                left: BorderSide(
                                    color:
                                    ColorName.primaryColor.withOpacity(0.2),
                                    width: 2.w),
                                right: BorderSide(
                                    color:
                                    ColorName.primaryColor.withOpacity(0.2),
                                    width: 2.w),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  ColorName.gradientStart.withOpacity(0.1),
                                  blurRadius: 2,
                                  spreadRadius: 10,
                                )
                              ]),
                          child: controller.profileDetails.value.data == null
                              ? shimmerLoadingCircularWidget()
                              : Center(
                            child: Container(
                              height: 115.h,
                              width: 115.w,
                              decoration: BoxDecoration(
                                color: ColorName.primaryColor
                                    .withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border(
                                  left: BorderSide(
                                      color: ColorName.primaryColor
                                          .withOpacity(0.2),
                                      width: 2.w),
                                  right: BorderSide(
                                      color: ColorName.primaryColor
                                          .withOpacity(0.2),
                                      width: 2.w),
                                ),
                              ),
                              child: Center(
                                  child: cachedImageHelper(
                                      imgurl: controller.profileDetails
                                          .value.data!.image!,
                                      radius: 50.r)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    20.height,
                    AppTextStyle(
                      text: controller.profileDetails.value.data == null
                          ? 'Username'
                          : controller
                          .profileDetails.value.data!.name!.capitalize!,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    AppTextStyle(
                      text: controller.profileDetails.value.data == null
                          ? 'User@mail.com'
                          : controller.profileDetails.value.data!.email!,
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.r),
                      topLeft: Radius.circular(40.r)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 0)
                      // spreadRadius: 2,
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // profileOptions(
                      //     onTap: () {
                      //       Get.put(EditProfileController())
                      //           .setProfileForEditing(controller.profileDetails.value.data!);
                      //       Get.toNamed(Routes.EDIT_PROFILE);
                      //     },
                      //     text: "Edit Profile",
                      //     icon: Assets.icons.userOutlineIcon),
                      // profileOptions(
                      //     onTap: () {
                      //       Get.toNamed(Routes.MY_ORDER);
                      //     },
                      //     text: "My Order",
                      //     icon: Assets.icons.orderIcon),
                      profileOptions(
                          onTap: () {
                            Get.toNamed(Routes.PAYMENT_METHODS);
                          },
                          text: "Payment Methods",
                          icon: Assets.icons.paymentMethodsIcon),
                      profileOptions(
                          onTap: () {
                            Get.toNamed(Routes.PROMOS_VOUCHERS);
                          },
                          text: "Promos & Vouchers",
                          icon: Assets.icons.vouchersIcon),
                      profileOptions(
                          iconHeight: 23.h,
                          iconWidth: 23.w,
                          onTap: () {
                            Get.toNamed(Routes.CART);
                          },
                          text: "My Cart",
                          icon: Assets.icons.cartOutlineIcon),
                      // profileOptions(
                      //     onTap: () {
                      //       Get.toNamed(Routes.ACCOUNT_AND_SECURITY);
                      //     },
                      //     text: "Account & Security",
                      //     icon: Assets.icons.securityIcon),
                      profileOptions(
                          onTap: () {
                            Get.toNamed(Routes.MY_ORDER);
                          },
                          text: "Order History",
                          icon: Assets.icons.historyIcon),
                      profileOptions(
                          onTap: () {
                            Get.toNamed(Routes.SETTINGS);
                          },
                          text: "Settings",
                          icon: Assets.icons.settingIcon),
                      // profileOptions(
                      //     onTap: () {
                      //       Get.toNamed(Routes.NOTIFICATIONS);
                      //     },
                      //     text: "Notifications",
                      //     icon: Assets.icons.notification),
                      profileOptions(
                          onTap: () {
                            Get.toNamed(Routes.HELP_AND_SUPPORT);
                          },
                          text: "Help & Supports",
                          icon: Assets.icons.helpConterIcon),
                      profileOptions(
                          onTap: () {
                            LogOutBottomSheet.show(
                              context,
                                  () {
                                Navigator.pop(context);
                                Get.find<DashboardController>().fetchLogOut();
                              },
                                  () {
                                Get.back();
                              },
                            );
                          },
                          text: "LogOut",
                          textColor: Colors.red,
                          icon: Assets.icons.logoutIcon,
                          iconColor: Colors.red),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget profileOptions({
  required VoidCallback onTap,
  required String text,
  required String icon,
  Color? textColor,
  Color? iconColor,
  double? iconHeight,
  double? iconWidth,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: iconHeight ?? 17.h,
            width: iconWidth ?? 17.w,
            colorFilter:
            ColorFilter.mode(iconColor ?? Colors.black, BlendMode.srcIn),
          ),
          20.width,
          SizedBox(
            width: Get.width - 125.w,
            child: AppTextStyleOverFlow(
              text: text,
              color: textColor ?? Colors.black,
              fontSize: 15.sp,
              maxLines: 1,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black,
            size: 17.sp,
          )
        ],
      ),
    ),
  );
}

