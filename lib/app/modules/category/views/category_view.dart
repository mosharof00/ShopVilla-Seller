import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/category/addCategory/views/add_category_view.dart';
import 'package:shop_villa_seller/app/models/category/addSubCategory/views/add_sub_category_view.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../global/app_text_style.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    const selectColor = Colors.white;
    const unselectColor = Colors.black;
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Categories'),
        centerTitle: true,
      ),
      body:  Column(
        children: [
          Container(
            height: 40.h,
            // width: Get.width,
            decoration: ShapeDecoration(
              color: ColorName.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TabBar(
                indicatorWeight: 0,
                tabAlignment: TabAlignment.fill,
                controller: controller.tabController,
                dividerColor: Colors.transparent,
                automaticIndicatorColorAdjustment: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: RectangularIndicator(
                  color: ColorName.primaryColor,
                  bottomLeftRadius: 8,
                  bottomRightRadius: 8,
                  topLeftRadius: 8,
                  topRightRadius: 8,
                  paintingStyle: PaintingStyle.fill,
                ),
                unselectedLabelColor: Colors.black,
                onTap: (index) {
                  controller.updateSelectedTab(index);
                },
                tabs: [
                  AppTextStyle(
                    text: 'Category',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                    color: controller.selectedTabIndex.value == 0
                        ? selectColor
                        : unselectColor,
                  ),
                  AppTextStyle(
                    text: 'SubCategory',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                    color: controller.selectedTabIndex.value == 1
                        ? selectColor
                        : unselectColor,
                  ),
                ],
              ),
            )),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              // physics: const ClampingScrollPhysics(),
              children: const [
                AddCategoryView(),
                AddSubCategoryView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
