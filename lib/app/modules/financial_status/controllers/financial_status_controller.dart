import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_villa_seller/app/models/financial_status/financial_status_model.dart';
import 'package:shop_villa_seller/app/models/financial_status/order_by_category_model.dart';
import 'package:shop_villa_seller/app/models/financial_status/yearly_sell_model.dart';
import 'package:shop_villa_seller/app/repository/api_services.dart';
import 'package:shop_villa_seller/helper/exception_handle.dart';

class FinancialStatusController extends GetxController {
  // Index for handling pie chart interactions (e.g., touched slices)
  final pieTouchedIndex = 0.obs;
  final touchedIndex = 13.obs;

  // Date Picker
  Rx<DateTime?> myData =
  Rx<DateTime?>(DateTime.now()); // Holds the selected date
  late final date = "".obs; // Formatted date as a string
  late final monthName = DateFormat('MMMM')
      .format(DateTime.now())
      .obs; // Holds the name of the month
  late final year = DateFormat('yyyy').format(DateTime.now()).obs;
  // Set the date and fetch financial data based on the selected date
  void setDate(DateTime? data) {
    myData.value = data;
    if (myData.value != null) {
      date.value =
      '${myData.value?.year}-${myData.value?.month.toString().padLeft(2, '0')}';
      monthName.value = DateFormat('MMMM')
          .format(myData.value!); // Extracts the full month name
      year.value = DateFormat('yyyy').format(myData.value!);
    } else {
      date.value = '';
      monthName.value = '';
      year.value = '';
    }
    if (date.value != "") {
      //getFinancialStatus(date: date.value);
      //getYearlySell(date: date.value);
    }
  }

  // Dropdown for selecting between 'Monthly' and 'Yearly' views
  final dropDownValue = 'Monthly'.obs;
  List<String> list = [
    'Monthly'.tr,
    'Yearly'.tr,
  ];

  // Update the selected value in the dropdown
  void onChanged(String? selectedValue) {
    if (selectedValue != null) {
      dropDownValue.value = selectedValue;
    }
  }

  // API service instance
  final apiService = ApiServices();

  // List to hold order categories retrieved from the API
  final orderCategory = <OrderCategory>[].obs;
  final isLoadingOrderCategory = true.obs;
  // Fetches order data by category and sorts it by percentage (descending order)
  Future<void> getOrderByCategory() async {
    try {
      final response = await apiService.getOrderByCategory();

      if(response.status!){
        isLoadingOrderCategory.value = false;
        response.data!
            .sort((a, b) => b.percent!.compareTo(a.percent!.toDouble()));
        orderCategory.value = response.data!.take(5).toList(); // Limit to top 5
      } else {
        isLoadingOrderCategory.value = false;
        orderCategory.value = [];
      }
    } catch (e) {
      isLoadingOrderCategory.value = false;
      handleException(e);
    }
  }

  // Financial Status Data
  final financialStatus = FinancialStatus().obs; // Overall financial status
  final financialStatusList = <WeeklySale>[].obs; // Weekly sales data
  //final financialStatusTooltipBehavior = TooltipBehavior(enable: true, canShowMarker: true);
  final financialStatusData = [].obs; // Data for the financial status chart
  int maxCount = 0; // Stores the maximum order count
  // Fetches financial status based on a date (if provided)
  Future<void> getFinancialStatus({String? date}) async {
    try {
      final response = await apiService.getFinancialStatus(date);
      financialStatus.value = response.data!;
      financialStatusList.value = response.data!.weeklySales!;
      getOrderCount(); // Calculate the max order count
    } catch (e) {
      handleException(e);
    }
  }
  double calculateInterval(double maxY) {
    if (maxY <= 10) return 2;
    if (maxY <= 50) return 10;
    if (maxY <= 100) return 20;
    if (maxY <= 500) return 100;
    if (maxY <= 1000) return 200;
    if (maxY <= 5000) return 1000;
    if (maxY <= 10000) return 2000;
    if (maxY <= 50000) return 10000;
    if (maxY <= 100000) return 20000;
    if (maxY <= 500000) return 100000;
    return maxY / 5; // Default case for very large numbers
  }

  // Calculate the maximum order count from the weekly sales data
  int getOrderCount() {
    for (var i = 0; i < financialStatusList.length; i++) {
      maxCount = financialStatusList
          .map((e) => e.totalSales!)
          .reduce((a, b) => a > b ? a : b);
    }
    return maxCount;
  }

  // Yearly Sell Data
  final yearly = YearlySellModel().obs; // Yearly sell model
  final yearlySell = <YearlySell>[].obs; // List of yearly sales data

  final List<String> allMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ]; // List of all months

  // Fetches yearly sales data based on a date (if provided)

  Future<void> getYearlySell({String? date}) async {
    try {
      final response = await apiService.getYearlySell(date);
      yearly.value = response;
      yearlySell.value = response.data!;
      if (yearlySell.isEmpty) {
        debugPrint('No data');
      } else {
        // Map data to chart, showing 0 for missing months
        // data.value = allMonths.map((month) {
        //   final YearlySell? match = yearlySell.firstWhereOrNull(
        //           (element) => element.month!.substring(0, 3) == month);
        //   if (match != null) {
        //     return SeriesChartData(month, match.percent!.toDouble());
        //   } else {
        //     return SeriesChartData(month, 0); // Default 0 if month data is missing
        //   }
        // }).toList();
      }
    } catch (e) {
      handleException(e);
    }
  }

  @override
  void onInit() {
    // Fetch initial financial and yearly sell data on controller initialization
    getFinancialStatus();
    getYearlySell();
    getOrderByCategory();
    super.onInit();
  }

  // List of colors for pie chart segments
  List<Color> pieChartColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
  ];
}

