import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';
import '../../../../../appConfig.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_input_textformfield.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/loading_button.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';
import 'login_ui_helper.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HelperUtils.deletePermanentController();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorName.bgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppConfig.appLogo,
                    height: 200.h,
                    width: 200.w,
                  ),
                  20.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextStyle(
                      text: 'Welcome \nBack!',
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  30.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextStyle(
                      text: 'Email',
                      textAlign: TextAlign.start,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  5.height,
                  AppInputTextFormField(
                    // prefixIcon: Icon(Icons.person),
                    controller: controller.emailEditingController,
                    prefixIcon: SvgPicture.asset(
                      Assets.icons.emailIcon,
                      width: 12.w,
                      height: 12.h,
                    ),
                    hintText: 'Email',
                  ),
                  Obx(() => Visibility(
                    visible: controller.emailError.isNotEmpty,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextStyle(
                        textAlign: TextAlign.start,
                        text: controller.emailError.value,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorName.crimsonRed,
                      ),
                    ),
                  )),
                  15.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextStyle(
                      text: 'Password',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  5.height,
                  Obx(
                        () => AppInputTextFormField(
                      controller: controller.passEditingController,
                      maxLines: 1,
                      obscureText: controller.hidePassword.value,
                      prefixIcon: SvgPicture.asset(
                        Assets.icons.lockIcon,
                        width: 18.w,
                        height: 17.h,
                      ),
                      suffixIcon: controller.hidePassword.value
                          ? InkWell(
                        onTap: () {
                          controller.hidePassword.value = false;
                        },
                        child: SvgPicture.asset(
                          Assets.icons.inVisibleEyeIcon,
                          width: 10.w,
                          height: 10.h,
                        ),
                      )
                          : InkWell(
                        onTap: () {
                          controller.hidePassword.value = true;
                        },
                        child: SvgPicture.asset(
                          Assets.icons.visibleEyeIcon,
                          width: 10.w,
                          height: 10.h,
                        ),
                      ),
                      hintText: 'Password',
                    ),
                  ),
                  Obx(() => Visibility(
                    visible: controller.passwordError.isNotEmpty,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextStyle(
                        text: controller.passwordError.value,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorName.crimsonRed,
                      ),
                    ),
                  )),
                  10.height,
                  Row(
                    children: [
                      Obx(() {
                        if (controller.boxCheck.value) {
                          return boxUnChecked(onTap: () {
                            controller.boxCheck.value = false;
                          });
                        } else {
                          return boxChecked(onTap: () {
                            controller.boxCheck.value = true;
                          });
                        }
                      }),
                      10.width,
                      AppTextStyle(
                        text: 'Remember Me',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.FORGOT_PASSWORD);
                        },
                        child: AppTextStyle(
                          text: 'Forgot Password?',
                          color: ColorName.primaryColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  // 25.height,
                  // // orPart(),
                  // 25.height,
                  // signInOption(
                  //   onTap: () {
                  //     Get.find<LoginController>().signInWithGoogle();
                  //   },
                  //   icon: Assets.icons.googleIcon,
                  //   text: 'Continue with Google',
                  // ),
                  30.height,
                  loadingButton(
                      onTap: () {
                        if (controller.validateInputs()) {
                          controller.loginUser(
                            email: controller.emailEditingController.text,
                            password: controller.passEditingController.text,
                          );
                        } else {
                          controller.btnController.stop();
                        }
                      },
                      controller: controller.btnController,
                      text: "Login"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget signInOption(
    {required VoidCallback onTap, required String icon, required String text}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 40.h,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: const Color(0xFFdee2e6), width: 1.w)),
      child: Row(
        children: [
          10.width,
          SvgPicture.asset(
            icon,
            width: 25.w,
          ),
          Expanded(
            child: AppTextStyle(
              text: text,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          30.width
        ],
      ),
    ),
  );
}

