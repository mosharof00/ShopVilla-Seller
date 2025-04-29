import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

Widget titleText(String text) {
  return AppTextStyle(
    text: text,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
}

class DropDownContainer extends StatelessWidget {
  const DropDownContainer({
    super.key,
    required this.isSelected,
    this.validatorText,
    required this.child,
  });

  final bool isSelected;
  final String? validatorText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: const Color(0xFFe9ecef),
            border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : ColorName.textFieldErrorColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: child,
        ),
        isSelected
            ? 0.width
            : AppTextStyle(
                text: validatorText ?? '',
                fontSize: 12.sp,
                color: ColorName.textFieldErrorColor,
              )
      ],
    );
  }
}
