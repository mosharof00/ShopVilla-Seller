import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import '../../../../../helper/exception_handle.dart';
import '../../../../repository/api_services.dart';

class RecentOrdersListController extends GetxController {
  //TODO: Implement RecentOrdersListController
  /// API Service
  final apiServices = ApiServices();
  final allOrderResponseStatus =
      100.obs; // status 1 = loading, 2 = error, 0 = get
  final allOrderList = [].obs;
  final isSearchTapped = false.obs;
  final searchTextController = TextEditingController().obs;

  ///  for pagination
  final currentPage = 0.obs;
  final isEndPage = false.obs;
  final scrollLoading = false.obs;

  ///  on search button tap
  void searchOnTap() {
    if (searchTextController.value.text.isEmpty) {
      globalSnackBar(
          title: "Warning", message: " Please Inter a Order InvoiceId");
      return;
    }
    isSearchTapped.value = true;
    currentPage.value = 0;
    isEndPage.value = false;
    fetchAdminOrderSearch(invoiceID: searchTextController.value.text);
  }

  ///  Fetch Admin Order Search
  Future<void> fetchAdminOrderSearch({required String invoiceID}) async {
    try {
      allOrderResponseStatus.value = 1;
      final response = await apiServices.adminOrderSearch(invoiceID: invoiceID);
      allOrderList.value = response.data!.data!;
      allOrderResponseStatus.value = 0;
      isSearchTapped.value = false;
    } catch (e) {
      handleException(e);
      allOrderResponseStatus.value = 2;
      isSearchTapped.value = false;
    }
  }

  ///  Fetch All Order Status
  Future<void> fetchAllOrderStatus({required String status, int? page}) async {
    try {
      if (page == null) {
        allOrderResponseStatus.value = 1;
      }

      final response = await apiServices.getAllOrderStatus(status: status,page: page);
      if (response.data!.data!.isEmpty) {
        isEndPage.value = true;
        scrollLoading.value = false;
        return;
      }
      currentPage.value = response.data!.currentPage!;
      allOrderList.addAll(response.data!.data!);
      allOrderResponseStatus.value = 0;
      scrollLoading.value = false;
    } catch (e) {
      handleException(e);
      allOrderResponseStatus.value = 2;
      scrollLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchAllOrderStatus(status: 'All');
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    searchTextController.close();
    super.onClose();
  }
}
