import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../../global/app_text_style.dart';

class AddProductHelper extends StatelessWidget {
  const AddProductHelper(
      {super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppTextStyle(
          text: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        5.height,
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: AppTextStyle(
            text: subtitle,
            fontSize: 16.sp,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
