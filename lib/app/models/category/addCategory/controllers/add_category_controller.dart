import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa_seller/app/repository/api_endpoint.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import '../../../../../helper/exception_handle.dart';
import '../../../../repository/api_services.dart';
import '../../Category_Model/category_model.dart';

class AddCategoryController extends GetxController {
  final nameError = ''.obs;
  final descError = ''.obs;
  final imgError = ''.obs;
  // Loading button
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final Rx<XFile?> selectedPhoto = Rx<XFile?>(null);
  final categoryName = TextEditingController();
  final categoryDescription = TextEditingController();
  final ApiServices apiService = ApiServices();
  final subCategoryList = [].obs;
  final selectedCategoryId = 0.obs;
  final isSubCategoryLoading = 100.obs;
  final index = 0.obs;
  RxInt selectedIndex = 0.obs;
  final isGetImageFromFile = false.obs;
  final errorColor = ColorName.crimsonRed.shade300;

  ///   Category
  final categoryList = <Categories>[].obs;
  final isCategoryLoading = 100.obs;

  /// Add a flag to track if we are updating or adding a new category
  final isUpdateMode = false.obs;

  /// Fetch Category
  void fetchCategory() async {
    try {
      isCategoryLoading.value = 1;
      final categories = await apiService.getCategory();
      categoryList.value = categories.data!;
      isCategoryLoading.value = 0;
    } catch (e) {
      handleException(e);
      isCategoryLoading.value = 2;
    }
  }

  /// Add Category
  Future<void> addCategory(
      {required String name, required String desc, required String img}) async {
    try {
      final response =
          await apiService.addCategory(name: name, desc: desc, image: img);
      categoryList.clear();
      fetchCategory();
      clear();
      btnController.stop();
      Get.snackbar('Category', response.title!);
    } catch (e) {
      btnController.stop();
      Get.snackbar('Category', 'Category did\'t Add Successfully');
      handleException(e);
    }
  }

  /// Update an existing category
  Future<void> updateCategory({
    required int id,
    required String name,
    required String desc,
  }) async {
    try {
      final response = await apiService.categoryUpdate(
        id: id,
        name: name,
        desc: desc,
        img: isGetImageFromFile.value ? selectedPhoto.value!.path : null,
      );
      categoryList.clear();
      fetchCategory(); // Refresh the list
      clear();
      isUpdateMode.value = false; // Set back to add mode
      btnController.stop();
      globalSnackBar(
          title: 'Success!', message: response.message!);
    } catch (e) {
      btnController.stop();
      if (e is ApiException) {
        Log.e('Error: ${e.message}');  // Assuming `message` is a property of `ApiException`
        print('Status code: ${e.statusCode}');  // If there's a status code
      } else {
        print('An unexpected error occurred: $e');
      }
      Get.snackbar('Category', 'Category didn\'t Update Successfully');
      handleException(e);
    }
  }

  /// Method to set category details for update
  void setCategoryForUpdate(Categories category) {
    selectedCategoryId.value = category.id!;
    categoryName.text = category.categoryName!;
    categoryDescription.text = category.categoryDesc!;
    selectedPhoto.value = XFile(category.image!);
    isUpdateMode.value = true;
    isGetImageFromFile.value = false;
  }

  ///   pick image from file
  Future<void> getProfileImageFromFile() async {
    final XFile? pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedPhoto.value = pickedImage;
      isGetImageFromFile.value = true;
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
      isGetImageFromFile.value = true;
      Log.i('File Selected Image path is: ${selectedPhoto.value!.path}');
      if (kDebugMode) {
        print(selectedPhoto.value.toString());
      }
      // imagePath.value = pickedImage.path;
    } else {
      return;
    }
  }

  //Add Category Validation
  bool validateInputs() {
    bool isValid = true;
    if (categoryName.text.isEmpty) {
      nameError.value = '* Required';
      isValid = false;
    } else if (categoryDescription.text.isEmpty) {
      descError.value = 'Enter a Description';
      isValid = false;
    } else if (selectedPhoto.value!.path.isEmpty) {
      imgError.value = 'Add Image';
      isValid = false;
    }
    return isValid;
  }

  void clear() {
    categoryName.clear();
    categoryDescription.clear();
    selectedPhoto.value = null;
    isGetImageFromFile.value = false;
  }

  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
