import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shop_villa_seller/global/cashed_image_helper.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../../../../appConfig.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/parse_dateAndTime.dart';
import '../../../../global/server_error_widget.dart';
import '../../../models/notification_model/notification_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Notifications'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value == 0) {
          if (controller.notificationList.isNotEmpty) {
            return GroupedListView<NotificationData, String>(
              elements: controller.notificationModel.value.data ?? [],
              groupBy: (element) => _groupByDate(element.createdAt),
              groupComparator: (value1, value2) =>
                  groupComparator(value1, value2),
              itemComparator: (item1, item2) =>
                  item1.title!.compareTo(item2.title!),
              order: GroupedListOrder.ASC,
              useStickyGroupSeparators: true,
              groupSeparatorBuilder: (String value) => Padding(
                padding: EdgeInsets.all(5.0.r),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextStyle(
                    text: value,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorName.primaryColor,
                  ),
                ),
              ),
              itemBuilder: (c, element) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1.w, color: Colors.grey.shade300),
                    ),
                  ),
                  child: ListTile(
                    title: AppTextStyle(
                      text: element.title!,
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        element.description == null
                            ? const SizedBox.shrink()
                            : AppTextStyle(
                                text: element.description!,
                                fontSize: 12.sp,
                                textAlign: TextAlign.start,
                                color: ColorName.primaryColor,
                              ),
                        3.height,
                        AppTextStyle(
                          text: DateTimeUtils.formatTimeAgo(
                              element.createdAt!.toString()),
                          fontSize: 12.sp,
                          textAlign: TextAlign.start,
                          color: ColorName.primaryColor,
                        ),
                      ],
                    ),
                    onTap: element.type == 'order'
                        ? () async {
                      await controller.userOrderList(
                          invoiceID: element.invoice!);
                      if (controller.myOrder.isNotEmpty) {
                        await Get.toNamed(Routes.ORDER_DETAILS,
                            arguments: {
                              'arg1': controller.myOrder.first
                            });
                      }
                    }
                        : () {},
                    leading: CircleAvatar(
                      backgroundColor: ColorName.primaryColor.withOpacity(0.2),
                      child: Center(
                          child: Image.asset(
                        AppConfig.appLogo,
                        height: 25,
                        width: 25,
                      )),
                    ),
                  ),
                );
              },
            );
          } else {
            return Expanded(
              child: ServerErrorWidget(
                svgImagePath: Assets.icons.emptyNotification,
                title: 'Sorry',
                message: "You don't have any notification yet.",
                iconHeight: 200.h,
                iconWidth: 200,
              ),
            );
          }
        } else if (controller.isLoading.value == 1) {
          return Center(
              child: loadingAnimationWidget(
                  color: ColorName.primaryColor, size: 40));
        } else {
          return const Expanded(child: ServerErrorWidget());
        }
      }),
    );
  }

  int groupComparator(String value1, String value2) {
    final priority = {
      'Today'.tr: 0,
      'Yesterday'.tr: 1,
      'This Week'.tr: 2,
    };
    final p1 =
        priority[value1] ?? 3; // Default to 'Older' if not in the priority list
    final p2 = priority[value2] ?? 3;
    return p1.compareTo(p2);
  }

  String _groupByDate(DateTime? date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    if (date == null) return 'Unknown';
    final dateToCheck = DateTime(date.year, date.month, date.day);
    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else if (now.difference(dateToCheck).inDays < 7) {
      return 'This Week';
    } else {
      return DateFormat('MMMM yyyy').format(date);
    }
  }
}
