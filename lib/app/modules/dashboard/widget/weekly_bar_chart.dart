import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';

import '../../../models/weekly_order_model/weekly_order_model.dart';

Widget getTitles(double value, TitleMeta meta, List<DailyOrder> dailyOrder) {
  Widget text;
  if (value.toInt() < dailyOrder.length) {
    final order = dailyOrder[value.toInt()];
    String weekday = DateFormat('EEEE').format(order.date!);
    text = AppTextStyle(
      text: weekday.substring(0, 3), // Display only the first letter
      fontWeight: FontWeight.w600,
    );
  } else {
    text = const AppTextStyle(
      text: '',
      fontWeight: FontWeight.w600,
    );
  }
  return SideTitleWidget(
    meta: meta,
    space: 5,
    child: text,
  );
}

Widget leftTitles(double value, TitleMeta meta, List<DailyOrder> dailyOrder) {
  // Get the maximum count value from the dailyOrder list
  int maxCount = dailyOrder.map((e) => e.count!).reduce((a, b) => a > b ? a : b);
  String text;

  if (value == 0) {
    text = '0';
  }
  // If maxCount is 1, display only 0 and 1
  else if (maxCount == 1) {
    if (value == 1) {
      text = '1';
    } else {
      return const SizedBox.shrink();
    }
  }
  // If maxCount is 2, display 0, 1, and 2
  else if (maxCount == 2) {
    if (value == 1) {
      text = '1';
    } else if (value == 2) {
      text = '2';
    } else {
      return const SizedBox.shrink();
    }
  }
  // For larger maxCount, show 0, middle value, and maxCount
  else {
    if (value == maxCount.toDouble()) {
      text = '$maxCount';
    } else if (value == (maxCount / 2).round().toDouble()) {
      text = '${(maxCount / 2).round()}';
    } else {
      return const SizedBox.shrink();
    }
  }

  // Return the title widget with the calculated text
  return SideTitleWidget(
    meta: meta,
    space: 5,
    angle: 0,
    child: AppTextStyle(
      text: text,
      fontWeight: FontWeight.w600,
      fontSize: 11.sp,
    ),
  );
}
