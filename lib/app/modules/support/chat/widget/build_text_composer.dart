import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/log_printer.dart';
import '../../../../../helper/firebase_db_service.dart';
import '../../../../../helper/helper_utils.dart';
import '../../../../services/local_store_config.dart';
import '../../../../services/pushNotificationService.dart';
import '../../../profile/controllers/profile_controller.dart';
import '../controllers/chat_controller.dart';

Widget buildTextComposer(
    {required VoidCallback onTypingStarted,
    required VoidCallback onTypingEnded}) {
  bool isTyping = false;
  final controller = Get.put(ChatController());
  void handleTypingStatusChange(bool typing) {
    if (typing != isTyping) {
      isTyping = typing;
      if (isTyping) {
        onTypingStarted();
      } else {
        onTypingEnded();
      }
    }
  }

  return Container(
    padding: const EdgeInsets.only(bottom: 20.0),
    constraints: const BoxConstraints(
      maxHeight: 300.0,
    ),
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: controller.textController,
            onChanged: (String text) {
              handleTypingStatusChange(text.isNotEmpty);
            },
            maxLines: 3,
            minLines: 1,
            //onSubmitted: _handleSubmitted,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              // suffixIcon: SpeedDial(
              //   buttonSize: Size(15.w, 15.h),
              //   closeDialOnPop: false,
              //   backgroundColor: ColorName.white,
              //   children: <SpeedDialChild>[
              //     SpeedDialChild(
              //       child: Icon(MdiIcons.image),
              //       foregroundColor: Colors.white,
              //       backgroundColor: ColorName.primaryColor,
              //       shape: const CircleBorder(),
              //       labelStyle: GoogleFonts.nanumGothic(
              //           fontSize: 12.sp, fontWeight: FontWeight.w600),
              //       label: 'Image'.tr,
              //       onTap: () {
              //         controller.getFile();
              //       },
              //     ),
              //     SpeedDialChild(
              //       child: Icon(MdiIcons.microphone),
              //       foregroundColor: Colors.white,
              //       backgroundColor: ColorName.primaryColor,
              //       shape: const CircleBorder(),
              //       label: 'Audio'.tr,
              //       labelStyle: GoogleFonts.nanumGothic(
              //           fontSize: 12.sp, fontWeight: FontWeight.w600),
              //       onTap: () {},
              //     ),
              //     //  Your other SpeedDialChildren go here.
              //   ],
              //   child: Icon(
              //     MdiIcons.paperclip,
              //     size: 25,
              //   ),
              // ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: ColorName.primaryColor, width: 1.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.1),
                borderRadius: BorderRadius.circular(25.0),
              ),
              hintText: "Send a message",
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.send,
            color: ColorName.primaryColor,
          ),
          onPressed: () => handleSubmitted(controller.textController.text),
        ),
      ],
    ),
  );
}

void handleSubmitted(String text) async {
  final controller = Get.find<ChatController>();
  final profileController = Get.find<ProfileController>();

  // Clear the text field
  controller.textController.clear();

  // Send message using FirebaseDBService
  FirebaseDBService.sendMessage(
    controller.currentUserID.value.toString(),
    controller.otherUserID.value.toString(),
    FILETYPE.text.name,
    msg: text,
  );

  // Retrieve recipient's document
  final otherUserDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(controller.otherUserID.value.toString())
      .get();

  // Retrieve current user's document
  final currentUserDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(controller.currentUserID.value.toString())
      .get();

  // Get device token
  final deviceToken = HelperUtils.firebaseToken;

  // Get user ID from HiveService
  final userID = (await HiveService.getAdminID()).toString();

  // Check if current user document exists; if not, create it
  if (!currentUserDoc.exists) {
    await FirebaseFirestore.instance.collection('users').doc(userID).set({
      'email': profileController.profileDetails.value.data!.email,
      'name': profileController.profileDetails.value.data!.name,
      'id': profileController.profileDetails.value.data!.id,
      'device_token': deviceToken,
    });
  }

  // If recipient's document exists, send push notification
  if (otherUserDoc.exists) {
    final otherUserDeviceToken = otherUserDoc['device_token'];
    final currentUserName = profileController.profileDetails.value.data!.name;
    if (otherUserDeviceToken != null) {
      await PushNotificationService.sendNotificationToSelectedDriver(
        deviceToken: otherUserDeviceToken,
        context: Get.context!,
        currentUserName: currentUserName!,
        currentUserMsg: text,
      );
    }
  } else {
    Log.e('User document does not exist');
  }
}
