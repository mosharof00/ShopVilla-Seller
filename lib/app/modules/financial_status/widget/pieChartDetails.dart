import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/financial_status/controllers/financial_status_controller.dart';
import '../../../../global/app_text_style.dart';
import '../../../models/financial_status/order_by_category_model.dart';

class PieChartDetails extends GetView<FinancialStatusController> {
  const PieChartDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.orderCategory.length,
          itemBuilder: (context, item) {
            final OrderCategory orderCategory = controller.orderCategory[item];
            return ListTile(
              leading: Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.pieChartColors[item],
                ),
              ),
              title: AppTextStyle(
                text: orderCategory.categoryName!,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
              trailing: AppTextStyle(
                text: '${orderCategory.percent!.toDouble().toStringAsFixed(2)}%',
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            );
          });
    });
  }
}
