import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa_seller/app/models/order_status&list/change_admin_order_status_model.dart';
import 'package:shop_villa_seller/app/repository/api_services.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/order place/re_order_model.dart';
import '../../../models/order_summary/all_order_status_model.dart';
import '../../../routes/app_pages.dart';
import '../../checkout/widgets/webview.dart';
import '../../profile/paymentMethods/controllers/payment_methods_controller.dart';

class OrderInfoController extends GetxController {
  ScrollController scrollController = ScrollController();
  RoundedLoadingButtonController roundedLoadingButtonController =
  RoundedLoadingButtonController();
  final isVisible = false.obs;
  ApiServices apiServices = ApiServices();

  ///   for copy invoiceID   using 'clipboard' package
  final isSelect = false.obs;

  ///  Total Sum
  late RxInt sum = 0.obs;

  ///  calculate total sum of total ordered product amount
  int totalSum(String subTotal, String shippingCharge, String promos) {
    sum.value =
        (int.parse(subTotal) + int.parse(shippingCharge)) - int.parse(promos);
    return sum.value;
  }

  /// for order
  final order = <AllOrderStatusList>[].obs;
  final orderResponseStatus = 100.obs;

  /// for change order Status
  final changeAdminOrderStatus = ChangeAdminOrderStatusModel().obs;
  final newStatus = "".obs;
  final changeOrderResponseStatus = 0.obs;

  /// Payment Method
  final paymentController = Get.put(PaymentMethodsController());
  final gateway = ''.obs;
  final image = ''.obs;
  void getPaymentMethod(String method) {
    for (var paymentMethod in paymentController.paymentTypeList) {
      if (paymentMethod.value == method) {
        gateway.value = paymentMethod.status ?? 'Cash On Delivery';
        image.value = paymentMethod.image ?? 'Unknown';
        return;
      }
    }
  }

  String convertPaymentMethod(String paymentMethod) {
    return paymentMethod
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Future<void> launchGoogleMaps() async {
    final Uri googleMapsUri =
    Uri.parse('https://maps.app.goo.gl/dDXc5Md4roTYSk9F9');
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      throw 'Could not launch $googleMapsUri';
    }
  }

  ///  get im_stepper position
  RxInt activeStep = 0.obs;
  void updateActiveStep({required String status}) {
    switch (status) {
      case 'Pending':
        activeStep.value = 0;
        break;
      case 'Confirmed':
        activeStep.value = 1;
        break;
      case 'Ongoing':
        activeStep.value = 2;
        break;
      case 'Delivered':
        activeStep.value = 3;
        break;
    }
  }

  ///  get im_stepper status color
  Color headerColor() {
    switch (activeStep.value) {
      case 0:
        return const Color(0xFF7b2cbf);
      case 1:
        return const Color(0xFF3a0ca3);
      case 2:
        return Colors.orange;
      case 3:
        return ColorName.green;
    }
    return Colors.grey;
  }

  ///   on status change floatingActionButton status color
  Color buttonColor() {
    switch (activeStep.value) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      case 3:
        return ColorName.primaryColor;
    }
    return Colors.grey;
  }

  ///   on status change floatingActionButton status text
  String buttonText() {
    switch (activeStep.value) {
      case 0:
        return 'Accept';
      case 1:
        return 'Ongoing';
      case 2:
        return 'Delivered';
      case 3:
        return 'Done';
    }
    return 'Exception';
  }

  ///  Fetch  Change Admin Order  Status
  Future<void> fetchChangeAdminOrderStatus(
      {required String invoiceId, required String status}) async {
    try {
      changeOrderResponseStatus.value = 1;
      final response = await apiServices.changeAdminOrderStatus(
          invoiceID: invoiceId, status: status);
      changeAdminOrderStatus.value = response;
      activeStep.value++;
      newStatus.value = response.data!.status!;
      changeOrderResponseStatus.value = 0;
      globalSnackBar(title: "Success!", message: " Status changed");
    } catch (e) {
      handleException(e);
      changeOrderResponseStatus.value = 2;
    }
  }

  /// Re-Order

  final apiService = ApiServices();
  final reOrderData = ReOrder().obs;
  Future<void> reOrder({required String invoiceID, required String paymentMethod}) async {
    try{
      final response = await apiService.reOrder(invoiceID, paymentMethod);
      if (response.data != null) {
        reOrderData.value = response.data!;
        String paymentUrl = reOrderData.value.redirectUrl!;
        Get.to(() => PaymentWebViewScreen(url: paymentUrl));
      } else {
        Get.snackbar('Re Order', 'Sorry there has some problem');
        Get.offAllNamed(Routes.MAIN_PAGE);
        Get.toNamed(Routes.MY_ORDER);
      }
    }catch(e){
      handleException(e);
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(() {
      isVisible.value =
          scrollController.offset == scrollController.position.maxScrollExtent;
    });
  }
}