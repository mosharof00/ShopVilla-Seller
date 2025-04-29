import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/dashboard/views/dashboard_view.dart';
import 'package:shop_villa_seller/app/modules/financial_status/controllers/financial_status_controller.dart';
import 'package:shop_villa_seller/app/modules/financial_status/views/financial_status_view.dart';
import 'package:shop_villa_seller/app/modules/products/views/products_view.dart';
import 'package:shop_villa_seller/app/modules/profile/views/profile_view.dart';

import '../../../../global/awesome_dialog_login.dart';
import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';
import '../../my_order/controllers/my_order_controller.dart';
import '../../products/controllers/products_controller.dart';

class MainPageController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final count = 0.obs;
  final selectedTab = 0.obs;
  List pageList = [
    const DashboardView(),
    const FinancialStatusView(),
    const ProductsView(),
    const ProfileView(),
  ];

  @override
  onInit() async {
    final args = await Get.arguments;
    if (args != null) {
      changeTab(
        int.parse(args.toString()),
      );
    }
    super.onInit();
  }

  ///  Navigate to a specific bottomNavigationBar
  changeTab(int index) {
    if (index == 0) {
      selectedTab.value = index;
      return;
    } else if (index == 2) {
      Get.put(MainPageController());
      final ProductsController productsController =
          Get.put(ProductsController());
      productsController.isLoading.value = 0;
      productsController.fetchProducts(page: null);
      selectedTab.value = index;
    }  else if (index == 1) {
      Get.put(MainPageController());
      final financialStatusController = Get.put(FinancialStatusController());
      financialStatusController.onInit();
      selectedTab.value = index;
    }
    selectedTab.value = index;
  }
}

