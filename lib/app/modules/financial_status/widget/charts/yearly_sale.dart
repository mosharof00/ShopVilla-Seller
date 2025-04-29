import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_villa_seller/app/models/financial_status/yearly_sell_model.dart';
import 'package:shop_villa_seller/app/modules/financial_status/controllers/financial_status_controller.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../global/methods/get_currency.dart';


final financialController = Get.put(FinancialStatusController());
Widget yearlyLineChart(RxList<YearlySell> yearlySell) {
  return BarChart(
    BarChartData(
      barTouchData: barTouchData,
      titlesData: titlesData,
      borderData: borderData,
      barGroups: getBarGroups(yearlySell),
      gridData: const FlGridData(show: true),
      alignment: BarChartAlignment.spaceAround,
      maxY: 100,
      minY: 0,
      groupsSpace: 12,
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
        getTooltipColor: (_) =>  ColorName.primaryColor,
        tooltipPadding: const EdgeInsets.all(8),
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          final financialStatus = financialController.yearlySell[groupIndex];
          return BarTooltipItem(
            '${rod.toY.round().toString()}%\n',
            TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    '${GetCurrency.currencySymbol} ${financialStatus.amount.toString()}',
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
    );

Widget getTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: ColorName.black,
    fontWeight: FontWeight.bold,
    fontSize: 11,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Jan';
      break;
    case 1:
      text = 'Feb';
      break;
    case 2:
      text = 'Mar';
      break;
    case 3:
      text = 'Apr';
      break;
    case 4:
      text = 'May';
      break;
    case 5:
      text = 'Jun';
      break;
    case 6:
      text = 'July';

    case 7:
      text = 'Aug';

    case 8:
      text = 'Sep';

    case 9:
      text = 'Oct';
    case 10:
      text = 'Nov';
      break;
    case 11:
      text = 'Dec';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    meta: meta,
    space: 0,
    child: Text(text, style: style),
  );
}

FlTitlesData get titlesData => const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles:
            SideTitles(showTitles: true, interval: 20, reservedSize: 40),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
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

List<BarChartGroupData> getBarGroups(List<YearlySell> yearlySells) {
  return yearlySells.asMap().entries.map((entry) {
    int index = entry.key;
    YearlySell yearlySell = entry.value;

    bool isTouched = index == financialController.touchedIndex.value;

    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: yearlySell.percent!.toDouble(),
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
