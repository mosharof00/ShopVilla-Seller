import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/widgets/product_labels.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/app_text_style_over_flow.dart';
import 'package:shop_villa_seller/global/awesome_alert_dialog.dart';
import 'package:shop_villa_seller/global/cashed_image_helper.dart';
import 'package:shop_villa_seller/global/global_button.dart';
import 'package:shop_villa_seller/global/methods/get_order_status_color_method.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import 'package:shop_villa_seller/helper/divider.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/custom_divider.dart';
import '../../../../global/methods/get_currency.dart';
import '../../../../global/parse_dateAndTime.dart';
import '../../../models/order_summary/all_order_status_model.dart';
import '../../order_details/widget/helper_container.dart';
import '../../recent_orders/widget/recent_order_list.dart';
import '../controllers/order_info_controller.dart';
import '../widget/order_products.dart';

class OrderInfoView extends GetView<OrderInfoController> {
  const OrderInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final AllOrderStatusList order = Get.arguments;
    controller.newStatus.value = order.status!;
    controller.updateActiveStep(status: controller.newStatus.value);
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Order Info'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              order.status == 'Cancelled' ||
                      order.status == 'Rejected' ||
                      order.status == 'Returned'
                  ? 0.height
                  : Obx(() => IconStepper(
                        enableStepTapping: false,
                        icons: [
                          Icon(
                            MdiIcons.archiveClockOutline,
                            color: ColorName.white,
                          ),
                          Icon(
                            MdiIcons.packageVariantClosed,
                            color: ColorName.white,
                          ),
                          Icon(
                            MdiIcons.truckOutline,
                            color: ColorName.white,
                          ),
                          Icon(
                            MdiIcons.packageVariantClosedCheck,
                            color: ColorName.white,
                          ),
                        ],
                        stepReachedAnimationEffect: Curves.bounceOut,
                        activeStep: controller.activeStep.value,
                        stepColor: ColorName.gray70,
                        activeStepColor: controller.headerColor(),
                        activeStepBorderColor: controller.headerColor(),
                        activeStepBorderWidth: 1,
                        lineColor: ColorName.green,
                        enableNextPreviousButtons: false,
                        onStepReached: (index) {
                          controller.activeStep.value = index;
                        },
                      )),
              10.height,
              Material(
                borderRadius: BorderRadius.circular(15.r),
                elevation: 2,
                child: Container(
                  height: 130.h,
                  width: Get.width,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: ColorName.white,
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Stack(
                                children: List.generate(
                                  order.orderproducts!.length,
                                  (index) {
                                    return Positioned(
                                      top: index <= 3 ? index * 2.h : 6.h,
                                      left: index <= 3 ? index * 3.w : 9.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorName.white,
                                              width: 1.5.w),
                                        ),
                                        child: cachedImageHelper(
                                          imgurl: order.orderproducts![0]
                                              .productvariation!.image!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            5.width,
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Row(children: [
                                      userInfoRecentOrders(
                                        icon: Icons.token_outlined,
                                        text: order.invoiceId!,
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          if (controller.isSelect.value) {
                                            controller.isSelect.value = false;
                                          } else {
                                            controller.isSelect.value = true;
                                            final String textToCopy =
                                                order.invoiceId.toString();
                                            if (textToCopy.isNotEmpty) {
                                              try {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                        text: textToCopy));
                                                ScaffoldMessenger.of(Get.context!)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const AppTextStyle(
                                                        text:
                                                            'Copied to Clipboard!'),
                                                    backgroundColor: ColorName
                                                        .white
                                                        .withAlpha(110),
                                                    duration: const Duration(
                                                        microseconds: 200),
                                                  ),
                                                );
                                              } catch (e) {
                                                ScaffoldMessenger.of(Get.context!)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Failed to copy to clipboard.')),
                                                );
                                              }
                                            }
                                          }
                                        },
                                        child: Icon(
                                          controller.isSelect.value
                                              ? Icons.check
                                              : Icons.copy,
                                          size: 18,
                                        ),
                                      )
                                    ]),
                                  ),
                                  5.height,
                                  userInfoRecentOrders(
                                    icon: FontAwesomeIcons.calendar,
                                    text: DateTimeUtils.parseDate(
                                      order.createdAt!.toString(),
                                    ),
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                  5.height,
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Obx(
                                      () => LabelContainer(
                                        labelTitle: controller.newStatus.value,
                                        containerColor:
                                            GetOrderStatusColorMethod.getColor(
                                                controller.newStatus.value),
                                        containerHeight: 35.h,
                                        containerWidth: 150.w,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 18.h,
                            width: 18.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Center(
                              child: AppTextStyle(
                                text: order.orderproducts!.length.toString(),
                                color: ColorName.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              15.height,
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  // height: 120.h,
                  width: Get.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: ColorName.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 0.2.sw,
                        child: circularImage(
                            imgUrl: order.user!.image!,
                            radius: 35.r,
                            imgHeight: 70.h,
                            imgWidth: 70.w,
                            imgRadius: 50.r),
                      ),
                      5.width,
                      divider(height: 90.h, width: 1.w),
                      5.width,
                      SizedBox(
                        width: 0.6.sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userInfoRecentOrders(
                                icon: FontAwesomeIcons.user,
                                text: order.name!,
                                fontSize: 12.sp),
                            3.height,
                            userInfoRecentOrders(
                              icon: Icons.phone,
                              text: order.user!.phone == null
                                  ? 'No contact number'
                                  : order.user!.phone!,
                              fontSize: 12.sp,
                            ),
                            3.height,
                            userInfoRecentOrders(
                              icon: Icons.house_outlined,
                              text: '${order.city!},${order.district}',
                              fontSize: 12.sp,
                            ),
                            3.height,
                            // userInfoRecentOrders(
                            //   icon: Icons.location_on_outlined,
                            //   text: order.address!,
                            //   fontSize: 12.sp,
                            //   maxLines: 2,
                            // ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 15,
                                ),
                                8.width,
                                SizedBox(
                                  width: 190.w,
                                  child: AppTextStyleOverFlow(
                                    text: order.address!,
                                    fontSize: 12.sp,
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.height,
              OrderProducts(order: order),
              10.height,
              Obx(() {
                controller.getPaymentMethod(order.paymentMethod.toString());
                return helperContainer(
                  showIcon: false,
                  onPressed: () {},
                  icon: Icon(
                    MdiIcons.creditCardOutline,
                    color: Colors.green,
                  ),
                  text: 'Payment Methods',
                  leading: circularImage(
                      imgUrl: controller.image.value,
                      radius: 22.r,
                      imgRadius: 50.r),
                  titleText: controller.gateway.value,
                  subtitleText: '',
                  isTrailing: true,
                  trailWidget: Container(
                    decoration: BoxDecoration(
                        color: order.paymentStatus!.toString() == "due"
                            ? ColorName.crimsonRed
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      child: AppTextStyle(
                        text: order.paymentStatus!.capitalize.toString(),
                        color: ColorName.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
              order.couriers == null
                  ? 0.height
                  : Column(
                      children: [
                        15.height,
                        helperContainer(
                          icon: Icon(
                            MdiIcons.truckDelivery,
                            color: Colors.green,
                          ),
                          text: 'Courier',
                          leading: circularImage(
                              imgUrl: order.couriers!.image!,
                              radius: 22.r,
                              imgRadius: 50.r),
                          titleText: order.couriers!.courierName!,
                          subtitleText: order.hubName!,
                          isTrailing: false,
                        ),
                      ],
                    ),
              10.height,
              helperContainer(
                icon: Icon(
                  MdiIcons.brightnessPercent,
                  color: Colors.green,
                ),
                text: 'Discount',
                leading: Icon(
                  MdiIcons.brightnessPercent,
                  color: Colors.white,
                ),
                titleText: order.coupon == null
                    ? 'No Promos Selected'
                    : order.coupon.toString(),
                subtitleText:
                    order.coupon == null ? '' : order.coupon.toString(),
                isTrailing: false,
              ),
              10.height,
              Container(
                width: Get.width,
                padding: EdgeInsets.all(15.r),
                // height:
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.fileDocumentOutline,
                          color: Colors.green,
                        ),
                        10.width,
                        AppTextStyle(
                          text: 'Review Summary',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                    customDivider(),
                    10.height,
                    summaryOptionsRow(
                        leadingText:
                            '${'Subtotal'.tr} (${order.orderproducts!.length} ${'Item'.tr})',
                        thrillingText:
                            '+ ${GetCurrency.currencySymbol} ${order.subTotal}'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Shipping Charge',
                        thrillingText:
                            '+ ${GetCurrency.currencySymbol} ${order.shippingCharge}'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Discount',
                        thrillingText:
                            '- ${GetCurrency.currencySymbol} ${order.discount}'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Tax',
                        thrillingText:
                            '+ ${GetCurrency.currencySymbol} ${order.tax}'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Vat',
                        thrillingText:
                            '+ ${GetCurrency.currencySymbol} ${order.vat}'),
                    5.height,
                    customDivider(paddingHorizontal: 0),
                    5.height,
                    Obx(() {
                      return summaryOptionsRow(
                        leadingText: 'Total',
                        fontSizeLeadingText: 15.sp,
                        fontWeightLeadingText: FontWeight.w500,
                        thrillingText:
                            '${GetCurrency.currencySymbol} ${controller.totalSum(
                          order.subTotal.toString(),
                          order.shippingCharge.toString(),
                          order.discount.toString(),
                        )}',
                        fontSizeThrillingText: 18.sp,
                        fontWeightThrillingText: FontWeight.w600,
                      );
                    }),
                    80.height,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      ///    for  Cancel  Or  Accept  bottomNavigationBar
      bottomNavigationBar: order.status == 'Cancelled' ||
              order.status == 'Rejected' ||
              order.status == 'Returned'
          ? 0.height
          : Obx(() => Visibility(
                visible: controller.activeStep.value == 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          awesomeAlertDialog(
                              context,
                              DialogType.question,
                              'Want to Reject the Order?',
                              'Are you Sure?',
                              'No',
                              () {},
                              'Yes', () {
                            controller.fetchChangeAdminOrderStatus(
                                invoiceId: order.invoiceId!,
                                status: 'Rejected');
                          }, true);
                        },
                        child: Container(
                          height: 45.h,
                          width: Get.width / 2.2,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50.r)),
                          child: Center(
                            child: AppTextStyle(
                              text: 'Reject',
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      globalButton(
                          onTap: () {
                            awesomeAlertDialog(
                                context,
                                DialogType.question,
                                'Want to Accept the Order?',
                                'Are you Sure?',
                                'No',
                                () {},
                                'Yes', () {
                              controller.fetchChangeAdminOrderStatus(
                                  invoiceId: order.invoiceId!,
                                  status: 'Confirmed');
                            }, true);
                          },
                          text: 'Accept',
                          width: Get.width / 2.2),
                    ],
                  ),
                ),
              )),

      ///   for Change Status
      floatingActionButton: order.status == 'Cancelled' ||
              order.status == 'Rejected'
          ? 0.height
          : Obx(
              () => Visibility(
                visible: controller.activeStep.value == 1 ||
                    controller.activeStep.value == 2 ||
                    controller.activeStep.value == 3,
                child: Container(
                  height: 40.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: controller.buttonColor(),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (controller.activeStep.value == 3) {
                        Get.back();
                      } else {
                        awesomeAlertDialog(
                            context,
                            DialogType.question,
                            'Want to Change the Status?',
                            'Are you Sure?',
                            'No',
                            () {},
                            'Yes', () {
                          controller.fetchChangeAdminOrderStatus(
                              invoiceId: order.invoiceId!,
                              status: controller.newStatus.value == 'Confirmed'
                                  ? 'Ongoing'
                                  : controller.newStatus.value == 'Ongoing'
                                      ? 'Delivered'
                                      : 'Pending');
                        }, true);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          labels(
                              text: controller.buttonText(),
                              fontSize: 14.sp,
                              color: ColorName.white),
                          const Icon(
                            Icons.arrow_forward,
                            color: ColorName.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
