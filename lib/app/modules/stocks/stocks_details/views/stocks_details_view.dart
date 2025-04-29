import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa_seller/app/models/product_model/porduct_model_api.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/widgets/product_labels.dart';
import 'package:shop_villa_seller/global/methods/filter_product_quantity_color.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/app_text_style_over_flow.dart';
import '../../../../../global/methods/get_currency.dart';
import '../controllers/stocks_details_controller.dart';
import '../widgets/show_product_image.dart';

class StocksDetailsView extends GetView<StocksDetailsController> {
  const StocksDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: appbarTitle(text: 'Stocks Details'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // stocksHeaderWidget(context, products),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ShowProductImage(
              product: controller.product.value,
            ),
          ),
          15.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: AppTextStyleOverFlow(
              text: controller.product.value.productName!,
              maxLines: 1,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          // 5.height,
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w),
          //   child: AppTextStyle(
          //     text:
          //         '${GetCurrency.currencySymbol} ${controller.product.value.sizes![2].salePrice!.toString()}',
          //     fontWeight: FontWeight.w700,
          //     fontSize: 14.sp,
          //   ),
          // ),
          5.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.identifier,
                  size: 30,
                ),
                5.width,
                AppTextStyle(
                  text: controller.product.value.id.toString(),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
                const Spacer(),
                Icon(
                  MdiIcons.storePlusOutline,
                  size: 25,
                ),
                10.width,
                AppTextStyle(
                  text:
                      "${controller.product.value.totalStock.toString()} (${'Total'.tr})",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: FilterProductQuantityColor.getColor(
                      count: controller.product.value.totalStock!),
                ),
              ],
            ),
          ),
          15.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10.r),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 37.h,
                width: Get.width,
                decoration: ShapeDecoration(
                  color: ColorName.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Obx(() => TabBar(
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
                    )),
              ),
            ),
          ),
          10.height,
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: List.generate(
                controller.productVariationList.length,
                ((index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Column(
                        children: [
                          ///  Static Header Container
                          TableContainer(
                              borderSide:
                                  BorderSide(width: 1.w, color: Colors.black),
                              size: 'Size',
                              quantity: 'Quantity',
                              price: '${'Price'.tr} ( ${GetCurrency.currencySymbol} )',
                              discount: '${'Discount'.tr} ( ${GetCurrency.currencySymbol} )'
                          ),

                          ///   Dynamic Container
                          Obx(() {
                            return ListView.builder(
                                itemCount: controller.productSizeList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, item) {
                                  final SizeData productSize =
                                      controller.productSizeList[item];
                                  return TableContainer(
                                      size: productSize.size.toString(),
                                      quantity:
                                          productSize.totalStock.toString(),
                                      price: productSize.regularPrice.toString(),
                                  discount:  productSize.discount.toString(),
                                  );
                                });
                          })
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
    // return DraggableHome(
    //   title: appbarTitle(text: 'Stocks Details'),
    //   headerWidget: stocksHeaderWidget(context, products),
    //   headerExpandedHeight: 0.5,
    //   body: [stocksHomeBody()],
    // );
  }
}

class TableContainer extends StatelessWidget {
  const TableContainer(
      {super.key,
      required this.size,
      required this.quantity,
      required this.price,
         this.discount,
      this.borderSide});
  final String size;
  final String quantity;
  final String price;
  final String? discount;
  final BorderSide? borderSide;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: borderSide ?? BorderSide.none,
          bottom: BorderSide(width: 1.w, color: Colors.black),
          left: BorderSide(width: 1.w, color: Colors.black),
          right: BorderSide(width: 1.w, color: Colors.black),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: AppTextStyle(
            text: size,
          )),
          Container(
            height: Get.height,
            width: 0.5.w,
            color: Colors.black,
          ),
          Expanded(
              child: AppTextStyle(
            text: quantity,
          )),
          Container(
            height: Get.height,
            width: 0.5.w,
            color: Colors.black,
          ),
          Expanded(
              child: AppTextStyle(
            text: price,
          )),
          Container(
            height: Get.height,
            width: 0.5.w,
            color: Colors.black,
          ),
          Expanded(
              child: AppTextStyle(
                text: discount?? "0",
              )),
        ],
      ),
    );
  }
}

class SizeHelper extends StatelessWidget {
  const SizeHelper({super.key, this.size, this.quantity, this.price});
  final String? size;
  final String? quantity;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        labels(text: size, fontWeight: FontWeight.w500, fontSize: 16.sp),
        labels(text: quantity, fontWeight: FontWeight.w500, fontSize: 16.sp),
        labels(text: price, fontWeight: FontWeight.w500, fontSize: 16.sp),
      ],
    );
  }
}
