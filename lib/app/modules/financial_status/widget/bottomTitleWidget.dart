import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    // color: ColorName.white
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Jan', style: style);
      break;

    case 3:
      text = const Text('Mar', style: style);
      break;

    case 5:
      text = const Text('May', style: style);
      break;

    case 7:
      text = const Text('July', style: style);
      break;

    case 9:
      text = const Text('Sep', style: style);
      break;

    case 11:
      text = const Text('Nov', style: style);
      break;

    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    meta: meta,
    child: text,
  );
}
