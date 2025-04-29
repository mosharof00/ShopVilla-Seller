import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/order_summary/order_statistics.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/controllers/sales_summary_controller.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../financial_status/widget/charts/line_chart_monthly.dart';

class OrderStatistics extends GetView<SalesSummaryController> {
  const OrderStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Obx(() {
            return Row(
              children: [
                5.width,
                AppTextStyle(
                  text:
                      '${'Order Statistics'.tr} (${controller.date.value.split('-')[0].toString()})',
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                  color: ColorName.primaryColor,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    var results = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                        calendarType: CalendarDatePicker2Type.single,
                        calendarViewMode: CalendarDatePicker2Mode.year,
                        firstDate: DateTime(2018),
                        lastDate: DateTime.now(),
                      ),
                      dialogSize: const Size(325, 400),
                      value: [
                        controller.myData.value,
                      ],
                      borderRadius: BorderRadius.circular(15),
                    );
                    if (results != null && results.isNotEmpty) {
                      controller.setDate(results[0]);
                    }
                  },
                  icon: const Icon(
                    Icons.date_range,
                    size: 25,
                  ),
                ),
              ],
            );
          }),
          Obx(() {
            if (controller.isLoadingOrderStatistics.value) {
              return loadingAnimationWidget();
            } else if (controller
                .orderStatistics.value.yearlySale!.isNotEmpty) {
              final OrderSummary orderSummary =
                  controller.orderStatistics.value;
              return SizedBox(
                height: 150.h,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: LineCharts(
                    orderSummary: orderSummary,
                  ),
                ),
              );
            } else {
              return Center(
                child: AppTextStyle(
                  text: 'Something went wrong. Please try again.',
                  fontSize: 10.sp,
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
