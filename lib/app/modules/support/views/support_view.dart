import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import 'package:shop_villa_seller/helper/avatar.dart';
import 'package:shop_villa_seller/helper/divider.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';
import '../controllers/support_controller.dart';

class SupportView extends GetView<SupportController> {
  const SupportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Support'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('conversation')
            .doc(controller.getCurrentUserId)
            .collection(controller.getCurrentUserId)
            .orderBy('time', descending: true)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (!snapshots.hasData) {
            debugPrint("Snapshot data is not available.");
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                size: 50,
                color: ColorName.primaryColor,
              ),
            );
          }
          List<DocumentSnapshot> conversations = snapshots.data!.docs;
          if (conversations.isEmpty) {
            debugPrint("No conversations found.");
            return Center(
              child: AppTextStyle(
                text: "Recent chat is empty",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            );
          } else {
            debugPrint("Conversations data: ${conversations.length}");
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: conversations.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot conversation = conversations[index];
                String otherUserID = conversation.id;
                debugPrint("Other user ID: $otherUserID");
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(otherUserID)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // bool isOnline = snapshot.data!['isOnline'];
                      bool msgSeen = conversation['msgSeen'];
                      bool isMe = conversation['senderID'] ==
                          controller.getCurrentUserId;
                      String username = snapshot.data!['name'];
                      String lastMessage = conversation['lastMessage'];
                      Timestamp lastMessageTimestamp =
                          conversation['time'] ?? Timestamp.now();
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 5.h),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(15.r),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: msgSeen
                                  ? Colors.white24
                                  : isMe
                                      ? Colors.white24
                                      : Colors.blue.shade50,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('conversation')
                                        .doc(controller.getCurrentUserId)
                                        .collection(controller.getCurrentUserId)
                                        .doc(otherUserID)
                                        .update({'msgSeen': true});
                                    Get.toNamed(Routes.CHAT,
                                        arguments: otherUserID.toString());
                                  },
                                  leading: avatar(),
                                  title: AppTextStyle(
                                    text: username.capitalize!,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    textAlign: TextAlign.start,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 0.35.sw,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 0.7.sw,
                                            ),
                                            child: AppTextStyleOverFlow(
                                                text: lastMessage,
                                                fontSize: 12.sp,
                                                fontWeight: msgSeen
                                                    ? FontWeight.w500
                                                    : FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      AppTextStyleOverFlow(
                                          text: HelperUtils.formatTimeAgo(
                                              lastMessageTimestamp.toDate()),
                                          fontSize: 10.sp,
                                          color: ColorName.gray410,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                  trailing: msgSeen
                                      ? Icon(
                                          MdiIcons.checkAll,
                                          size: 15,
                                          color: ColorName.green,
                                        )
                                      : Icon(
                                          MdiIcons.check,
                                          size: 15,
                                          color: ColorName.gray410,
                                        ),
                                ),
                                5.height,
                                divider(height: 1.h, width: Get.width, color: ColorName.gray70)
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      debugPrint("User snapshot data is null.");
                      return const AppTextStyle(
                          text: "You have no friend",
                          fontSize: 15,
                          fontWeight: FontWeight.w600);
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
