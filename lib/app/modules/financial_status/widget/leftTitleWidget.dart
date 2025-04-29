import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    // color: ColorName.white
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '10K';
      break;
    case 2:
      text = '20K';
      break;
    case 3:
      text = '30k';
      break;
    case 4:
      text = '40K';
      break;
    case 5:
      text = '50k';
      break;
    case 6:
      text = '60K';
      break;
    case 7:
      text = '70K';
      break;
    case 8:
      text = '80k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}