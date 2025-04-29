import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa_seller/app/models/supplier/supplier_get_model.dart';
import 'package:shop_villa_seller/app/repository/api_services.dart';
import 'package:shop_villa_seller/helper/exception_handle.dart';

import '../../../../global/log_printer.dart';

class SupplierController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final nameError = ''.obs;
  final phoneError = ''.obs;
  final emailError = ''.obs;
  final addressError = ''.obs;

  final isUpdateMode = false.obs;

  final isLoading = false.obs;

  // Create a list to store dynamic keys
  List<GlobalKey<ExpansionTileCardState>> keys = [];

  // Loading button
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  /// Api Service
  final apiService = ApiServices();
  final supplierList = <Supplier>[].obs;

  // List of Supplier
  Future<void> getSupplier() async {
    try {
    isLoading.value = true;
      final response = await apiService.supplierList();
      supplierList.value = response.data!
          .where((supplier) => supplier.status == 'Active')
          .toList();
      // Generate unique keys for each supplier
      keys = List.generate(
          supplierList.length, (index) => GlobalKey<ExpansionTileCardState>(),
          );
          isLoading.value = false;
    } catch (e) {
      handleException(e);
         isLoading.value = false;
    }
  }

  /// Add Supplier
  Future<void> addSupplier({
    required String name,
    required String phone,
    required String email,
    required String address,
  }) async {
    try {
      final response = await apiService.supplierAdd(
          name: name, phone: phone, email: email, address: address);
      if (response.status!) {
        btnController.stop();
        supplierList.clear();
        getSupplier();
        Get.back();
        Get.snackbar('Supplier', response.message!);
      }
    } catch (e) {
      Get.snackbar('Supplier', 'Unsuccessful');
      btnController.stop();
      handleException(e);
    }
  }

  /// Update Supplier
  Future<void> updateSupplier({
    required String name,
    required String phone,
    required String email,
    required String address,
    required String id,
  }) async {
    try {
      final response = await apiService.supplierUpdate(
          name: name, phone: phone, email: email, address: address, id: id);
      if (response.status!) {
        supplierList.clear();
        getSupplier();
        btnController.stop;
        Get.back();
        Get.snackbar('Supplier', response.message!);
      }
    } catch (e) {
      Get.snackbar('Supplier', 'Update Unsuccessful');
      btnController.stop();
      handleException(e);
    }
  }

  /// Delete
  Future<void> deleteSupplier({required id}) async {
    try{
      final response = await apiService.supplierDelete(id: id);
      if(response.status!){
        supplierList.clear();
        getSupplier();
        btnController.stop();
        Get.snackbar('Supplier', response.message!);
      }
    }catch(e){
      Get.snackbar('Supplier', 'Cant Delete');
      btnController.stop();
      handleException(e);
    }
  }


  /// Method to set sub category details for update
  final supplierID = 0.obs;
  void setSupplierUpdate(Supplier supplier) {
    nameController.text = supplier.supplierName!;
    phoneController.text = supplier.supplierPhone!;
    emailController.text = supplier.supplierEmail!;
    addressController.text = supplier.supplierAddress!;
    supplierID.value = supplier.id!;
  }

  void clear() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
  }

  @override
  void onInit() {
    getSupplier();
    super.onInit();
  }
}
