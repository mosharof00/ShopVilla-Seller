import 'package:get/get.dart';

import '../controllers/sales_summary_controller.dart';

class SalesSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesSummaryController>(
      () => SalesSummaryController(),
    );
  }
}
