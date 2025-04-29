import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa_seller/app/models/category/sub_category/sub_category_post_model.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import '../../../../../global/global_snackbar.dart';
import '../../../../../helper/exception_handle.dart';
import '../../../../repository/api_services.dart';
import '../../Category_Model/category_model.dart';
import '../../sub_category/sub_category_model.dart';

class AddSubCategoryController extends GetxController {
  final nameError = ''.obs;
  final categoryError = ''.obs;
  final imgError = ''.obs;
  // Loading button
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  /// Add a flag to track if we are updating or adding a new sub category
  final isUpdateMode = false.obs;
  final ApiServices apiService = ApiServices();

  /// for category
  final categoryList = <Categories>[].obs;
  var selectedCategory = Rxn<Categories>();
  int? get selectedCategoryId => selectedCategory.value?.id;

  /// for sub category
  final subCategoryID = 0.obs;
  final subCategoryList = <SubCategory>[].obs;
  var selectedSubCategory = Rxn<SubCategory>();
  final Rx<XFile?> selectedPhoto = Rx<XFile?>(null);
  final subCategoryName = TextEditingController();
  final subCategoryDescription = TextEditingController();
  final isAddNew = false.obs;

  Future<void> getProfileImageFromFile() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedPhoto.value = pickedImage;
    } else {
      return;
    }
  }

  Future<void> getProfileImageFromCamera() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      selectedPhoto.value = pickedImage;
      if (kDebugMode) {
        print(selectedPhoto.value.toString());
      }
      // imagePath.value = pickedImage.path;
    } else {
      return;
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

  void selectSubCategory(SubCategory? subCategory) {
    selectedSubCategory.value = subCategory;
  }

  void selectCategory(Categories? category) {
    subCategoryList.clear();
    selectedSubCategory.value = null;
    selectedCategory.value = category;
    fetchSubCategories(subCategoryId: selectedCategoryId!);
  }

  /// Add SubCategory
  Future<void> postSubCategory({
    required int id,
    required String name,
    required String image,
  }) async {
    try {
      final response =
          await apiService.postSubCategory(id: id, name: name, image: image);
      subCategoryList.clear();
      clear();
      fetchSubCategories(subCategoryId: selectedCategoryId!);
      btnController.stop();
      Get.snackbar('Sub Category', response.message!);
    } catch (e) {
      btnController.stop();
      Get.snackbar('Sub Category', 'Sub Category did\'t add Successfully');
      handleException(e);
    }
  }

  Future<void> updateSubCategory({
    required int categoryID,
    required int subCategoryID,
    required String name,
    String? image,
  }) async {
    try {
      final response = await apiService.updateSubCategory(
        categoryID: categoryID,
        subCategoryID: subCategoryID,
        name: name,
        image: image,
      );
      subCategoryList.clear();
      clear();
      fetchSubCategories(subCategoryId: selectedCategoryId!);
      btnController.stop();
      Get.snackbar('Sub Category', response.message!);
    } catch (e) {
      btnController.stop();
      Get.snackbar('Sub Category', 'Sub Category Update Unsuccessful');
      handleException(e);
    }
  }

  //Add Category Validation
  bool validateInputs() {
    bool isValid = true;
    if (subCategoryDescription.text.isEmpty) {
      nameError.value = '* Required';
      isValid = false;
    } else if (selectedCategoryId == null) {
      categoryError.value = 'Select Category First';
      isValid = false;
    } else if (selectedPhoto.value!.path.isEmpty) {
      imgError.value = 'Add Image';
      isValid = false;
    }
    return isValid;
  }

  /// Method to set sub category details for update
  void setSubCategoryForUpdate(SubCategory subCategory) {
    subCategoryDescription.text = subCategory.name!;
    selectedPhoto.value = XFile(subCategory.image!);
    isUpdateMode.value = true;
  }

  void clear() {
    subCategoryDescription.clear();
    selectedPhoto.value = null;
  }
}
