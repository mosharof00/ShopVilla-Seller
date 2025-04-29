import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_villa_seller/app/modules/products/productDetails/controllers/product_details_controller.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/q&a/q&aGetModel.dart';
import '../../../models/q&a/q&aPostModel.dart';
import '../../../repository/api_services.dart';

class QusAndAnsController extends GetxController {
  /// Api Service
  final apiService = Get.put(ApiServices());

  /// Q & A Post Answer Admin
  final adminAns = AdminAns().obs; // Creating instance of AdminAns
  Future<void> qaAdminAns({
    required String qusID,
    required String productID,
    required String answer,
  }) async {
    try {
      final postAns =
          await apiService.qaAnswer(qusID, productID, answer); // Post Answer
      if (postAns.status!) {
        adminAns.value = postAns.data!;
        Get.find<ProductDetailsController>().qaList(int.parse(productID));
      } else {
        debugPrint(postAns.status!.toString());
      }
    } catch (e) {
      handleException(e);
    }
  }
}
