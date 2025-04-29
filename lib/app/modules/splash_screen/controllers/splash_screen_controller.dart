import 'package:get/get.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';
import '../../../../global/log_printer.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_store_config.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  // navigateToMainPage() async {
  //   if (HelperUtils.isLogin) {
  //     await HelperUtils.initializeMainControllers();
  //     await Future.delayed(const Duration(seconds: 3));
  //     Log.w(HelperUtils.adminID);
  //     Log.w( HelperUtils.token);
  //     Get.offNamed(Routes.MAIN_PAGE);
  //   } else {
  //     Future.delayed(Duration.zero, () {
  //       Get.offNamed(Routes.LOGIN);
  //     });
  //   }
  // }

  navigateToMainPage() async {
    ///  get Important token & user ID
    HelperUtils.token = await HiveService.getToken() ?? "";
    HelperUtils.adminID = (await HiveService.getAdminID())!;
    if (HelperUtils.isLogin) {
      ///  initialize Main Controllers
      await HelperUtils.initializeMainControllers();
      await Future.delayed(const Duration(seconds: 3));
      Get.offNamed(Routes.MAIN_PAGE);
    } else {
      Future.delayed(Duration.zero, () {
        Get.offNamed(Routes.LOGIN);
      });
    }
  }

  @override
  void onInit() async {
    navigateToMainPage();
    super.onInit();
  }
}
