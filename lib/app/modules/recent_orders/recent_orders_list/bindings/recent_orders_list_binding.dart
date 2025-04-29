import 'package:get/get.dart';

import '../controllers/recent_orders_list_controller.dart';

class RecentOrdersListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentOrdersListController>(
      () => RecentOrdersListController(),
    );
  }
}
