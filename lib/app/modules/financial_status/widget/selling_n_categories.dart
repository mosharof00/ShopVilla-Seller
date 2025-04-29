import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_villa_seller/app/modules/financial_status/controllers/financial_status_controller.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/methods/get_currency.dart';

class SellingCategories extends GetView<FinancialStatusController> {
  const SellingCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: ColorName.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextStyle(
                      text: controller.financialStatus.value.totalEarning ==
                              null
                          ? ''
                          : GetCurrency.concatWithCurrency(controller.financialStatus.value.totalEarning.toString(), GetCurrency.currencySymbol),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: ColorName.green,
                    ),
                    5.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextStyle(
                          text: 'Total Earning',
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                          color: ColorName.black,
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),

      ],
    );
  }
}
