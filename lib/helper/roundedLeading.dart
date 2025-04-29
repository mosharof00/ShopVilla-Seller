import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';
import '../global/app_text_style.dart';

Widget roundedLeading({
  required int index,
  double? height,
  double? width,
  Color? containerColor,
  Color? fontColor,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Container(
    height: height ?? 30.h,
    width: width ?? 30.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: containerColor ?? ColorName.primaryColor,
    ),
    child: Center(
      child: AppTextStyle(
        text: (index + 1).toString(),
        color: fontColor ?? ColorName.white,
        fontSize: fontSize ?? 12.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    ),
  );
}
