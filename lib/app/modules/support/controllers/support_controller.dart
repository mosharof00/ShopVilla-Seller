import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';

import '../../../services/local_store_config.dart';

class SupportController extends GetxController {
  String getCurrentUserId = HelperUtils.adminID; // declare the variable as nullable
  final messageNotificationCount = 0.obs;

  // Method to calculate the unseen messages
  void calculateUnseenMessages() {
    try {
      FirebaseFirestore.instance
          .collection('conversation')
          .doc(getCurrentUserId) // Use your method to get the current user ID
          .collection(getCurrentUserId)
          .snapshots()
          .listen((snapshot) {
        int count = 0;
        for (var doc in snapshot.docs) {
          if (!doc['msgSeen']) {
            count++;
          }
        }
        messageNotificationCount.value =
            count; // Update the observable with the new count
      });
    }
    catch (e, s) {
    }
  }

  @override
  void onInit() {
    calculateUnseenMessages();
    super.onInit();
  }
}
