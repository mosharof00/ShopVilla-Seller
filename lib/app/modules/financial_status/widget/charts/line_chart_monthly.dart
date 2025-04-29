import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';

import '../../../../models/order_summary/order_statistics.dart';

class LineCharts extends StatelessWidget {
  final OrderSummary orderSummary;

  const LineCharts({super.key, required this.orderSummary});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }

  LineChartData get sampleData {
    return LineChartData(
      lineTouchData: lineTouchData,
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      lineBarsData: lineBarsData,
      minX: 0,
      maxX: orderSummary.yearlySale!.length.toDouble() - 1,
      maxY: getMaxY().toDouble() + 1,
      minY: 0,
    );
  }

  LineTouchData get lineTouchData => LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              const textStyle = TextStyle(
                color: ColorName.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
              return LineTooltipItem(
                  touchedSpot.y.toInt().toString(), textStyle);
            }).toList();
          },
        ),
        enabled: true,
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        lineChartBarData,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return Text('${value.toInt()}', style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 2,
        reservedSize: 30,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return SideTitleWidget(
      meta: meta,
      space: 1,
      child: Text(getMonthName(value.toInt()), style: style),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 25,
        interval: 2,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.red.withAlpha(20), width: 2),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData {
    List<FlSpot> spots = [];
    for (int i = 0; i < orderSummary.yearlySale!.length; i++) {
      spots.add(FlSpot(
        i.toDouble(),
        orderSummary.yearlySale![i].totalCount!.toDouble(),
      ));
    }
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0,
      color: ColorName.green.withAlpha(150),
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: true),
      spots: spots,
    );
  }

  int getMaxY() {
    int maxY = 0;
    for (var sale in orderSummary.yearlySale!) {
      if (sale.totalCount! > maxY) {
        // Compare totalCount, not totalAmount
        maxY = sale.totalCount!; // Assign totalCount to maxY
      }
    }
    return maxY;
  }

  String getMonthName(int index) {
    return orderSummary.yearlySale![index].month!.toString().substring(0, 3);
  }
}
