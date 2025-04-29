import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../../../../global/app_text_style.dart';
import '../../../models/order place/user_orderlist_post_model.dart';
import '../../order_details/controllers/order_details_controller.dart';
import '../controllers/my_order_controller.dart';

class DeliveryStatus extends GetView<MyOrderController> {
  const DeliveryStatus({super.key,});
  @override
  Widget build(BuildContext context) {
    final MyOrder myOrder = Get.find<OrderDetailsController>().myOrder;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            18.height,
            AppTextStyle(
              text: 'Order ID: ${myOrder.invoiceId}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            AppTextStyle(
              text: 'Status: ${controller.statusDesc(1)}',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            48.height,
          ],
        ),
        Column(
          children: [
            22.height,
            AppTextStyle(
              text: 'Order ID: ${myOrder.invoiceId}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppTextStyle(
              text: 'Status: ${controller.statusDesc(2)}',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            50.height,
          ],
        ),
        Column(
          children: [
            22.height,
            AppTextStyle(
              text: 'Order ID: ${myOrder.invoiceId}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppTextStyle(
              text: 'Status: ${controller.statusDesc(3)}',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            50.height,
          ],
        ),
        Column(
          children: [
            22.height,
            AppTextStyle(
              text: 'Order ID: ${myOrder.invoiceId}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppTextStyle(
              text: 'Status: ${controller.statusDesc(4)}',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            50.height,
          ],
        ),
      ],
    );
  }
}
