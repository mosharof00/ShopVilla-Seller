import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController  with GetSingleTickerProviderStateMixin{
  RxInt selectedTabIndex = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.onInit();
  }

  void updateSelectedTab(int index) {
    selectedTabIndex.value = index;
    tabController.animateTo(index);
    update();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

}
