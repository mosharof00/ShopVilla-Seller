import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/searchbar_global.dart';
import '../../../../helper/appbar_title.dart';
import '../../../../helper/avatar.dart';
import '../../../models/q&a/q&aGetModel.dart';
import '../controllers/qus_and_ans_controller.dart';
import '../widget/quesAns.dart';

class QusAndAnsView extends GetView<QusAndAnsController> {
  const QusAndAnsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final qusAnsController = controller;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: appbarTitle(text: 'Q&A'),
        centerTitle: true,
      ),
      body: const QusAns()

        //Obx(() {
      //         if (qusAnsController.qusAnsList.isEmpty) {
      //           return Center(
      //             child: AppTextStyle(
      //               text: 'No Q&A Found',
      //               textAlign: TextAlign.center,
      //               fontWeight: FontWeight.w600,
      //               fontSize: 14.sp,
      //             ),
      //           );
      //         } else {
      //           return Container(
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(15.r),
      //             ),
      //             child: ListView.builder(
      //               shrinkWrap: true,
      //               itemCount: qusAnsController.qusAnsList.length,
      //               physics: const AlwaysScrollableScrollPhysics(),
      //               itemBuilder: (context, item) {
      //                 final QusAnsGetList qusAnsGetList = qusAnsController.qusAnsList[item];
      //                 final controller = qusAnsController.replyTextControllers[qusAnsGetList.id.toString()];
      //
      //                 return Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Column(
      //                     children: [
      //                       CommentTreeWidget<Comment, Comment>(
      //                         Comment(
      //                           avatar: 'null',
      //                           userName: 'null',
      //                           content: qusAnsGetList.question!,
      //                         ),
      //                         qusAnsGetList.reply!.map((reply) {
      //                           return Comment(
      //                             avatar: 'null',
      //                             userName: 'null',
      //                             content: reply.answer!,
      //                           );
      //                         }).toList(),
      //                         treeThemeData: const TreeThemeData(
      //                           lineColor: ColorName.gray410,
      //                           lineWidth: 2,
      //                         ),
      //                         avatarRoot: (context, data) => PreferredSize(
      //                           preferredSize: const Size.fromRadius(18),
      //                           child: avatar(height: 30.h, width: 30.w),
      //                         ),
      //                         avatarChild: (context, data) => PreferredSize(
      //                           preferredSize: const Size.fromRadius(12),
      //                           child: avatar(height: 25.h, width: 25.w),
      //                         ),
      //                         contentChild: (context, data) {
      //                           return Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               AppTextStyle(
      //                                 text: data.content!,
      //                                 fontSize: 12.sp,
      //                                 textAlign: TextAlign.start,
      //                               ),
      //                               Row(
      //                                 mainAxisAlignment: MainAxisAlignment.start,
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: [
      //                                   AppTextStyle(
      //                                     text: 'Seller |',
      //                                     fontSize: 10.sp,
      //                                     fontWeight: FontWeight.w400,
      //                                     color: ColorName.gray410,
      //                                   ),
      //                                   5.width,
      //                                   AppTextStyle(
      //                                     text: qusAnsController.parseDate(
      //                                       qusAnsGetList.reply!
      //                                           .firstWhere((reply) => reply.answer == data.content)
      //                                           .createdAt!
      //                                           .toString(),
      //                                     ),
      //                                     fontSize: 10.sp,
      //                                     color: ColorName.gray410,
      //                                   ),
      //                                 ],
      //                               ),
      //                             ],
      //                           );
      //                         },
      //                         contentRoot: (context, data) {
      //                           return Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               AppTextStyle(
      //                                 text: qusAnsGetList.question!,
      //                                 fontSize: 12.sp,
      //                                 textAlign: TextAlign.start,
      //                               ),
      //                               Row(
      //                                 mainAxisAlignment: MainAxisAlignment.start,
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: [
      //                                   AppTextStyle(
      //                                     text: 'User |',
      //                                     fontSize: 10.sp,
      //                                     fontWeight: FontWeight.w400,
      //                                     color: ColorName.gray410,
      //                                   ),
      //                                   5.width,
      //                                   AppTextStyle(
      //                                     text: qusAnsController.parseDate(
      //                                       qusAnsGetList.createdAt!.toString(),
      //                                     ),
      //                                     fontSize: 10.sp,
      //                                     color: ColorName.gray410,
      //                                   ),
      //                                 ],
      //                               ),
      //                             ],
      //                           );
      //                         },
      //                       ),
      //                       10.height,
      //                       Row(
      //                         children: [
      //                           Expanded(
      //                             child: TextField(
      //                               controller: controller,
      //                               decoration: InputDecoration(
      //                                 hintText: 'Add a reply...',
      //                                 border: OutlineInputBorder(
      //                                   borderRadius: BorderRadius.circular(15.r),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                           IconButton(
      //                             icon: const Icon(Icons.send),
      //                             onPressed: () {
      //                               print(controller);
      //                               if (controller!.text.isNotEmpty) {
      //                                 qusAnsController.qaAdminAns(
      //                                   qusID: qusAnsGetList.id.toString(),
      //                                   productID: qusAnsGetList.productId.toString(),
      //                                   answer: controller.text,
      //                                 );
      //                                 controller.clear();
      //                               } else {
      //                                 Get.snackbar('Q&A', 'Please fill-up all fields');
      //                               }
      //                             },
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               },
      //             ),
      //           );
      //         }
      //       }),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.only(
      //     bottom: MediaQuery.of(context).viewInsets.bottom + 8.0,
      //     left: 8.0,
      //     right: 8.0,
      //   ),
      //   child: InputFieldWithSendButton(
      //     prefixIcon: Icons.question_answer,
      //     suffixIcon: MdiIcons.send,
      //   ),
      // ),
    );
  }
}
