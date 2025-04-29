import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_villa_seller/app/modules/financial_status/controllers/financial_status_controller.dart';

List<PieChartSectionData> showingSections() {
  final financialController = Get.find<FinancialStatusController>();
  final data = financialController.orderCategory;

  return List.generate(
    data.length,
    (i) {
      final isTouched = i == financialController.pieTouchedIndex.value;
      final fontSize = isTouched ? 14.0 : 10.0;
      final radius = isTouched ? 110.0 : 100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final category = data[i];
      final color = financialController.pieChartColors[i %
          financialController.pieChartColors.length]; // Used predefined colors
      final title =
          '${category.categoryName!.split(' ')[0]} ${category.percent!.toDouble().toStringAsFixed(2)}%';

      return PieChartSectionData(
        color: color,
        value: category.percent!.toDouble(),
        title: title,
        radius: radius,
        titleStyle: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
      );
    },
  );
}
