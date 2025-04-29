
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_villa_seller/app/models/category/addCategory/views/add_category_view.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';


class OptionItemLabel extends StatelessWidget {
  const OptionItemLabel({
    super.key,
    required this.title,
    required this.icon,

  });
 final String title;
  final  String icon;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            fit: BoxFit.fill,
            height: 70.h,
            width: 70.w,
            // colorFilter:
            //     const ColorFilter.mode(ColorName.primaryColor, BlendMode.srcIn),
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: AppTextStyle(
                text: title,
                color: Colors.black,
                fontSize: 15.sp,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                height: 1),
          ),
          5.height,
        ],
      ),
    );
  }
}
