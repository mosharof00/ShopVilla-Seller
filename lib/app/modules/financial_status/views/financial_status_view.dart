import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/financial_status/widget/charts/yearly_sale.dart';
import 'package:shop_villa_seller/app/modules/financial_status/widget/charts/piechart_categories.dart';
import 'package:shop_villa_seller/app/modules/financial_status/widget/pieChartDetails.dart';
import 'package:shop_villa_seller/app/modules/financial_status/widget/selling_n_categories.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../../../../global/methods/get_currency.dart';
import '../controllers/financial_status_controller.dart';
import '../widget/charts/monthly_sale.dart';

class FinancialStatusView extends GetView<FinancialStatusController> {
  const FinancialStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FinancialStatusController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Financial Status'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SellingCategories(),
              20.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle(
                        text: 'Total Sale',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: ColorName.primaryColor,
                      ),
                      Row(
                        children: [
                          Obx(() {
                            return AppTextStyle(
                              text: controller
                                  .financialStatus.value.totalEarning ==
                                  null
                                  ? ''
                                  : GetCurrency.concatWithCurrency(controller.financialStatus.value.totalEarning.toString(), GetCurrency.currencySymbol),
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: ColorName.primaryColor,
                            );
                          }),
                          const Spacer(),
                          AppTextStyle(
                            text: 'View by:'.tr,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: ColorName.black,
                          ),
                          10.width,
                          SizedBox(
                            width: 120.w,
                            height: 55.h,
                            child: CustomDropdown<String>(
                              items: controller.list,
                              initialItem: controller.list[0],
                              onChanged: (value) => controller.onChanged(value),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  20.height,
                  Obx(() {
                    return Stack(
                      children: [
                        Container(
                          height: 300.h,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(3, 3),
                                color: ColorName.gray70,
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: controller.dropDownValue.value == 'Monthly'
                              ? controller.yearlySell.isNotEmpty
                              ? monthlyLineChart(
                              controller.financialStatusList)
                              : loadingAnimationWidget(size: 40)
                              : controller.financialStatusList.isNotEmpty
                              ? yearlyLineChart(controller.yearlySell)
                              : loadingAnimationWidget(size: 40),
                        )
                      ],
                    );
                  }),
                  10.height,
                  Obx(() {
                    return Container(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white,
                        ),
                        child: controller.isLoadingOrderCategory.value
                            ? Center(child: loadingAnimationWidget(size: 40))
                            : controller.orderCategory.isNotEmpty
                            ? Column(
                          children: [
                            AppTextStyle(
                              text: 'Order by Category',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            15.height,
                            const PieCharts(),
                            10.height,
                            const PieChartDetails(),
                          ],
                        )
                            : const SizedBox.shrink());
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
