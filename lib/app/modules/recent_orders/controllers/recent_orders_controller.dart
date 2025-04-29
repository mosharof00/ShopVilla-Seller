import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/repository/api_services.dart';
import 'package:shop_villa_seller/gen/assets.gen.dart';
import 'package:shop_villa_seller/helper/exception_handle.dart';
import '../../../models/order_summary/all_order_status_model.dart';

class RecentOrdersController extends GetxController {
  ScrollController scrollController = ScrollController();
  final isScrolling = false.obs;
  final labelContainer = 0.obs;
  final selectedTabIndex = 0.obs;
  final selectedKeyword = "All".obs;

  /// API Service
  final apiServices = ApiServices();

  ///  for all/admin  Order Count
  final adminOrderCountResponseStatus =
      100.obs; // status 1 = loading, 2 = error, 0 = get
  final adminOrderCountList = <int>[].obs;

  ///  for pagination
  final currentPage = 0.obs;
  final isEndPage = false.obs;
  final scrollLoading = false.obs;

  /// for all order status get
  final allOrderResponseStatus =
      1.obs; // status 1 = loading, 2 = error, 0 = get
  final allOrderList = <AllOrderStatusList>[].obs;
  final totalPendingOrders = 0.obs;
  final totalConfirmedOrders = 0.obs;
  final totalCancelledOrders = 0.obs;
  final totalOngoingOrders = 0.obs;
  final totalDeliveredOrders = 0.obs;
  final totalReturnedOrders = 0.obs;

  /// for specific order status
  final selectedOrderStatus = 'Pending'.obs;
  final specificOrderResponseStatus =
      100.obs; // status 1 = loading, 2 = error, 0 = get
  final orderList = [].obs;

  /// static variables
  List<String> orderStatusNameList = [
    "All",
    "Pending",
    "Confirmed",
    "Ongoing",
    "Delivered",
    "Cancelled",
    "Rejected",
  ];

  ///   order  status colors
  List<Color> orderStatusColorList = [
    const Color(0xFF3dccc7),
    const Color(0xFF7b2cbf),
    const Color(0xFF3a0ca3),
    Colors.orange,
    Colors.green,
    Colors.red.shade900,
    const Color(0xFFff477e),
    Colors.grey,
  ];

  ///   order  status Icons
  List<String> orderStatusIconPathList = [
    Assets.icons.allProductOutlineIcon,
    Assets.icons.orderPendingIcon,
    Assets.icons.orderConfirmedIcon,
    Assets.icons.orderOngoingIcon,
    Assets.icons.orderDeliveredIcon,
    Assets.icons.orderCancelIcon,
    Assets.icons.orderRejectedIcon,
    Assets.icons.orderReturnedIcon,
  ];

  ///   get order status name
  void getOrders({required int index}) {
    orderList.clear();
    currentPage.value == 0;
    isEndPage.value = false;

    if (index == 0) {
      selectedOrderStatus.value = 'All';
      fetchSpecificOrderStatus(status: 'All');
    } else if (index == 1) {
      selectedOrderStatus.value = 'Pending';
      fetchSpecificOrderStatus(status: 'Pending');
    } else if (index == 2) {
      selectedOrderStatus.value = 'Confirmed';
      fetchSpecificOrderStatus(status: 'Confirmed');
    } else if (index == 3) {
      selectedOrderStatus.value = 'Ongoing';
      fetchSpecificOrderStatus(status: 'Ongoing');
    } else if (index == 4) {
      selectedOrderStatus.value = 'Delivered';
      fetchSpecificOrderStatus(status: 'Delivered');
    } else if (index == 5) {
      selectedOrderStatus.value = 'Canceled';
      fetchSpecificOrderStatus(status: 'Canceled');
    } else if (index == 6) {
      selectedOrderStatus.value = 'Rejected';
      fetchSpecificOrderStatus(status: 'Rejected');
    } else if (index == 7) {
      selectedOrderStatus.value = 'Returned';
      fetchSpecificOrderStatus(status: 'Returned');
    }
  }

  ///  Fetch Admin Order Count
  Future<void> fetchAdminOrderCount() async {
    adminOrderCountList.clear();
    try {
      adminOrderCountResponseStatus.value = 1;
      final response = await apiServices.adminOrderCount();
      adminOrderCountList.add(response.data!.total!);
      adminOrderCountList.add(response.data!.pending!);
      adminOrderCountList.add(response.data!.confirmed!);
      adminOrderCountList.add(response.data!.ongoing!);
      adminOrderCountList.add(response.data!.delivered!);
      adminOrderCountList.add(response.data!.canceled!);
      adminOrderCountList.add(response.data!.rejected!);
      adminOrderCountList.add(response.data!.returned!);
      adminOrderCountResponseStatus.value = 0;
    } catch (e) {
      handleException(e);
      adminOrderCountResponseStatus.value = 2;
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

      final response =
      await apiServices.getAllOrderStatus(status: status, page: page);
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

  ///   fetch data
  Future<void> fetchData() async{
    orderList.clear();
    currentPage.value == 0;
    isEndPage.value = false;
    fetchAdminOrderCount();
    await  fetchSpecificOrderStatus(
        status: orderStatusNameList[selectedTabIndex.value]);
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
    scrollController.addListener(() {
      isScrolling.value = scrollController.offset >= 100;
    });
  }
}