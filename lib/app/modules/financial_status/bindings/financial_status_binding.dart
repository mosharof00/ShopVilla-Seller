import 'package:get/get.dart';

import '../controllers/financial_status_controller.dart';

class FinancialStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinancialStatusController>(
      () => FinancialStatusController(),
    );
  }
}
