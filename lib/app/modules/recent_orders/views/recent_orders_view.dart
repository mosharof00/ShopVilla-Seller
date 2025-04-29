import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa_seller/app/modules/recent_orders/widget/recent_order_list.dart';
import 'package:shop_villa_seller/app/routes/app_pages.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/global/label_with_title_view_all.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/methods/get_order_status_color_method.dart';
import 'package:shop_villa_seller/global/not_search_items_found_widget.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/server_error_widget.dart';
import '../../../models/order_summary/all_order_status_model.dart';
import '../controllers/recent_orders_controller.dart';

class RecentOrdersView extends GetView<RecentOrdersController> {
  const RecentOrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Recent Orders'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: IconButton(
              onPressed: () {
                Get.toNamed(Routes.RECENT_ORDERS_LIST)?.then((_) {
                  controller.fetchData();
                });
              },
              icon: const Icon(
                Icons.search_rounded,
                size: 30,
                color: ColorName.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              SizedBox(
                height: 170.h,
                width: Get.width,

                /// TapBar GridView
                child: MasonryGridView.count(
                  scrollDirection: Axis.horizontal,
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 15.h,
                  itemCount: controller.orderStatusNameList.length,
                  itemBuilder: (context, index) {
                    // final Product product = controller.productList[index];

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: ScaleAnimation(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.r),
                          onTap: () {
                            controller.getOrders(index: index);
                            controller.labelContainer.value = 1;
                            controller.selectedTabIndex.value = index;
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(15.r),
                            elevation:
                                controller.selectedTabIndex.value == index
                                    ? 10.r
                                    : 0,
                            shadowColor:
                                controller.selectedTabIndex.value == index
                                    ? controller.orderStatusColorList[index]
                                    : Colors.transparent,
                            child: Container(
                              height: 80.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: controller.orderStatusColorList[index],
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            controller.selectedTabIndex.value ==
                                                    index
                                                ? controller
                                                    .orderStatusColorList[index]
                                                : Colors.transparent,
                                        blurRadius: 10.r,
                                        offset: Offset(1.w, 2.h))
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    controller.orderStatusIconPathList[index],
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  10.width,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(() {
                                        if (controller
                                                .adminOrderCountResponseStatus
                                                .value ==
                                            0) {
                                          return AppTextStyle(
                                            text: controller
                                                .adminOrderCountList[index]
                                                .toString(),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.sp,
                                            color: ColorName.white,
                                          );
                                        } else if (controller
                                                .adminOrderCountResponseStatus
                                                .value ==
                                            1) {
                                          return loadingAnimationWidget(
                                              color: ColorName.white, size: 25);
                                        } else {
                                          return AppTextStyle(
                                            text: 'Fail fetch',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.sp,
                                            color: ColorName.white,
                                          );
                                        }
                                      }),
                                      AppTextStyle(
                                        text: controller
                                            .orderStatusNameList[index],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                        color: ColorName.white,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              ///        ListView.builder  ///
              NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      controller.isEndPage.value == false &&
                      controller.scrollLoading.value == false &&
                      controller.isEndPage.value == false) {
                    controller.scrollLoading.value = true;
                    controller.fetchSpecificOrderStatus(
                        status: controller.selectedOrderStatus.value,
                        page: controller.currentPage.value + 1);
                  }
                  return false;
                },
                child: Expanded(
                  child: RefreshIndicator(
                    color: ColorName.primaryColor,
                    onRefresh: () async {
                      await controller.fetchData();
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
                                      child:
                                          LoadingAnimationWidget.stretchedDots(
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
                                        Get.toNamed(Routes.ORDER_INFO,
                                                arguments: order)
                                            ?.then((_) {
                                          controller.fetchData();
                                        });
                                      },
                                      color: GetOrderStatusColorMethod.getColor(
                                          order.status!),
                                    );
                                  }
                                },
                              )
                            : const NotSearchedItemFoundWidget();
                      } else if (controller.specificOrderResponseStatus.value ==
                          1) {
                        return loadingAnimationWidget();
                      } else {
                        return const Expanded(
                          child: ServerErrorWidget(
                            iconHeight: 250,
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
