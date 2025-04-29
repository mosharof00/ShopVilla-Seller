import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/controllers/sales_summary_controller.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/not_search_items_found_widget.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/methods/get_order_status_color_method.dart';
import '../../../../global/server_error_widget.dart';
import '../../../models/order_summary/all_order_status_model.dart';
import '../../recent_orders/widget/recent_order_list.dart';

class AllOrderList extends StatelessWidget {
  const AllOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    SalesSummaryController controller = Get.put(SalesSummaryController());
    return Expanded(
      child: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              controller.isEndPage.value == false &&
              controller.scrollLoading.value == false &&
              controller.isEndPage.value == false) {
            controller.scrollLoading.value = true;
            controller.fetchSpecificOrderStatus(
                status: 'Delivered', page: controller.currentPage.value + 1);
          }
          return false;
        },
        child: Obx(() {
          if (controller.specificOrderResponseStatus.value == 0) {
            return controller.orderList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.orderList.length +
                        (controller.scrollLoading.value ? 1 : 0),
                    itemBuilder: (context, item) {
                      if (item == controller.orderList.length &&
                          controller.scrollLoading.value) {
                        return Center(
                          child: LoadingAnimationWidget.stretchedDots(
                            size: 40,
                            color: ColorName.primaryColor,
                          ),
                        );
                      } else {
                        final AllOrderStatusList order =
                            controller.orderList[item];
                        return RecentOrderList(
                          order: order,
                          onTap: () {
                            // Get.toNamed(Routes.ORDER_INFO,
                            //     arguments: order)
                            //     ?.then((_) {
                            //   controller.fetchData();
                            // });
                          },
                          color:
                              GetOrderStatusColorMethod.getColor(order.status!),
                        );
                      }
                    },
                  )
                : const NotSearchedItemFoundWidget();
          } else if (controller.specificOrderResponseStatus.value == 1) {
            return loadingAnimationWidget();
          } else {
            return ServerErrorWidget(
              iconHeight: 150.h,
            );
          }
        }),
      ),
    );
  }
}
