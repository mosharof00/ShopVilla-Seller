import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:shop_villa_seller/app/modules/dashboard/widget/summary.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import 'package:shop_villa_seller/global/methods/get_currency.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/methods/url_launcher.dart';
import '../../../models/option_model.dart';
import '../../../repository/api_endpoint.dart';
import '../../../routes/app_pages.dart';
import '../../products/controllers/products_controller.dart';
import 'option_item_lcon_label.dart';

Container homepageBody() {
  final dashBoardController = Get.find<DashboardController>();
  return Container(
    color: ColorName.bgColor,
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      children: [
        Obx(
          () {
            if (dashBoardController.dailyOrder.value == null ||
                dashBoardController.dailyOrder.value!.isEmpty) {
              // Show loading indicator if dailyOrder is null or empty
              return loadingAnimationWidget();
            } else {
              return Summary(
                  firstContainerNumber:
                  GetCurrency.concatWithCurrency(dashBoardController.weeklyOrder.value.todayTotalSale.toString(), GetCurrency.currencySymbol),
                  firstContainerText: 'Today Sell',
                  secondContainerNumber: dashBoardController
                      .weeklyOrder.value.totalPendingOrder
                      .toString(),
                  secondContainerText: 'Pending',
                  thirdContainerNumber: dashBoardController
                      .weeklyOrder.value.totalActiveOrder
                      .toString(),
                  thirdContainerText: 'Active Order');
            }
          },
        ),
        10.height,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: optionItem.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Get.toNamed(Routes.RECENT_ORDERS);
                } else if (index == 1) {
                  Get.toNamed(Routes.SALES_SUMMARY);
                } else if (index == 2) {
                  Get.toNamed(Routes.MY_ORDER);
                } else if (index == 3) {
                  Get.toNamed(Routes.STOCKS);
                } else if (index == 4) {
                  Get.toNamed(Routes.ADD_PRODUCT);
                } else if (index == 5) {
                  // final ProductsController productsController =
                  //     Get.put(ProductsController());
                  // productsController.isLoading.value = 0;
                  // productsController.fetchProducts(page: null);
                  Get.toNamed(Routes.EDIT_PRODUCT);
                } else if (index == 6) {
                  Get.toNamed(Routes.CATEGORY);
                } else if (index == 7) {
                  Get.toNamed(Routes.BRAND);
                } else if (index == 8) {
                  Get.toNamed(Routes.CUSTOMER);
                } else if (index == 9) {
                  Get.toNamed(Routes.SUPPLIER);
                } else if (index == 10) {
                  Get.toNamed(Routes.SUPPORT);
                }
              },
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: ColorName.bgColor,
                    border: Border.all(
                        color: ColorName.primaryColor.withOpacity(0.2)),
                  ),
                  child: OptionItemLabel(
                      title: optionItem[index].title!,
                      icon: optionItem[index].value!),
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 120,
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 10,
          ),
        )
      ],
    ),
  );
}
