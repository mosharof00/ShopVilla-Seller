import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/order_summary/order_statistics.dart';
import 'package:shop_villa_seller/app/repository/api_services.dart';
import 'package:shop_villa_seller/helper/exception_handle.dart';

import '../../../models/order_summary/sales_summary_model.dart';

class SalesSummaryController extends GetxController {
  // Api Service
  ApiServices apiServices = ApiServices();
  final salesSummary = SalesSummaryModel().obs;
  final isSalesSummaryLoading = true.obs;

  /// Order Statistics
  final orderStatistics = OrderSummary().obs;
  final yearlySaleList = <YearlySale>[].obs;
  final isLoadingOrderStatistics = true.obs;

  /// for specific order status
  final specificOrderResponseStatus =
      100.obs; // status 1 = loading, 2 = error, 0 = get
  final orderList = [].obs;

  ///  for pagination
  final currentPage = 0.obs;
  final isEndPage = false.obs;
  final scrollLoading = false.obs;

  // Date for Birthday
  Rx<DateTime?> myData = Rx<DateTime?>(null);
  late final date = "2024".obs;
  void setDate(DateTime? data) {
    myData.value = data;
    date.value = myData.value != null
        ? '${myData.value?.year}-${myData.value?.month.toString().padLeft(2, '0')}}'
        : '';
    if (date.value != "") {
      fetchOrderStatistics(year: date.value);
    }
  }

  // Fetch Sales Summary Data
  Future<void> fetchSalesSummary() async {
    try {
      isSalesSummaryLoading.value = true;
      final response = await apiServices.getSalesSummary(); // Get the data
      salesSummary.value = response;
      isSalesSummaryLoading.value = false;
    } catch (e) {
      handleException(e); // Handle Exception
      isSalesSummaryLoading.value = false;
    }
  }

  // Fetch Order Statistics
  Future<void> fetchOrderStatistics({String? year}) async {
    try {
      isLoadingOrderStatistics.value = true;
      final response = await apiServices.getOrderStatistics(year);
      orderStatistics.value = response.data!;
      yearlySaleList.value = response.data!.yearlySale!;
      isLoadingOrderStatistics.value = false;
    } catch (e) {
      handleException(e.toString()); // Handle Exception
      isLoadingOrderStatistics.value = false;
    }
  }

  ///  Fetch Specific Order Status
  Future<void> fetchSpecificOrderStatus(
      {required String status, int? page}) async {
    try {
      if (page == null) {
        specificOrderResponseStatus.value = 1;
        isEndPage.value = false;
        currentPage.value = 0;
      }
      final response = await apiServices.getAllOrderStatus(
          status: status, page: page); // Get the order status
      if (response.data!.data!.isEmpty) {
        isEndPage.value = true;
        scrollLoading.value = false;
        // return;
      }
      currentPage.value = response.data!.currentPage!;
      orderList.addAll(response.data!.data!);
      specificOrderResponseStatus.value = 0;
      scrollLoading.value = false;
    } catch (e) {
      handleException(e);
      specificOrderResponseStatus.value = 2;
      scrollLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchOrderStatistics();
    fetchSalesSummary();
    fetchSpecificOrderStatus(status: 'Delivered');
    super.onInit();
  }
}
