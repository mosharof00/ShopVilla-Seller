import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa_seller/global/methods/get_currency.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../helper/divider.dart';

class TotalAmount extends StatelessWidget {
  const TotalAmount(
      {super.key,
      required this.totalOrder,
      required this.totalOrderAmount,
      required this.totalPendingOrder});
  final int totalOrder;
  final int totalOrderAmount;
  final int totalPendingOrder;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        20.width,
        totalAmount(text: 'Delivered', amount: totalOrder.toString()),
        divider(height: 40.h, width: 1.w),
        totalAmount(text: 'Gross Amount', amount: '${GetCurrency.currencySymbol} ${totalOrderAmount.toString()}'),
        divider(height: 40.h, width: 1.w),
        totalAmount(text: 'Pending', amount: totalPendingOrder.toString()),
        20.width,
      ],
    );
  }
}

Widget totalAmount({required String text, required String amount}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextStyle(
          text: amount,
          fontSize: 18.sp,
          color: ColorName.primaryColor,
          fontWeight: FontWeight.w600,
        ),
        AppTextStyle(
          text: text,
          fontSize: 12.sp,
          color: ColorName.black,
          fontWeight: FontWeight.w600,
        ),
      ],
    ),
  );
}
