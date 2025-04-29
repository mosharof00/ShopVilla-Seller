import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

class Summary extends StatelessWidget {
  const Summary({
    super.key,
    required this.firstContainerNumber,
    required this.firstContainerText,
    required this.secondContainerNumber,
    required this.secondContainerText,
    required this.thirdContainerNumber,
    required this.thirdContainerText,
  });

  final String firstContainerNumber;
  final String firstContainerText;
  final String secondContainerNumber;
  final String secondContainerText;
  final String thirdContainerNumber;
  final String thirdContainerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: ColorName.primaryColor.withOpacity(0.9),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child:  SummaryOfOrders(
              title: firstContainerNumber.toString(),
              desc: firstContainerText,
            ),
          ),
          Expanded(
            flex: 1,
            child: SummaryOfOrders(
              title: secondContainerNumber.toString(),
              desc: secondContainerText,
            ),
          ),
          Expanded(
            flex: 1,
            child: SummaryOfOrders(
              title: thirdContainerNumber.toString(),
              desc: thirdContainerText,
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryOfOrders extends StatelessWidget {
  const SummaryOfOrders({super.key, required this.title, required this.desc});

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white10,
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextStyle(
                text: title,
                color: ColorName.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            5.height,
            AppTextStyle(
                text: desc,
                color: ColorName.white.withOpacity(0.6),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
