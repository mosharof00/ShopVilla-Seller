import 'package:get/get.dart';

import '../controllers/stocks_details_controller.dart';

class StocksDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StocksDetailsController>(
      () => StocksDetailsController(),
    );
  }
}
