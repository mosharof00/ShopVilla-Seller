import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa_seller/app/modules/recent_orders/widget/recent_order_list.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/not_search_items_found_widget.dart';
import '../../../../../global/server_error_widget.dart';
import '../../../../models/order_summary/all_order_status_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/recent_orders_list_controller.dart';

class RecentOrdersListView extends GetView<RecentOrdersListController> {
  const RecentOrdersListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Recent Orders'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(
                        () => Container(
                      height: 45.h,
                      margin: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 9,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: controller.searchTextController.value,

                          readOnly: false,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              size: 22,
                              color: Colors.grey,
                            ),

                            ///   suffixIcon OnTap     ///
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.searchTextController.value.clear();
                                controller.isEndPage.value = false;
                                controller.currentPage.value = 0;
                                controller.fetchAllOrderStatus(
                                  status: 'All',
                                );
                              },
                              child: const Icon(
                                Icons.cancel_rounded,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: 'InvoiceID'.tr,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: controller.searchOnTap,
                  child: AppTextStyle(
                    text: 'Search',
                    color: ColorName.primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.allOrderResponseStatus.value == 0) {
                  if (controller.isSearchTapped.value == false &&
                      controller.allOrderList.isEmpty) {
                    ///   For Search result not found    ///
                    return Expanded(
                      child: NotSearchedItemFoundWidget(
                        widgetHeight: 20.height,
                      ),
                    );
                  } else {
                    ///   Order found
                    return NotificationListener(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                            controller.isEndPage.value == false &&
                            controller.scrollLoading.value == false &&
                            controller.isEndPage.value == false) {
                          controller.scrollLoading.value = true;
                          controller.fetchAllOrderStatus(
                              status: 'All',
                              page: controller.currentPage.value + 1);
                        }
                        return false;
                      },
                      child: RefreshIndicator(
                        color: ColorName.primaryColor,
                        onRefresh: ()async{
                          if (controller.searchTextController.value.text
                              .isNotEmpty) {
                            await  controller.fetchAdminOrderSearch(
                                invoiceID: controller
                                    .searchTextController.value.text);
                            return;
                          } else {
                            controller.searchTextController.value.clear();
                            controller.isEndPage.value = false;
                            controller.currentPage.value = 0;
                            controller.allOrderList.clear();
                            await   controller.fetchAllOrderStatus(
                              status: 'All',
                            );
                          }
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.allOrderList.length +
                              (controller.scrollLoading.value ? 1 : 0),
                          itemBuilder: (context, item) {
                            if (item == controller.allOrderList.length &&
                                controller.scrollLoading.value) {
                              return Center(
                                child: LoadingAnimationWidget.stretchedDots(
                                  size: 40,
                                  color: ColorName.primaryColor,
                                ),
                              );
                            } else {
                              final AllOrderStatusList order =
                              controller.allOrderList[item];
                              return RecentOrderList(
                                onTap: () {
                                  Get.toNamed(Routes.ORDER_INFO, arguments: order)
                                      ?.then((_) {
                                    if (controller.searchTextController.value.text
                                        .isNotEmpty) {
                                      controller.fetchAdminOrderSearch(
                                          invoiceID: controller
                                              .searchTextController.value.text);
                                      return;
                                    } else {
                                      controller.searchTextController.value.clear();
                                      controller.isEndPage.value = false;
                                      controller.currentPage.value = 0;
                                      controller.allOrderList.clear();
                                      controller.fetchAllOrderStatus(
                                        status: 'All',
                                      );
                                    }
                                  });
                                },
                                order: order,
                                color: order.status! == 'Pending'
                                    ? Colors.yellow
                                    : order.status! == 'Confirmed'
                                    ? Colors.blue
                                    : order.status! == 'Cancelled'
                                    ? Colors.red
                                    : order.status! == 'Ongoing'
                                    ? Colors.orange
                                    : order.status! == 'Delivered'
                                    ? Colors.green
                                    : Colors.grey,
                              );
                            }
                          },
                        ),
                      ),
                    );
                  }
                } else if (controller.allOrderResponseStatus.value == 1) {
                  return loadingAnimationWidget();
                } else {
                  return const Expanded(
                    child:  ServerErrorWidget(
                      iconHeight: 250,
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}