import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa_seller/app/models/brand/brand_model.dart';
import 'package:shop_villa_seller/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:shop_villa_seller/app/repository/api_services.dart';
import 'package:shop_villa_seller/app/routes/app_pages.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/category/Category_Model/category_model.dart';
import '../../../models/category/sub_category/sub_category_model.dart';
import '../../../models/product_model/porduct_model_api.dart';
import '../../../models/product_model/sort_filter__list_model.dart';
import '../../../models/supplier/supplier_get_model.dart';
import '../views/add_product_2_view.dart';

class AddProductController extends GetxController {
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final ApiServices apiService = ApiServices();
  final activeStep = 0.obs;
  final exampleController = TextEditingController();
  final appBarTitle = "".obs;
  final product = ProductData().obs;
  final isProductUpdateMode = false.obs;
  final isInitializing = 100.obs;

  final nameEditingController = TextEditingController();
  final skuEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final videoURLEditingController = TextEditingController();

  /// for category
  final categoryList = <Categories>[].obs;
  var selectedCategory = Rxn<Categories>();
  int? get selectedCategoryId => selectedCategory.value?.id;
  final isCategorySelected = false.obs;

  /// for sub category
  final subCategoryList = <SubCategory>[].obs;
  var selectedSubCategory = Rxn<SubCategory>();
  int? get selectedSubCategoryId => selectedSubCategory.value?.id;
  final isSubCategorySelected = false.obs;

  ///  Product Type
  final typeList = Get.find<DashboardController>().typeList;
  final selectedType = Rxn<FilterType>();
  String? get selectedTypeValue => selectedType.value?.value;
  final isSelectedType = false.obs;

  /// for gender
  final selectedGender = Rxn<GenderStaticModel>();

  final genderList = <GenderStaticModel>[
    GenderStaticModel(name: 'Men'),
    GenderStaticModel(name: 'Women'),
    GenderStaticModel(name: 'Unisex'),
  ];

  ///  for brands
  final brandList = <BrandData>[].obs;
  final selectedBrand = Rxn<BrandData>();
  int? get selectedBrandID => selectedBrand.value?.id;

  ///  for supplier
  final supplierList = <Supplier>[].obs;
  final selectedSupplier = Rxn<Supplier>();

  // ///   Product Status
  // final selectedProductStatus = Rxn<ProductStatusStaticModel>();
  // final isStatusSelected = false.obs;
  // final productStatusList = <ProductStatusStaticModel>[
  //   ProductStatusStaticModel(name: 'Active'),
  //   ProductStatusStaticModel(name: 'Inactive'),
  // ];

  Future<void> selectCategory(Categories? category) async {
    subCategoryList.clear();
    selectedSubCategory.value = null;
    selectedCategory.value = category;
    isCategorySelected.value = true;
    isSubCategorySelected.value = false;
    await fetchSubCategories(subCategoryId: selectedCategoryId!);
  }

  void selectSubCategory(SubCategory? subCategory) {
    selectedSubCategory.value = subCategory;
    isSubCategorySelected.value = true;
  }

  void selectProductType(FilterType? type) {
    selectedType.value = type;
    isSelectedType.value = true;
  }

  void selectGender(GenderStaticModel? gender) {
    selectedGender.value = gender;
  }

  void selectBrand(BrandData? brand) {
    selectedBrand.value = brand;
  }

  void selectSupplier(Supplier? supplier) {
    selectedSupplier.value = supplier;
  }

  // void selectProductStatus(ProductStatusStaticModel? status) {
  //   selectedProductStatus.value = status;
  //   isStatusSelected.value = true;
  // }

  ///  Fetch Add Product
  Future<void> fetchAddProduct() async {
    try {
      btnController.start();
      final response = await apiService.addProduct(
        productName: nameEditingController.text,
        productSKU: skuEditingController.text,
        productDescription: descriptionEditingController.text,
        categoryID: selectedCategoryId!,
        subCategoryID: selectedSubCategoryId!,
        status: HelperUtils.productInactiveStatus,
        // selectedProductStatus.value!.name,
        type: selectedTypeValue!,
        brandId: selectedBrandID,
        supplierID: selectedSupplier.value?.id,
        gander: selectedGender.value?.name,
        youtubeURL: videoURLEditingController.text,
      );
      btnController.stop();
      Log.i('Product ID is : ${response.data!.id}');
      activeStep.value++;
      Get.to(() => const AddProduct2View(),
          arguments: {"id": response.data!.id!});
    } catch (e) {
      handleException(e);
      btnController.stop();
    }
  }

