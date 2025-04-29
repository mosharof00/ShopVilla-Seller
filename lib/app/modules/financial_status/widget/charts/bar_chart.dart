import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shop_villa_seller/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';

import '../../../dashboard/widget/weekly_bar_chart.dart';

class BarChart1 extends StatelessWidget {
  const BarChart1({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.put(DashboardController());
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: BarChart(
          BarChartData(
            maxY: dashBoardController.getMaxY(),
            minY: 0,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (_) => ColorName.primaryColor,
                tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                tooltipMargin: 0,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final order = dashBoardController.dailyOrder[groupIndex];
                  String weekday = DateFormat('EEEE').format(order.date!);
                  return BarTooltipItem(
                    '$weekday\n',
                    GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: order.count.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  );
                },
              ),
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  dashBoardController.touchedIndex.value = -1;
                } else {
                  dashBoardController.touchedIndex.value =
                      barTouchResponse.spot!.touchedBarGroupIndex;
                }
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => getTitles(value, meta, dashBoardController.dailyOrder)),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => leftTitles(value, meta, dashBoardController.dailyOrder)),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: dashBoardController.showingGroups(),
            gridData: const FlGridData(show: false),
          ),
          swapAnimationCurve: Curves.easeInOut,
          swapAnimationDuration: dashBoardController.animDuration,
        ),
      );
    });
  }
}
