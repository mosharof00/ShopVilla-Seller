import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/methods/get_currency.dart';
import '../../../../global/methods/get_image_url.dart';
import '../../../../global/not_search_items_found_widget.dart';
import '../../../../global/server_error_widget.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../models/product_details/product_details_model.dart';
import '../../stocks/stocks_details/views/stocks_details_view.dart';
import '../controllers/add_product_variation_controller.dart';

class ViewVariations extends StatelessWidget {
  const ViewVariations(
      {super.key, required this.controller, this.editVariation});
  final AddProductVariationController controller;
  final Widget? editVariation;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: Column(
        children: [
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10.r),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: 40.h,
              width: Get.width,
              decoration: ShapeDecoration(
                color: ColorName.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Obx(() {
                if (controller.isFetchProductDetailsLoading.value == 1) {
                  return shimmerLoadingWidget(height: 200, width: Get.width);
                } else if (controller.isFetchProductDetailsLoading.value == 0) {
                  return TabBar(
                    isScrollable: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    tabAlignment: TabAlignment.start,
                    controller: controller.tabController,
                    dividerColor: Colors.transparent,
                    automaticIndicatorColorAdjustment: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
                    indicator: BoxDecoration(
                        color: ColorName.primaryColor,
                        borderRadius: BorderRadius.circular(5.r),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 3)
                        ]),
                    onTap: (index) {
                      controller.updateSelectedTab(index);
                    },
                    tabs: List.generate(
                      controller.productVariationList.length,
                      ((index) {
                        return AppTextStyle(
                          text: controller.productVariationList[index].color
                              .toString(),
                          textAlign: TextAlign.center,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                          color: controller.selectedTabIndex.value == index
                              ? Colors.white
                              : Colors.black,
                        );
                      }),
                    ),
                  );
                } else {
                  return 0.height;
                }
              }),
            ),
          ),
          Expanded(
              flex: 1,
              child: Obx(() {
                if (controller.isFetchProductDetailsLoading.value == 1) {
                  return Column(
                    children: [
                      30.height,
                      shimmerLoadingWidget(height: 10, width: 200.w),
                      10.height,
                      shimmerLoadingWidget(height: 50.h, width: Get.width),
                      45.height,
                      shimmerLoadingWidget(height: 150.h, width: Get.width)
                    ],
                  );
                } else if (controller.isFetchProductDetailsLoading.value == 0) {
                  return TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.tabController,
                      children: [
                        ...List.generate(
                          controller.productVariationList.length,
                          ((index) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    10.height,
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: Row(
                                        children: [
                                          AppTextStyle(
                                            text:
                                                'Variation: ${controller.variationColorName.value}',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          const Spacer(),
                                          editVariation ?? 0.height,
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 52.h,
                                      child: Obx(() {
                                        if (controller
                                            .isChangeTabLoading.value) {
                                          return shimmerLoadingWidget(
                                              height: 50.h, width: Get.width);
                                        } else if (controller
                                            .selectedProductVariationImageList
                                            .isEmpty) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 1),
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: GetImageUrl.url(
                                                controller
                                                    .selectedProductVariation
                                                    .value!
                                                    .image!,
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: 50.h,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: controller
                                                  .selectedProductVariationImageList
                                                  .length,
                                              itemBuilder: (context, index) {
                                                // Log.i(controller
                                                //         .selectedProductVariationImageList[
                                                //     index]);
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 1),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: GetImageUrl.url(
                                                        controller
                                                            .selectedProductVariationImageList[
                                                                index]
                                                            .imagePath!),
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: 50.h,
                                                      width: 50.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        }
                                      }),
                                    ),
                                    10.height,

                                    ///  Static Header Container
                                    TableContainer(
                                        borderSide: BorderSide(
                                            width: 1.w, color: Colors.black),
                                        size: 'Size',
                                        quantity: 'Quantity',
                                        price:
                                            '${'Price'.tr} ( ${GetCurrency.currencySymbol} )',
                                        discount:
                                            '${'Discount'.tr} ( ${GetCurrency.currencySymbol} )'),

                                    ///   Dynamic Container
                                    Obx(() {
                                      return ListView.builder(
                                          itemCount: controller
                                              .selectedSizeList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, item) {
                                            final DataSize productSize =
                                                controller
                                                    .selectedSizeList[item];
                                            return TableContainer(
                                                size:
                                                    productSize.size.toString(),
                                                quantity: productSize.totalStock
                                                    .toString(),
                                                price: productSize.regularPrice
                                                    .toString(),
                                                discount: productSize.discount
                                                    .toString());
                                          });
                                    })
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ]);
                } else if (controller.isFetchProductDetailsLoading.value == 3) {
                  return NotSearchedItemFoundWidget(
                    iconSvgPath: Assets.images.emptySearch,
                    heightLogo: 150.h,
                    widthLogo: 150.w,
                    title: 'Empty variation',
                    description:
                        "No variation have been added to this product yet. Please add new variations.",
                  );
                } else {
                  return ServerErrorWidget(
                    iconHeight: 350.h,
                  );
                }
              }))
        ],
      ),
    );
  }
}
