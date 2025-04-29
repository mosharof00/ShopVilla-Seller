import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/products/productDetails/widget/awesome_dialog_login.dart';
import 'package:shop_villa_seller/app/routes/app_pages.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';

import '../../../../global/app_text_style.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/profile_model/profile_get_model.dart';
import '../../../repository/api_services.dart';

class ProfileController extends GetxController {
  // API Service instance
  final apiService = Get.put(ApiServices());

  /// Profile Details
  // Observable to store profile details
  final profileDetails = ProfileGetModel().obs;

  // Fetch profile details from the API
  Future<void> getProfileDetails() async {
    try {
      final profile = await apiService.profileDetails();
      profileDetails.value = profile; // Update the observable with fetched data
    } catch (e) {
      handleException(e); // Handle any exceptions that occur
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Check if the user is logged in
    if (HelperUtils.isLogin) {
      getProfileDetails(); // Fetch profile details if logged in
    } else {
      // Show warning dialog if not logged in
      DialogUtils.showWarningDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        title: "You are not Authorized Admin",
        description: "Please Log In",
        onOkPressed: () {
          Get.toNamed(Routes.LOGIN); // Navigate to login page
        },
      );
    }
  }
}
