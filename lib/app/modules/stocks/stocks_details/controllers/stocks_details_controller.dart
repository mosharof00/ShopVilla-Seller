import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/product_model/porduct_model_api.dart';

class StocksDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: productVariationList.length,
    vsync: this,
  );
  final selectedImage = 0.obs;
  final selectedTabIndex = 0.obs;
  final product = ProductData().obs;
  List<ProductVariationData> productVariationList = [];
  List<SizeData> allProductSizes = [];
  final productSizeList = <SizeData>[].obs;

  ///  update selected tap
  final isLoading = true.obs;
  void updateSelectedTab(int index) {
    selectedTabIndex.value = index;
    selectedTabIndex.value = index;
    final ProductVariationData selectedProductVariation =
        productVariationList[selectedTabIndex.value];
    productSizeList.value = allProductSizes
        .where((allProductSizes) =>
            allProductSizes.varientId == selectedProductVariation.id)
        .toList();
    tabController.animateTo(selectedTabIndex.value);
    update();
    isLoading.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    product.value = Get.arguments;
    productVariationList = product.value.productvariations!;
    allProductSizes = product.value.sizes!;
    tabController;
    updateSelectedTab(selectedTabIndex.value);

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
