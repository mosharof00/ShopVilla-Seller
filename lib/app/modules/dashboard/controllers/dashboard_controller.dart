import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/currency/currency.dart';
import 'package:shop_villa_seller/app/models/weekly_order_model/weekly_order_model.dart';
import 'package:shop_villa_seller/app/routes/app_pages.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';
import '../../../../global/global_snackbar.dart';
import '../../../models/product_model/sort_filter__list_model.dart';
import '../../../repository/api_services.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_store_config.dart';
import '../../../../helper/exception_handle.dart';
import '../../../../gen/colors.gen.dart';

class DashboardController extends GetxController {
  ScrollController scrollController = ScrollController();

  ApiServices apiServices = ApiServices();

  /// Total Weekly Order
  final weeklyOrder = WeeklyOrder().obs;
  final dailyOrder = <DailyOrder>[].obs;

  ///  cartController listener
  final chartController = ValueNotifier<bool>(false);
  final checked = false.obs;

  /// Currency
  final currency = Currency().obs;

  ///   for sort filter
  final isSortFilterLoading =
      100.obs; //  0 = successfully get product, 1=loading , 2= error
  final sortList = <Sort>[].obs;
  final typeList = <FilterType>[].obs;

  ///  Dashboard User count
  final totalCardedCount = 0.obs;
  final totalActiveOrderedCount = 0.obs;
  final totalWishListedCount = 0.obs;
  final totalNotificationCount = 0.obs;

  ///  for  Barchart
  final touchedIndex = RxInt(-1);
  final List<Color> availableColors = [
    ColorName.onPrimary,
    ColorName.crimsonRed,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ].obs;

  final Color barBackgroundColor = ColorName.black.withOpacity(0.1);
  final Color barColor = ColorName.primaryColor;
  final Color touchedBarColor = ColorName.crimsonRed;
  final Duration animDuration = const Duration(milliseconds: 150);

  scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  /// Weekly Order
  final isDailyOrderLoading = true.obs;
  Future<void> getWeeklyOrder() async {
    try {
      final response = await apiServices.getWeeklyOrder();
      weeklyOrder.value = response.data!;
      dailyOrder.value = response.data!.dailyOrders ?? [];
      isDailyOrderLoading.value = false;
    } catch (e) {
      handleException(e);
      isDailyOrderLoading.value = false;
    }
  }

  /// Log Out
  Future<void> fetchLogOut() async {
    try {
      final response = await apiServices.logOutUser();
      HiveService.deleteToken();
      HiveService.deleteAdminID();
      HelperUtils.token = '';
      HelperUtils.adminID = '';
      globalSnackBar(
          title: "Logout Successfully", message: response.message.toString());
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.offAllNamed(Routes.LOGIN);
      handleException(e);
    }
  }

  /// Currency
  Future<void> getCurrency() async {
    try {
      final response = await apiServices.getCurrency();
      currency.value = response.data!;
    } catch (e) {
      handleException(e);
    }
  } //Get

  ///  Barchart
  double getMaxY() {
    if (dailyOrder.isNotEmpty) {
      int maxCount =
      dailyOrder.map((e) => e.count!).reduce((a, b) => a > b ? a : b);
      return maxCount.toDouble();
    } else {
      return 0;
    }
  }

  ///  Barchart
  List<BarChartGroupData> showingGroups() {
    return List.generate(dailyOrder.length, (i) {
      final dayOrder = dailyOrder[i];
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: touchedIndex.value == i
                ? dayOrder.count!.toDouble() + 0.2
                : dayOrder.count!.toDouble(),
            color: touchedIndex.value == i
                ? availableColors[Random().nextInt(availableColors.length)]
                : barColor,
            width: 15,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: getMaxY(),
              color: barBackgroundColor,
            ),
          ),
        ],
      );
    });
  }
  ///  Dashboard User count
  Future<void> fetchDashboardUserCount() async {
    try {
      final response = await apiServices.getDashboardUserCount();
      totalCardedCount.value = response.data!.totalCart!;
      totalActiveOrderedCount.value = response.data!.totalActiveOrder!;
      totalWishListedCount.value = response.data!.totalWishlist!;
      totalNotificationCount.value = response.data!.totalNotification!;
    } catch (e) {
      handleException(e);
    }
  }

  ///  Fetch SortFilter List
  void fetchSortFilterList() async {
    try {
      isSortFilterLoading.value = 1;
      final response = await apiServices.sortFilterList();
      sortList.value = response.data!.sort!;
      typeList.value = response.data!.type!;
      isSortFilterLoading.value = 0;
    } catch (e) {
      handleException(e);
      isSortFilterLoading.value = 2;
    }
  }

  @override
  void onInit() {
    if (HelperUtils.isLogin) {
      getCurrency();
      getWeeklyOrder();
      fetchSortFilterList();
      fetchDashboardUserCount();
    }
    chartController.addListener(() {
      chartController.value ? checked.value = true : checked.value = false;
    });
    super.onInit();
  }
}
