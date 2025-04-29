import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/coupon/coupon_get_model.dart';
import '../../../repository/api_services.dart';
import '../../products/productDetails/controllers/product_details_controller.dart';

class PromosVouchersController extends GetxController {
  final containerSelect = 0.obs; // Select Promos Container
  TextEditingController codeTextEditor = TextEditingController();
  final apiService = Get.put(ApiServices()); // Api Service
  final productDetailsController = Get.put(ProductDetailsController());
  final primaryPromo = Rxn<Promos>();
  /// Promos Coupon
  final promosList = <Promos>[].obs;
  final Rx<int?> selectedPromosID = Rx<int?>(null); // Selected Promos ID
  Future<void> getPromos({bool isRefresh = false}) async {
    try {
      final getPromos = await apiService.getPromos(); // fetch Promos Data
      promosList.value = getPromos.data!;
      if (selectedPromosID.value == null && promosList.isNotEmpty) {
        selectedPromosID.value = promosList.first.id;
      }
    } catch (e) {
      handleException(e); // Handle Exception
    }
  }

  // Selected Promos will be Applied by Click
  void selectPromos(int promosID, String discount, String code) async {
    selectedPromosID.value = promosID;
    disCountAmount.value = int.parse(discount);
    await applyPromos(code: code);
  }

  /// Apply Coupon
  final isApply = false.obs;
  final disCountAmount = 0.obs;
  Future<void> applyPromos({required String code}) async {
    try {
      final applyPromos = await apiService.applyPromos(code); // Get Response
      if (applyPromos.status!) {
        isApply.value = true;
        disCountAmount.value = int.parse(applyPromos.data!.discount!);
        Get.snackbar('Promos & Coupon', applyPromos.message!);
      } else {
        isApply.value = false;
        Get.snackbar('Promos & Coupon', applyPromos.message!);
      }
    } catch (e) {
      handleException(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPromos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    codeTextEditor.clear();
  }
}
