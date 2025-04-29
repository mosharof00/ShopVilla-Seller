import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../global/app_text_style.dart';

Widget categoriesName(Color color, String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 10.h,
          width: 10.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        5.width,
        AppTextStyle(
          text: text,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ],
    ),
  );
}
