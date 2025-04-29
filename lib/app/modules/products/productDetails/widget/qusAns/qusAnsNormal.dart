import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_villa_seller/global/parse_dateAndTime.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../../global/app_text_style.dart';
import '../../../../../../global/cashed_image_helper.dart';
import '../../../../../../global/loadingAnimationWidget.dart';
import '../../../../../../global/methods/get_image_url.dart';
import '../../../../../models/q&a/q&aGetModel.dart';
import '../../../../qus_and_ans/controllers/qus_and_ans_controller.dart';
import '../../controllers/product_details_controller.dart';

class QusAnsNormal extends StatelessWidget {
  const QusAnsNormal({super.key, this.physics});
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    final qusAnsController = Get.put(QusAndAnsController());
    final productDetailsController = Get.find<ProductDetailsController>();
    return Obx(() {
      if (productDetailsController.isLoadingQalist.value) {
        return loadingAnimationWidget();
      } else if (productDetailsController.qusAnsList.isEmpty) {
        return Column(
          children: [
            SvgPicture.asset(Assets.images.ques, height: 90.h,width: 110.w,),
            3.height,
            Center(
              child: AppTextStyle(
                text: 'No Q&A Found',
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: productDetailsController.qusAnsList.length,
            physics: physics ?? const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, item) {
              final QusAnsGetList qusAnsGetList =
              productDetailsController.qusAnsList[item];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CommentTreeWidget<Comment, Comment>(
                      Comment(
                        avatar: 'null',
                        userName: 'null',
                        content: qusAnsGetList.question!,
                      ),
                      qusAnsGetList.reply!.map((reply) {
                        return Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: reply.answer!,
                        );
                      }).toList(),
                      treeThemeData: const TreeThemeData(
                          lineColor: ColorName.gray410, lineWidth: 2),
                      avatarRoot: (context, data) => PreferredSize(
                        preferredSize: Size.fromRadius(18.r),
                        child: circularImage(
                            imgUrl: qusAnsGetList.user!.image!,
                            radius: 20.r,
                            imgRadius: 50.r,
                            imgWidth: 40.w,
                            imgHeight: 40
                                .h), // cachedImageHelper(imgurl: GetImageUrl.url(), imgWidth: 30.w, imgHeight: 30.h),
                      ),
                      avatarChild: (context, data) => PreferredSize(
                        preferredSize: Size.fromRadius(12.r),
                        child: circularImage(
                            imgUrl: qusAnsGetList.admin!.image!,
                            radius: 15.r,
                            imgRadius: 50.r,
                            imgWidth: 30.w,
                            imgHeight: 30.h),
                      ),
                      contentChild: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: data.content!,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextStyle(
                                  text:
                                  '${qusAnsGetList.admin!.name!.capitalize} |',
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorName.gray410,
                                ),
                                5.width,
                                AppTextStyle(
                                  text: DateTimeUtils.formatTimeAgo(qusAnsGetList
                                      .reply!
                                      .firstWhere((reply) =>
                                  reply.answer == data.content)
                                      .createdAt!
                                      .toString()),
                                  fontSize: 10.sp,
                                  color: ColorName.gray410,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      contentRoot: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: qusAnsGetList.question!,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextStyle(
                                  text:
                                  '${qusAnsGetList.user!.name!.capitalize} |',
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorName.gray410,
                                ),
                                5.width,
                                AppTextStyle(
                                  text: DateTimeUtils.formatTimeAgo(
                                      qusAnsGetList.createdAt!.toString()),
                                  fontSize: 10.sp,
                                  color: ColorName.gray410,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    });
  }
}
