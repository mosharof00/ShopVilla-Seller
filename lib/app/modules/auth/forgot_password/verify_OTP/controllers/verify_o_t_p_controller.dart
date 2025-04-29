import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../global/global_snackbar.dart';
import '../../../../../../global/log_printer.dart';
import '../../../../../../helper/exception_handle.dart';
import '../../../../../repository/api_services.dart';
import '../../../../../routes/app_pages.dart';
import '../../change_password/controllers/change_password_controller.dart';

class VerifyOTPController extends GetxController {
  //TODO: Implement VerifyOTPController
  TextEditingController otpController = TextEditingController();
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
  ApiServices apiServices = ApiServices();
  final token = " ".obs;
  final code = 0.obs;
  final email = " ".obs;
  RxBool isResendCode = false.obs;
  var isRefreshed = true.obs;
  final errorMessage = " ".obs;

  ///  Resend OTP
  void resendOTP() async {
    isRefreshed.value = true;
    try {
      final response = await apiServices.sendOTP(email: email.toString());
      if (response.status == true) {
        token.value = " ";
        code.value = 0;
        errorMessage.value = " ";
        Log.i(" Now code is -- ${response.data!.code!}");
        token.value = response.data!.token!;
        code.value = response.data!.code!;
      }
      globalSnackBar(title: 'Warning!', message: response.message.toString());
    } catch (e) {
      handleException(e);
      globalSnackBar(title: 'Error!', message: e.toString());
    }
  }

  ///  Checking all conditions
  void onComplete(String pin) {
    if (pin == code.value.toString()) {
      errorMessage.value = "";
      globalSnackBar(
          durationInSeconds: 3, title: 'Success!', message: " Code is matched");
      changePasswordController.token.value = token.toString();
      Get.toNamed(Routes.CHANGE_PASSWORD);
    } else {
      errorMessage.value = "Pin is incorrect";
      globalSnackBar(
          durationInSeconds: 3,
          title: 'Sorry!',
          message: " Code is not  matched");
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}
