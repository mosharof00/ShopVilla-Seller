import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/financial_status/controllers/financial_status_controller.dart';

import '../showingsection.dart';

class PieCharts extends GetView<FinancialStatusController> {
  const PieCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Obx(
        () {
          return PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    controller.pieTouchedIndex.value = -1;
                    return;
                  }
                  controller.pieTouchedIndex.value =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                },
              ),
              borderData: FlBorderData(
                show: true,
              ),
              sectionsSpace: 1,
              centerSpaceRadius: double.infinity,
              sections: showingSections(),
            ),
          );
        },
      ),
    );
  }
}
