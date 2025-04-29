import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/order place/user_orderlist_post_model.dart';
import '../../../repository/api_services.dart';
import '../../../routes/app_pages.dart';
import '../../products/productDetails/widget/awesome_dialog_login.dart';

class MyOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final picture = Assets.images.heels.path.obs;
  RxInt selectedTabIndex = 0.obs;
  late TabController tabController;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final isAccept = false.obs;
  final isDone = false.obs;
  final RefreshController refreshControllerActive =
      RefreshController(initialRefresh: false);
  final RefreshController refreshControllerComplete =
      RefreshController(initialRefresh: false);
  final RefreshController refreshControllerCancel =
      RefreshController(initialRefresh: false);

  /// Status
  /// App End => Api Response
  static const String statusPending = 'Pending';
  static const String statusConfirmed = 'Confirmed';
  static const String statusOngoing = 'Ongoing';
  static const String statusDelivered = 'Delivered';
  static const String statusCancelled = 'Canceled';
  static const String statusRejected = 'Rejected';

  /// Stepper
  RxInt activeStep = 0.obs;
  int getActiveStep(String status) {
    switch (status) {
      case statusPending:
        return 1;
      case statusConfirmed:
        return 2;
      case statusOngoing:
        return 3;
      case statusDelivered:
        return 4;
      default:
        return 0;
    }
  }

  String statusDesc(int activeStep) {
    String status = '';
    switch (activeStep) {
      case 1:
        status = 'Pending';
        break;
      case 2:
        status = 'Confirmed';
        break;
      case 3:
        status = 'Shipped';
        break;
      case 4:
        status = 'Delivered';
        break;
      default:
        status = 'Arrived';
        break;
    }
    return status;
  }

  //Date time
  var month = ''.obs;
  var day = ''.obs;
  var year = ''.obs;
  final date = ''.obs;

  ///  For Pagination
  final currentPage = 1.obs;
  final currentActivePage = 0.obs;
  final isEndPage = false.obs;
  final isEndActivePage = false.obs;
  final scrollLoading = false.obs;
  final scrollLoadingActive = false.obs;
  final isLoadingUserOrderList = true.obs;
  final isLoadingActiveOrderList = true.obs;

  /// Api Service
  final apiService = ApiServices();

  /// User Order List
  final userOrderList = UserOrderListGetModel().obs;
  final orderList = <MyOrder>[].obs;
  final orderListActive = <MyOrder>[].obs;
  final activeOrderList = <MyOrder>[].obs;
  final completeOrderList = <MyOrder>[].obs;
  final cancelOrderList = <MyOrder>[].obs;

  Future<void> getUserOrderList({bool isRefresh = false}) async {
    if (isRefresh) {
      currentActivePage.value = 0;
    }
    try {
      final list =
          await apiService.userOrderList(page: currentActivePage.value + 1);
      isRefresh
          ? refreshControllerComplete.refreshCompleted()
          : refreshControllerComplete.loadComplete();
      isLoadingUserOrderList.value = false;
      if (list.data!.data!.isEmpty) {
        isEndPage.value = true;
        scrollLoading.value = false;
      }

      currentPage.value = list.data!.currentPage!;
      scrollLoading.value = false;
      isRefresh
          ? orderList.value = list.data!.data!
          : orderList.addAll(list.data!.data!);
      completeOrderList.value = orderList
          .where((order) => [statusDelivered].contains(order.status))
          .toList();
      cancelOrderList.value = orderList
          .where((order) =>
              [statusCancelled, statusRejected].contains(order.status))
          .toList();
    } catch (e) {
      isLoadingUserOrderList.value = false;
      handleException(e);
      scrollLoading.value = false;
    }
  }

  Future<void> getActiveOrderList({bool isRefresh = false}) async {
    if (isRefresh) {
      currentActivePage.value = 0;
    }
    try {
      final list = await apiService.userActiveOrderList(
          page: currentActivePage.value + 1);
      isRefresh
          ? refreshControllerActive.refreshCompleted()
          : refreshControllerActive.loadComplete();
      isLoadingActiveOrderList.value = false;
      if (list.data!.data!.isEmpty) {
        isEndActivePage.value = true;
        scrollLoadingActive.value = false;
      }

      currentActivePage.value = list.data!.currentPage!;
      scrollLoadingActive.value = false;
      isRefresh
          ? orderListActive.value = list.data!.data!
          : orderListActive.addAll(list.data!.data!);
      activeOrderList.value = orderListActive;
    } catch (e) {
      isLoadingActiveOrderList.value = false;
      handleException(e);
      scrollLoadingActive.value = false;
    }
  }

  Future<void> cancelOrder(
      {required String invoiceID, required int index}) async {
    try {
      final cancelOrder = await apiService.cancelOrder(invoiceID: invoiceID);
      Get.snackbar('Cancel Order', cancelOrder.message!);
      MyOrder myOrder = activeOrderList[index];
      isLoadingUserOrderList.value = false;
      myOrder = myOrder.copyWith(
        status: 'Canceled',
      );
      activeOrderList.removeAt(index);
      activeOrderList.insert(index, myOrder);
      cancelOrderList.insert(0, myOrder);
    } catch (e) {
      isLoadingUserOrderList.value = false;
      handleException(e);
    }
  }

  Future<void> refreshActiveOrders() async {
    isEndActivePage.value = false;
    await getActiveOrderList();
  }

  Future<void> refreshUserCompleteOrders() async {
    isEndPage.value = false;
    await getUserOrderList();
  }

  Future<void> refreshUserCancelOrders() async {
    isEndPage.value = false;
    await getUserOrderList();
  }

  Color headerColor() {
    switch (activeStep.value) {
      case 0:
        return Colors.purple;
      case 1:
        return Colors.deepOrange;
      case 2:
        return Colors.teal;
      case 3:
        return ColorName.primaryColor;
      case 4:
        return ColorName.green;
      default:
        return Colors.purple;
    }
  }

  String headerText() {
    switch (activeStep.value) {
      case 1:
        return 'Reached our Facility';
      case 2:
        return 'Shipped';
      case 3:
        return 'Order Delivery';
      case 4:
        return 'Order Confirmed';
      default:
        return 'Introduction';
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    if (HelperUtils.isLogin) {
      getActiveOrderList();
      getUserOrderList();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (HelperUtils.isLogin) {
          // Fetch data after the build completes
          getActiveOrderList();
          getUserOrderList();
        } else {
          // Show dialog after the build completes
          DialogUtils.showWarningDialog(
            context: Get.context!,
            title: 'You have no Order',
            description: 'Please Log In',
            onOkPressed: () {
              Get.toNamed(Routes.LOGIN);
            },
          );
        }
      });
    }
  }

  void updateSelectedTab(int index) {
    selectedTabIndex.value = index;
    tabController.animateTo(index);
    update();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // For Cancel Order
  RxInt selectedReasonOptionIndex = 0.obs;
  final List<String> cancelReasonsList = [
    'Want to place a New order with more/different items.'.tr,
    'Delivery item is too long'.tr,
    'Duplicate order'.tr,
    'Shopping cost is too high'.tr,
    'Change of delivery address'.tr,
    'Forgot to use voucher/promos issue'.tr,
  ];
}
