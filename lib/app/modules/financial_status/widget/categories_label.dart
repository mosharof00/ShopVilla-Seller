import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../controllers/financial_status_controller.dart';

Widget categoriesLabel() {
  final financialController = Get.find<FinancialStatusController>();
  final data = financialController.orderCategory;

  return SizedBox(
    height: 50.h, // Adjust the height based on your design
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final category = data[index];
        final color = financialController.pieChartColors[index %
            financialController.pieChartColors.length]; // Use predefined colors

        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: 8), // Adjust margin as needed
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              8.width,
              AppTextStyle(
                text: category.categoryName!,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        );
      },
    ),
  );
}
