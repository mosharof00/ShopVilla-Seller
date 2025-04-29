
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/global/methods/get_currency.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/cashed_image_helper.dart';
import '../../../../global/custom_divider.dart';
import '../../../models/order_summary/all_order_status_model.dart';

class OrderProducts extends StatelessWidget {
  const OrderProducts({super.key, required this.order});
 final AllOrderStatusList order;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      // height: 400.h,
      decoration: BoxDecoration(
          color: ColorName.white, borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            10.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                5.width,
                const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.green,
                ),
                10.width,
                AppTextStyle(
                  text: '${'Your Order'.tr} (${order.orderproducts!.length})',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ],
            ),
            10.height,
            customDivider(),
            5.height,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.orderproducts!.length,
              itemBuilder: (context, index) {
                final product = order.orderproducts![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        cachedImageHelper(
                          radius: 15.r,
                            imgHeight: 100.h,
                            imgWidth: 90.w,
                            imgurl: product.productvariation!.image!,),
                        15.width,
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextStyleOverFlow(
                                text: product.productName!,
                                maxLines: 3,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                              5.height,
                              Row(
                                children: [
                                  AppTextStyle(
                                    text: '${'Size'.tr} : ${product.size}',
                                    fontSize: 12.sp,
                                  ),
                                  5.width,
                                  AppTextStyle(
                                    text: '${'Color'.tr} : ${product.color}',
                                    fontSize: 12.sp,
                                  ),
                                ],
                              ),
                              5.height,
                              Row(
                                children: [
                                  AppTextStyle(
                                    text: '${'Quantity'.tr} : ',
                                    fontSize: 12.sp,
                                  ),
                                  AppTextStyle(
                                    text: product.qty!.toString(),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              5.height,
                              AppTextStyle(
                                text: '${'Total'.tr} : ${product.price} ${GetCurrency.currencySymbol}',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
