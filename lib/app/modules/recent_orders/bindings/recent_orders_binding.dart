import 'package:get/get.dart';

import '../controllers/recent_orders_controller.dart';

class RecentOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentOrdersController>(
      () => RecentOrdersController(),
    );
  }
}
