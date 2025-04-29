import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa_seller/app/modules/dashboard/widget/summary.dart';
import 'package:shop_villa_seller/app/routes/app_pages.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/methods/filter_product_quantity_color.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import 'package:shop_villa_seller/helper/divider.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/cashed_image_helper.dart';
import '../../../../global/server_error_widget.dart';
import '../../../models/product_model/porduct_model_api.dart';
import '../controllers/stocks_controller.dart';

class StocksView extends GetView<StocksController> {
  const StocksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Stocks'),
        centerTitle: true,
      ),
      body: Obx(() {
        final stock = controller.adminStock.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.isLoadingStock.value
                  ? loadingAnimationWidget(size: 40)
                  : Summary(
                      firstContainerNumber: stock.totalProductStock.toString(),
                      firstContainerText: 'Total Stock',
                      secondContainerNumber:
                          stock.recentlyAddedProduct.toString(),
                      secondContainerText: 'Recently Added',
                      thirdContainerNumber: stock.sold.toString(),
                      thirdContainerText: 'Sold'),
              10.height,
              divider(height: 1.5.h, width: Get.width),
              10.height,
              Obx(() {
                if (controller.isLoading.value == 0) {
                  return NotificationListener(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          controller.isEndPage.value == false &&
                          controller.scrollLoading.value == false &&
                          controller.isEndPage.value == false) {
                        controller.scrollLoading.value = true;
                        controller.fetchProducts(
                            page: controller.currentPage.value + 1);
                      }
                      return false;
                    },
                    child: Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.productList.length +
                            (controller.scrollLoading.value ? 1 : 0),
                        itemBuilder: (context, item) {
                          if (item == controller.productList.length &&
                              controller.scrollLoading.value) {
                            return Center(
                              child: LoadingAnimationWidget.stretchedDots(
                                size: 40,
                                color: ColorName.primaryColor,
                              ),
                            );
                          } else {
                            final ProductData product =
                                controller.productList[item];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.STOCKS_DETAILS,
                                      arguments: product);
                                },
                                borderRadius: BorderRadius.circular(15.r),
                                child: Material(
                                  borderRadius: BorderRadius.circular(15.r),
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      color: ColorName.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        cachedImageHelper(
                                          radius: 15.r,
                                          imgurl: product
                                              .productvariations![0].image!,
                                          imgHeight: 80.h,
                                          imgWidth: 80.w,
                                        ),
                                        5.width,
                                        divider(height: 80.h, width: 1.w),
                                        5.width,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppTextStyleOverFlow(
                                                text: product.productName!,
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                              ),
                                              10.height,
                                              StocksProductId(
                                                id: product.id!,
                                              ),
                                              5.height,
                                              StocksProductText(
                                                  totalStock:
                                                  product.totalStock!,
                                                  color:
                                                  FilterProductQuantityColor
                                                      .getColor(
                                                      count: product
                                                          .totalStock!)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                } else if (controller.isLoading.value == 1) {
                  return Center(child: loadingAnimationWidget());
                } else {
                  return Expanded(
                    child: ServerErrorWidget(
                      iconHeight: 300.h,
                    ),
                  );
                }
              })
            ],
          ),
        );
      }),
    );
  }
}

class StocksProductText extends StatelessWidget {
  const StocksProductText({
    super.key,
    required this.totalStock,
    required this.color,
  });

  final int totalStock;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          MdiIcons.storePlusOutline,
          size: 20,
        ),
        10.width,
        AppTextStyle(
          text: "${totalStock.toString()} (${'Total'.tr})",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ],
    );
  }
}

class StocksProductId extends StatelessWidget {
  const StocksProductId({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          MdiIcons.identifier,
          size: 25,
        ),
        5.width,
        AppTextStyle(
            text: id.toString(),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey),
      ],
    );
  }
}
