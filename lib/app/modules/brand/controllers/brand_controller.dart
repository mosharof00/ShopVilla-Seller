import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/brand/brand_model.dart';
import '../../../repository/api_services.dart';

class BrandController extends GetxController {
  //TODO: Implement BrandController
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final ApiServices apiServices = ApiServices();
  final errorColor = Colors.red.shade300;
  final brandList = <BrandData>[].obs;
  final Rx<XFile?> selectedPhoto = Rx<XFile?>(null);
  final selectedBrandID = 0.obs;
  final brandName = TextEditingController();
  final brandDescription = TextEditingController();

  final index = 0.obs;
  RxInt selectedIndex = 0.obs;
  final isUpdateMode = false.obs;
  final isGetImageFromFile = false.obs;

  ///   Update brand setup
  void setBrandForUpdate(BrandData brand) {
    selectedBrandID.value = brand.id!;
    brandName.text = brand.name!;
    brandDescription.text = brand.desc!;
    selectedPhoto.value = XFile(brand.image!);
    isUpdateMode.value = true;
    isGetImageFromFile.value = false;
  }

  ///   Fetch Brands
  Future fetchBrands() async {
    try {
      final response = await apiServices.getBrands();
      brandList.value = response.data!.data!;
    } catch (e) {
      handleException(e);
    }
  }

  ///  Add Brand

  Future<void> addBrand() async {
    Log.i("add Brand called");
    try {
      btnController.start();
      final response = await apiServices.addBrand(
          name: brandName.text,
          description: brandDescription.text,
          imagePath: selectedPhoto.value!.path);
      brandList.clear();
      fetchBrands();
      clear();
      btnController.stop();
      globalSnackBar(title: "Success!", message: response.message.toString());
    } catch (e) {
      handleException(e);
      btnController.stop();
    }
  }

  ///   Update Brand
  Future<void> updateBrand() async {
    try {
      btnController.start();
      final response = await apiServices.updateBrand(
          id: selectedBrandID.value,
          name: brandName.text,
          description: brandDescription.text,
          imagePath:
              isGetImageFromFile.value ? selectedPhoto.value!.path : null);
      brandList.clear();
      fetchBrands();
      clear();
      btnController.stop();
      globalSnackBar(title: "Success!", message: response.message.toString());
    } catch (e) {
      handleException(e);
      btnController.stop();
    }
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

  void clear() {
    isUpdateMode.value = false;
    isGetImageFromFile.value = false;
    brandName.clear();
    brandDescription.clear();
    selectedPhoto.value = null;
  }

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }
}
