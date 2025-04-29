import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/financial_status/controllers/financial_status_controller.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import '../../../../../global/methods/get_currency.dart';
import '../../../../models/financial_status/financial_status_model.dart';

final financialController = Get.put(FinancialStatusController());
Widget monthlyLineChart(RxList<WeeklySale> weeklySell) {
  return BarChart(
    BarChartData(
      barTouchData: barTouchData,
      titlesData: titlesData,
      borderData: borderData,
      barGroups: getBarGroups(weeklySell),
      gridData: const FlGridData(show: true),
      alignment: BarChartAlignment.spaceBetween,
      maxY: financialController.financialStatus.value.totalEarning!
          .round()
          .toDouble(),
      minY: 0,
    ),
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 250),
  );
}

BarTouchData get barTouchData => BarTouchData(
  enabled: true,
  touchCallback: (FlTouchEvent event, barTouchResponse) {
    if (!event.isInterestedForInteractions ||
        barTouchResponse == null ||
        barTouchResponse.spot == null) {
      financialController.touchedIndex.value = -1;
    } else {
      financialController.touchedIndex.value =
          barTouchResponse.spot!.touchedBarGroupIndex;
    }
  },
  touchTooltipData: BarTouchTooltipData(
    getTooltipColor: (_) => ColorName.primaryColor,
    tooltipPadding: const EdgeInsets.all(8),
    tooltipMargin: 8,
    getTooltipItem: (
        BarChartGroupData group,
        int groupIndex,
        BarChartRodData rod,
        int rodIndex,
        ) {
      return BarTooltipItem(
        '${GetCurrency.currencySymbol} ${rod.toY.round().toString()}',
        TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    },
  ),
);

Widget getTitles(double value, TitleMeta meta, int totalWeeks) {
  const style = TextStyle(
    color: ColorName.black,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  String text;
  if (value.toInt() < totalWeeks) {
    text = '${value.toInt() + 1}${ordinalSuffix(value.toInt() + 1)} Week  ';
  } else {
    text = '';
  }
  return SideTitleWidget(
    meta: meta,
    space: 10,
    angle: 0,
    child: Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    ),
  );
}

// Helper function to add ordinal suffix to the week number
String ordinalSuffix(int number) {
  if (number >= 11 && number <= 13) {
    return 'th';
  }
  switch (number % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

FlTitlesData get titlesData => FlTitlesData(
  show: true,
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 30,
      getTitlesWidget: (value, meta) => getTitles(value, meta, financialController.financialStatusList.length - 1),
    ),
  ),
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      interval: financialController.calculateInterval(financialController.financialStatus.value.totalEarning!.round().toDouble()),
      reservedSize: 60,
    ),
  ),
  topTitles: const AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  rightTitles: const AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
);

FlBorderData get borderData => FlBorderData(
  show: false,
);

LinearGradient get _barsGradient => const LinearGradient(
  colors: [
    ColorName.crimsonRed,
    ColorName.yellow,
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

List<BarChartGroupData> getBarGroups(List<WeeklySale> yearlySells) {
  return yearlySells.asMap().entries.map((entry) {
    int index = entry.key;
    WeeklySale weeklySale = entry.value;
    bool isTouched = index == financialController.touchedIndex.value;
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: weeklySale.totalSales!.round().toDouble(),
          fromY: 0,
          gradient: _barsGradient,
          width: 20,
          borderRadius: BorderRadius.circular(4),
          borderSide: isTouched
              ? const BorderSide(color: Colors.blueAccent, width: 1)
              : BorderSide.none,
        ),
      ],
      showingTooltipIndicators:
      isTouched ? [0] : [], // Show tooltip only when touched
    );
  }).toList();
}
