import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa_seller/app/modules/add_product/controllers/add_product_controller.dart';
import 'package:shop_villa_seller/app/routes/app_pages.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import 'package:shop_villa_seller/helper/exception_handle.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../global/awesome_alert_dialog.dart';
import '../../../../global/bottomSheet/custom_bottom_sheet.dart';
import '../../../../global/global_controllers/product_attributes_controller.dart';
import '../../../../global/log_printer.dart';
import '../../../models/add_product_model/product_attribute_model.dart';
import '../../../models/product_details/product_details_model.dart';
import '../../../repository/api_services.dart';

class AddProductVariationController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final apiServices = ApiServices();
  final productID = 0.obs;
  final Rx<XFile?> selectedPhoto = Rx<XFile?>(null);

  ///  for color
  final selectedColor = Rxn<Attribute>();
  final isColorSelected = false.obs;

  ///  for size
  final selectedSize = Rxn<Attribute>();
  final isSizeSelect = false.obs;

  ///  for sub variation
  TextEditingController pricesEditingController = TextEditingController();
  TextEditingController discountEditingController = TextEditingController();
  TextEditingController purchaseEditingController = TextEditingController();
  TextEditingController quantityEditingController = TextEditingController();
  final subVariationList = <SubVariationModel>[].obs;
  final isSubVariationSelect = true.obs;

  ///   for image
  final selectedImageList = [].obs;
  final isImageSelect = true.obs;

  ///  for view product details
  final selectedImage = 0.obs;
  final selectedTabIndex = 0.obs;
  final product = ProductDetailsData().obs;
  final productVariationList = <Productvariation>[].obs;
  final selectedProductVariation = Rxn<Productvariation>();
  final variationColorName = "".obs;
  List<DataSize> allProductSizes = [];
  final selectedSizeList = <DataSize>[].obs;
  final selectedProductVariationImageList = <MullipleImage>[].obs;
  final existingVariationIDList = <int>[].obs;

  ///  get selected Color
  void selectColor(Attribute? color) {
    selectedColor.value = color;
    isColorSelected.value = true;
  }

  ///  update selected tap
  final isChangeTabLoading = false.obs;
  void updateSelectedTab(int index) {
    isChangeTabLoading.value = true;
    selectedTabIndex.value = index;
    selectedProductVariation.value =
        productVariationList[selectedTabIndex.value];
    variationColorName.value =
        productVariationList[selectedTabIndex.value].color!;
    selectedProductVariationImageList.value =
        selectedProductVariation.value!.mullipleImages!;
    selectedSizeList.value = allProductSizes
        .where((allProductSizes) =>
            allProductSizes.varientId == selectedProductVariation.value!.id)
        .toList();
    tabController.animateTo(selectedTabIndex.value);
    update();
    isChangeTabLoading.value = false;
  }

  final variationAddToUpdateSelectedID = ''.obs;

  bool isAlreadyExistedVariation({required int selectedColorID}) {
    var variation = productVariationList.firstWhere(
      (variation) => variation.colorId == selectedColorID,
      orElse: () =>
          Productvariation(), // Return a default Productvariation object
    );

    if (variation.id != null) {
      variationAddToUpdateSelectedID.value = variation.id!.toString();
      return true;
    } else {
      return false;
    }
  }

  void addSubVariation() {
    subVariationList.add(
      SubVariationModel(
          sizeID: selectedSize.value!.id.toString(),
          size: selectedSize.value!.name.toString(),
          price: pricesEditingController.text,
          discount: discountEditingController.text,
          purchasePrice: purchaseEditingController.text,
          quantity: quantityEditingController.text),
    );
    clearSubVariationsData();
    Log.i(subVariationList);
    Get.back();
  }

  void removeSubVariation({required int index}) {
    subVariationList.removeAt(index);
  if(subVariationList.isEmpty){
    isSubVariationSelect.value = false;
  }
  }

  ///   fetch Add Product Variations
  Future<void> addProductVariations() async {
    btnController.start();
    var selectedVariations = <String, dynamic>{};
    for (int i = 0; i < subVariationList.length; i++) {
      final subVariation = subVariationList[i];
      selectedVariations.addAll({
        'size[$i][sizeID]': subVariation.sizeID,
        'size[$i][size]': subVariation.size,
        'size[$i][RegularPrice]': subVariation.price,
        'size[$i][Discount]': subVariation.discount,
        'size[$i][Stock]':
            subVariation.quantity, // Assuming quantity is treated as stock
        'size[$i][buy_price]': subVariation.purchasePrice,
      });
    }
    try {
      isFetchProductDetailsLoading.value = 1;
      final response = await apiServices.addProductVariation(
          productId: '$productID',
          colorID: '${selectedColor.value!.id}',
          codeID: '',
          imageList: selectedImageList,
          selectedVariations: selectedVariations);
      Log.e(response.data!.variation.toString());
      globalSnackBar(
          durationInSeconds: 2, title: 'Success!', message: response.message!);
      selectedImageList.clear();
      subVariationList.clear();
      btnController.stop();
      fetchProductDetails();
    } catch (e) {
      handleException(e);
      btnController.stop();
      globalSnackBar(
          durationInSeconds: 2,
          title: 'UnSuccessful!',
          message: "Variation is not Added");
      isFetchProductDetailsLoading.value = 0;
    }
  }

  ///         for Update Product Variation            ///
  final isWantToUpdate = false.obs;
  void setupToUpdateProductVariation() {
    isWantToUpdate.value = true;
    clearSelectedVariations();

    // Log.i("${selectedProductVariation.value!.color.toString()} and Id is:${selectedProductVariation.value!.id.toString()}");
    // selectedColor.value =  Attribute(
    //   id: selectedProductVariation.value!.id,
    //   name: selectedProductVariation.value!.color,
    //   value: '1',
    //   colorCode: selectedProductVariation.value!.colorCode,
    //   attributeNameId: 1,
    //   status: 1,
    //   createdAt: selectedProductVariation.value!.createdAt,
    //   updatedAt: selectedProductVariation.value!.updatedAt,
    // );
    // Log.i("selected Color Name is: ${selectedColor.value!.name}");

    // ///   take existing Images
    // for (int i = 0; i < selectedImageList.length; i++) {
    //   selectedImageList.add(selectedImageList[i].imagePath);
    //   Log.d(selectedImageList[i].imagePath);
    // }

    ///   take existing SubVariations
    for (int i = 0; i < selectedSizeList.length; i++) {
      final DataSize size = selectedSizeList[i];
      subVariationList.add(
        SubVariationModel(
          sizeID: size.sizeId.toString(),
          size: size.size!,
          price: size.regularPrice.toString(),
          discount: size.discount.toString(),
          purchasePrice: size.buyPrice.toString(),
          quantity: size.stock.toString(),
        ),
      );
    }
  }

  void clearSelectedVariations() {
    selectedColor.value = null;
    selectedImageList.clear();
    subVariationList.clear();
    isColorSelected.value = false;
    isColorSelected.value = false;
    isImageSelect.value = false;
    isSubVariationSelect.value = false;
  }

  ///   fetch Update Product Variations
  Future<void> updateProductVariations({required String variationID}) async {
    btnController.start();
    var selectedVariations = <String, dynamic>{};
    for (int i = 0; i < subVariationList.length; i++) {
      final subVariation = subVariationList[i];
      selectedVariations.addAll({
        'size[$i][sizeID]': subVariation.sizeID,
        'size[$i][size]': subVariation.size,
        'size[$i][RegularPrice]': subVariation.price,
        'size[$i][Discount]': subVariation.discount,
        'size[$i][Stock]':
            subVariation.quantity, // Assuming quantity is treated as stock
        'size[$i][buy_price]': subVariation.purchasePrice,
      });
    }
    try {
      Log.i(
          "Update variation Called. Variation ID is: ${selectedProductVariation.value!.id.toString()}");
      isFetchProductDetailsLoading.value = 1;
      final response = await apiServices.updateProductVariation(
        productId: '$productID',
        variationID: variationID,
        colorID: '${selectedProductVariation.value!.colorId}',
        codeID: '',
        imageList: selectedImageList,
        selectedVariations: selectedVariations,
      );
      Log.e(response.data!.variation.toString());
      globalSnackBar(
          durationInSeconds: 2, title: 'Success!', message: response.message!);
      selectedImageList.clear();
      subVariationList.clear();
      Log.i(response.message);
      btnController.stop();
      fetchProductDetails();
    } catch (e) {
      handleException(e);
      globalSnackBar(
          durationInSeconds: 2,
          title: 'UnSuccessful!',
          message: "Variation is not Update");
      btnController.stop();
      isFetchProductDetailsLoading.value = 0;
    }
  }

  void clearSubVariationsData() {
    selectedSize.value = null;
    pricesEditingController.clear();
    quantityEditingController.clear();
    discountEditingController.clear();
    purchaseEditingController.clear();
    isSizeSelect.value = false;
  }

  ///   fetch  Product Details
  final isFetchProductDetailsLoading = 10000.obs;
  Future<void> fetchProductDetails() async {
    try {
      isFetchProductDetailsLoading.value = 1;
      Log.i('Product details called and product id is: ${productID.value}');
      final response = await apiServices.getProductDetails(productID.value);
      product.value = response.data!;
      productVariationList.value =
          response.data!.productvariations!.reversed.toList();
      allProductSizes = response.data!.sizes!;
      if (response.data!.productvariations!.isEmpty ||
          response.data!.productvariations == null ||
          response.data!.sizes!.isEmpty) {
        isFetchProductDetailsLoading.value = 3;
      } else {
        isFetchProductDetailsLoading.value = 0;
        initializeTabController();
      }
    } catch (e) {
      Log.i(e.toString());
      handleException(e);
      isFetchProductDetailsLoading.value = 2;
    }
  }

  ///  Fetch Update Product
  Future<void> fetchUpdateProduct(
      {required String status, required BuildContext context}) async {
    try {
      btnController.start();
      final response = await apiServices.updateProduct(
        productID: product.value.id!,
        productName: product.value.productName!,
        productSKU: product.value.productSku!,
        productDescription: product.value.productDescription!,
        categoryID: product.value.categoryId!,
        subCategoryID: product.value.subCategoryId!,
        status: status,
        // selectedProductStatus.value!.name,
        type: product.value.type!,
        brandId: product.value.brandId,
        // supplierID: product.value.subCategoryId,
      );
      Log.i(response.message);
      globalSnackBar(title: "Congress!", message: "${response.message}");
      btnController.stop();
      awesomeAlertDialog(
        context,
        DialogType.success,
        'Awesome! Product Added',
        'Product created successfully',
        'Go to Dashboard',
        () {
          Get.delete<AddProductController>();
          Get.delete<AddProductVariationController>();
          Get.delete<ProductAttributesController>();
          Get.toNamed(Routes.MAIN_PAGE);
        },
        'View Product',
        () {
          Get.delete<AddProductController>();
          Get.delete<AddProductVariationController>();
          Get.delete<ProductAttributesController>();
          Get.toNamed(Routes.EDIT_PRODUCT);
        },
        false,
      );
    } catch (e) {
      handleException(e);
      Log.e(e);
      btnController.stop();
    }
  }

  // /// Calculate Discount Perchantage
  // double getDiscountPerchantage(int regularPrice, int discount) {
  //   return (discount / regularPrice) * 100;
  // }
  void removeSelectedImage(int index) {
    selectedImageList.removeAt(index);
    if(selectedImageList.isEmpty){
      isImageSelect.value = false;
    }
  }

  void pickImage() {
    customBottomSheet(
        context: Get.context!,
        onTap1: () {
          getProfileImageFromFile();
          Get.back();
        },
        svgIcon1: Assets.images.file,
        text1: 'File',
        onTap2: () {
          getProfileImageFromCamera();
          Get.back();
        },
        svgIcon2: Assets.images.camera,
        text2: 'Camera',
        icon2Height: 45.h,
        icon2Width: 45.w);
  }

  ///   pick image from file
  Future<void> getProfileImageFromFile() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedPhoto.value = pickedImage;
      selectedImageList.add(selectedPhoto.value!.path);
      isImageSelect.value = true;
      // isGetImageFromFile.value = true;
    } else {
      return;
    }
  }

  ///   pick image from camera
  Future<void> getProfileImageFromCamera() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      selectedPhoto.value = pickedImage;
      selectedImageList.add(selectedPhoto.value!.path);
      isImageSelect.value = true;
      // isGetImageFromFile.value = true;
      Log.i('File Selected Image path is: ${selectedPhoto.value!.path}');
      if (kDebugMode) {
        print(selectedPhoto.value.toString());
      }
      // imagePath.value = pickedImage.path;
    } else {
      return;
    }
  }

  final isTabControllerInitialize = false.obs;
  void initializeTabController() {
    // TODO: implement onInit
    tabController = TabController(
      initialIndex: 0,
      length: productVariationList.length,
      vsync: this,
    );
    updateSelectedTab(selectedTabIndex.value);
    // isFetchProductDetailsLoading.value = 0;
  }

  @override
  void onInit() async {
    int productId = Get.arguments["id"];
    productID.value = productId;
    Log.i(productID);
    await fetchProductDetails();
    super.onInit();
  }
}

class SubVariationModel {
  SubVariationModel({
    required this.sizeID,
    required this.size,
    required this.price,
    required this.discount,
    required this.purchasePrice,
    required this.quantity,
  });
  final String sizeID;
  final String size;
  final String price;
  final String discount;
  final String purchasePrice;
  final String quantity;
}
