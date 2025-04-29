import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/global/app_text_style_over_flow.dart';
import 'package:shop_villa_seller/global/methods/get_image_url.dart';
import 'package:shop_villa_seller/global/parse_dateAndTime.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/methods/get_currency.dart';
import '../../../../global/methods/get_order_status_color_method.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../models/order_summary/all_order_status_model.dart';
import '../../sales_summary/widgets/product_labels.dart';

class RecentOrderList extends StatelessWidget {
  const RecentOrderList({
    super.key,
    required this.order,
    required this.onTap,
    required this.color,
  });
  final AllOrderStatusList order;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Material(
          borderRadius: BorderRadius.circular(15.r),
          elevation: 2,
          child: Container(
            constraints: BoxConstraints(
              minHeight: 120.h,
              maxHeight: 150.h,
              minWidth: Get.width,
              maxWidth: Get.width,
            ),
            width: Get.width,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: ColorName.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///   for image section
                Expanded(
                  flex: 1,
                  child: Stack(children: [
                    ...List.generate(
                        order.orderproducts!.length > 3
                            ? 3
                            : order.orderproducts!.length, (index) {
                      return Positioned(
                        top: index <= 3 ? index * 3.h : 9.h,
                        left: index <= 3 ? index * 5.h : 15.w,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorName.white, width: 1.5.w),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CachedNetworkImage(
                              imageUrl: GetImageUrl.url(order
                                  .orderproducts![0]
                                  .productvariation!
                                  .image!),
                              fit: BoxFit.cover,
                              height: 120.h,
                              width: 100.w,
                              placeholder: (context, url) =>
                                  shimmerLoadingWidget(
                                      height: Get.height, width: Get.width),
                              errorWidget: (context, url, error) =>
                                  Image.asset(
                                    Assets.images.phoneimage.path,
                                    height: Get.height,
                                    width: Get.width,
                                  ),
                            ),
                          ),
                        ),
                      );
                    }),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorName.primaryColor,
                        ),
                        child: Center(
                          child: AppTextStyle(
                            text: order.orderproducts!.length.toString(),
                            color: ColorName.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top:10.h,
                      right: 10.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: order.paymentStatus!.toString() == "paid"
                              ? Colors.green
                              : ColorName.crimsonRed,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 1.h),
                          child: AppTextStyle(
                            text: order.paymentStatus!.capitalize.toString(),
                            color: ColorName.white,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                5.width,
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.height,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextStyle(text: "#${order.invoiceId!}"
                              , fontSize: 12.sp,fontWeight: FontWeight.w600),

                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 1.h),
                            decoration: BoxDecoration(

                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.1),
                                    width: 1.5.w),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: AppTextStyleOverFlow(
                              text: GetCurrency.concatWithCurrency(
                                order.total.toString(),
                                GetCurrency.currencySymbol,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      5.height,
                      userInfoRecentOrders(
                        icon: FontAwesomeIcons.clock,
                        text: DateTimeUtils.formatTimeAgo(
                            order.createdAt!.toString()),
                        fontSize: 12.sp,
                      ),
                      5.height,
                      userInfoRecentOrders(
                          icon: FontAwesomeIcons.user,
                          text: order.name!,
                          fontSize: 12.sp),
                      5.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.black87,
                            size: 18,
                          ),
                          // SvgPicture.asset(svg, height: 10.h, width:10.w),
                          8.width,
                          Expanded(
                            child: AppTextStyleOverFlow(
                              text: order.address!,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              fontSize: 12.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      5.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userInfoRecentOrders(
                              icon: Icons.add_shopping_cart_outlined,
                              text: '${order.orderproducts!.length} items',
                              fontSize: 12.sp),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  color: GetOrderStatusColorMethod.getColor(
                                      order.status!),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: AppTextStyle(
                                text: order.status!.capitalize.toString(),
                                color: ColorName.white,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ],
                      ),

                      // LabelContainer(
                      //   labelTitle: order.status.toString(),
                      //   containerColor:
                      //   GetOrderStatusColorMethod.getColor(order.status!),
                      //   containerHeight: 22.h,
                      //   containerWidth: 20.w,
                      //   fontSize: 12.sp,
                      // ),

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
}

Widget userInfoRecentOrders(
    {IconData? icon,
      required String text,
      double? fontSize,
      String? svg,
      double? iconSize,
      Color? color,
      int? maxLines}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(
        icon,
        color: Colors.black87,
        size: iconSize ?? 15,
      ),
      // SvgPicture.asset(svg, height: 10.h, width:10.w),
      8.width,
      labels(
          text: text,
          maxLines: maxLines,
          textAlign: TextAlign.start,
          fontSize: fontSize ?? 13.sp,
          color: color ?? Colors.black54),
    ],
  );
}
