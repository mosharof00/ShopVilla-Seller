import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/payment_method/payment_method.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/methods/get_image_url.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/payment_methods_controller.dart';

class PaymentMethodsView extends GetView<PaymentMethodsController> {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentMethodsController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: appbarTitle(text: 'Payment Methods'),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controller.paymentTypeList.isEmpty && controller.paymentTypeList == null){
          return loadingAnimationWidget();
        }else {
          return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.paymentTypeList.length,
              itemBuilder: (context, index) {
                final PaymentType payment = controller.paymentTypeList[index];
                return Padding(
                  padding: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 10.h, bottom: 15.h),
                  child: InkWell(
                    onTap: () {
                      controller.paymentSelectIndex.value = index;
                      Get.back();
                    },
                    child: Obx(() {
                      final bool isSelected =
                          controller.paymentSelectIndex.value == index;
                      return Material(
                        elevation: isSelected ? 5 : 0,
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          height: 75.h,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: ColorName.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(GetImageUrl.url(payment.image!)),
                                  radius: 30.r,
                                ),
                              ),
                              const Spacer(),
                              AppTextStyle(
                                text: payment.status!,
                                color: isSelected
                                    ? ColorName.primaryColor
                                    : ColorName.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            )
          ],
        );
        }
      }),
    );
  }
}