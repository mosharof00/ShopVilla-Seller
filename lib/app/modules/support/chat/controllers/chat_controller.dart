import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../helper/firebase_db_service.dart';
import '../../../../services/local_store_config.dart';

class ChatController extends GetxController {
  final TextEditingController textController = TextEditingController();
  Rxn<String> currentUserID = Rxn<String>(); // Nullable observable string
  Rxn<String> otherUserID = Rxn<String>();   // Nullable observable string
  @override
  void onInit() async {
    currentUserID.value =  await HiveService.getAdminID();
    otherUserID.value = Get.arguments;
    //msgseen
    super.onInit();
  }

  //sound notification for message
  final player = AudioPlayer();
  void playSound() async {
    await player.setAsset('assets/tone/correct.mp3');
    player.setVolume(0.2);
    await player.play();
  }

  //Get files from gallery
  Future<void> getFile() async {
    final XFile? pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
    } else {
      return;
    }
  }

  //msgTyping / isTyping
  void updateTypingStatus(bool isTyping) {
    FirebaseFirestore.instance
        .collection('conversation')
        .doc(currentUserID.value.toString())
        .collection(currentUserID.value.toString())
        .doc(otherUserID.toString())
        .update({'isTyping': isTyping});
  }


  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

}
