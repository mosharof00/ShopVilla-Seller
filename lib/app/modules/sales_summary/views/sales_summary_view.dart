import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/widgets/SalesStatistics.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/widgets/allorder_list.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/widgets/total_amount.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../controllers/sales_summary_controller.dart';

class SalesSummaryView extends GetView<SalesSummaryController> {
  const SalesSummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Sales Summary'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: 0.3.sh,
                  color: ColorName.primaryColor,
                ),
              ),
              Positioned(
                top: 20.h,
                left: 10.w,
                right: 10.w,
                child: Container(
                  height: 60.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: ColorName.white),
                  child: Obx(
                    () {
                      if (controller.isLoadingOrderStatistics.value &&
                          controller.isSalesSummaryLoading.value) {
                        return loadingAnimationWidget();
                      } else if (controller.salesSummary.value.data != null && controller
                          .yearlySaleList.isNotEmpty) {
                        return TotalAmount(
                          totalOrder:
                              controller.orderStatistics.value.totalOrderCount!,
                          totalOrderAmount: controller
                              .orderStatistics.value.totalOrderAmount!,
                          totalPendingOrder: controller
                              .salesSummary.value.data!.totalPendingOrder!,
                        );
                      } else {
                        return Center(
                          child: AppTextStyle(
                            text: 'Something went wrong. Please try again.',
                            fontSize: 10.sp,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                top: 100.h,
                left: 10.w,
                right: 10.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: ColorName.white,
                  ),
                  child: const OrderStatistics(),
                ),
              ),
            ],
          ),
          90.height,
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: AppTextStyle(
              text: 'All Delivered Orders',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          10.height,

          ///    Order List
          const AllOrderList(),
        ],
      ),
    );
  }
}
