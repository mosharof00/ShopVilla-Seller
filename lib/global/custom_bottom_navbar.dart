import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<TabItem> navItems = [
  TabItem(
    icon: MdiIcons.viewDashboard,
    title: "DashBoard".tr,
  ),
  TabItem(
    icon: MdiIcons.finance,
    title: 'Financial'.tr,
  ),
  TabItem(
    icon: Icons.shopping_cart,
    title: 'All Products'.tr,
  ),
  TabItem(
    icon: Icons.person,
    title: 'Profile'.tr,
  ),
];
