import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/payment_method/payment_method.dart';
import 'package:shop_villa_seller/app/repository/api_services.dart';
import 'package:shop_villa_seller/helper/exception_handle.dart';

class PaymentMethodsController extends GetxController {
  // Selected Payment Index
  RxInt paymentSelectIndex = 0.obs;

  /// Api
  final apiService = ApiServices();
  final paymentTypeList = <PaymentType>[].obs;
  final selectedPaymentType = 'stripe'.obs;
  final isPartialEnabled = false.obs;
  final partialAmount = '0'.obs;
  final partialPaymentText = ''.obs;
  final isPaymentMethodLoading = true.obs;

  Future<void> getPaymentType() async {
    try {
      isPaymentMethodLoading.value = true;
      final response = await apiService.getPaymentType(); // Get Payment Methods
      paymentTypeList.value = response.data!.type!;
      paymentTypeList.value = paymentTypeList.where((status)=> status.active!).toList();
      if(response.data!.advancePaymentStatus == 'ON'){
        isPartialEnabled.value = true;
        partialPaymentText.value = response.data!.advancePaymentTitle!;
        partialAmount.value = response.data!.advancePayment!;
      }else {
        isPartialEnabled.value = false;
      }
      isPaymentMethodLoading.value = false;
    } catch (e) {
      isPaymentMethodLoading.value = false;
      handleException(e);
    }
  }

  @override
  void onInit() {
    getPaymentType();
    super.onInit();
  }
}