  ///   setUp product Update Product
  Future<void> setUpToUpdateProduct(ProductData product) async {
    nameEditingController.text = product.productName!;
    skuEditingController.text = product.productSku!;
    descriptionEditingController.text = product.productDescription!;
    videoURLEditingController.text = product.youtubeEmbadecode ?? '';

    ///  set category
    selectedCategory.value = categoryList
        .firstWhere((category) => category.id == product.categoryId);
    await selectCategory(selectedCategory.value);

    ///  set subCategory
    selectedSubCategory.value = subCategoryList
        .firstWhere((subCategory) => subCategory.id == product.subCategoryId);
    selectSubCategory(selectedSubCategory.value);

    ///  set  product type
    selectedType.value =
        typeList.firstWhere((type) => type.value == product.type);
    selectProductType(selectedType.value);

    ///  set brand
    selectedBrand.value = product.brandId == null
        ? null
        : brandList.firstWhere((brand) => brand.id == product.brandId);

    ///  set gender
    selectedGender.value = product.gander == null
        ? null
        : genderList.firstWhere((gender) => gender.name == product.gander);

    ///  set supplier
    selectedSupplier.value = product.supplierId == null
        ? null
        : supplierList
            .firstWhere((supplier) => supplier.id == product.supplierId);
  }

  ///  Fetch Update Product
  Future<void> fetchUpdateProduct() async {
    try {
      btnController.start();
      final response = await apiService.updateProduct(
        productID: product.value.id!,
        productName: nameEditingController.text,
        productSKU: skuEditingController.text,
        productDescription: descriptionEditingController.text,
        categoryID: selectedCategoryId!,
        subCategoryID: selectedSubCategoryId!,
        status: product.value.status!,
        // selectedProductStatus.value!.name,
        type: selectedTypeValue!,
        brandId: selectedBrandID,
        supplierID: selectedSupplier.value?.id,
        gander: selectedGender.value?.name,
        youtubeURL: videoURLEditingController.text,
      );
      btnController.stop();
      Log.i('Product ID is : ${response.data!.id}');
      activeStep.value++;
      Get.to(() => const AddProduct2View(),
          arguments: {"id": response.data!.id!});
    } catch (e) {
      handleException(e);
      btnController.stop();
    }
  }

  /// Fetch Category
  Future<void> fetchCategory() async {
    try {
      final categories = await apiService.getCategory();
      categoryList.value = categories.data!;
      // productList.assignAll(products);
      // trendingProductList.shuffle();
      // flashSalesList.value = products.reversed.toList();
    } catch (e) {
      handleException(e);
    }
  }

  /// Fetch SubCategory Product
  Future<void> fetchSubCategories({required int subCategoryId}) async {
    // Log.i(subCategoryId);
    try {
      final response =
          await apiService.getSubCategory(categoryId: subCategoryId);
      subCategoryList.value = response.data!;
    } catch (e) {
      handleException(e);
      globalSnackBar(title: "Error", message: e.toString());
    }
  }

  ///   Fetch Brands
  Future fetchBrands() async {
    try {
      final response = await apiService.getBrands();
      brandList.value = response.data!.data!;
    } catch (e) {
      handleException(e);
    }
  }

  ///  fetch supplier
  Future<void> fetchSupplier() async {
    try {
      final response = await apiService.supplierList();
      supplierList.value = response.data!
          .where((supplier) => supplier.status == 'Active')
          .toList();
      // supplierList.value = response.data!;
      // Generate unique keys for each supplier
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> initialize() async {
    try {
      isInitializing.value = 1;
      await fetchCategory();
      await fetchBrands();
      await fetchSupplier();
      if (isProductUpdateMode.value) {
        await setUpToUpdateProduct(product.value);
      }
      isInitializing.value = 0;
    } catch (e) {
      isInitializing.value = 2;
      Log.e('Fail Category and Brand  initialization $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    initialize();
    if (Get.previousRoute == Routes.EDIT_PRODUCT) {
      product.value = Get.arguments['product'];
      Log.i(
          "product is: ${product.value} and id is:${product.value.id} \n category id:${product.value.categoryId}  subCategory id: ${product.value.subCategoryId}");
      isProductUpdateMode.value = true;
    } else {
      isProductUpdateMode.value = false;
    }
    super.onInit();
  }

  @override
  void dispose() {
    nameEditingController.clear();
    skuEditingController.clear();
    descriptionEditingController.clear();
    videoURLEditingController.clear();
    super.dispose();
  }
}

class GenderStaticModel {
  GenderStaticModel({required this.name});
  final String name;
}

// class ProductStatusStaticModel {
//   ProductStatusStaticModel({required this.name});
//   final String name;
// }
