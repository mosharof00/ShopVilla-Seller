import 'package:get/get.dart';

import '../../../../helper/exception_handle.dart';
import '../../../models/product_model/porduct_model_api.dart';
import '../../../repository/api_services.dart';

class EditProductController extends GetxController {
  //TODO: Implement EditProductController

  /// API Service
  final apiService = ApiServices();

  /// Admin Stock

  var productModelApi = ProductModelApi().obs;
  final productList = [].obs;
  final isLoading =
      100.obs; //  0 = successfully get product, 1=loading , 2= error
  ///  for pagination
  final currentPage = 0.obs;
  final isEndPage = false.obs;
  final scrollLoading = false.obs;
  final isLoadingStock = true.obs;
  Future<void> getStock() async {
    try {
      final stock = await apiService.getStock();
      // adminStock.value = stock.data!;
      isLoadingStock.value = false;
    } catch (e) {
      isLoadingStock.value = false;
      handleException(e);
    }
  }

  ///  Fetch Products
  void fetchProducts({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? page,
  }) async {
    // if (isEndPage.value) return;
    try {
      if (page == null) {
        isLoading.value = 1;
      }
      final products = await apiService.getProduct(
        sort: sort,
        filterType: filterType,
        filterSizeID: filterSizeID,
        filterColorID: filterColorID,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        page: page,
      );
      if (products.data!.data!.isEmpty) {
        isEndPage.value = true;
        scrollLoading.value = false;
        return;
      }
      productList.addAll(products.data!.data!);
      currentPage.value = products.data!.currentPage!;
      isLoading.value = 0;
      scrollLoading.value = false;
    } catch (e) {
      handleException(e);
      isLoading.value = 2;
      scrollLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getStock();
    fetchProducts();
    super.onInit();
  }
}
