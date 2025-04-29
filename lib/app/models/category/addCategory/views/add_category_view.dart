import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/category/Category_Model/category_model.dart';
import 'package:shop_villa_seller/app/modules/add_product/views/add_product_2_view.dart';
import 'package:shop_villa_seller/app/modules/add_product/views/add_product_3_view.dart';
import 'package:shop_villa_seller/app/repository/api_endpoint.dart';
import 'package:shop_villa_seller/gen/assets.gen.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../../global/FlutterInputField.dart';
import '../../../../../global/app_input_textformfield.dart';
import '../../../../../global/app_text_style_over_flow.dart';
import '../../../../../global/bottomSheet/custom_bottom_sheet.dart';
import '../../../../../global/global_button_without_gradient.dart';
import '../../../../../global/loading_button.dart';
import '../../../../../global/methods/get_image_url.dart';
import '../../../../../global/shimmer_loading.dart';
import '../../../../modules/brand/widgets/add_brand_helper_widgets.dart';
import '../../../../modules/sales_summary/widgets/product_labels.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/add_category_controller.dart';

class AddCategoryView extends GetView<AddCategoryController> {
  const AddCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddCategoryController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              SizedBox(
                height: 200.h,
                width: Get.width,
                child: Obx(() {
                  return controller.categoryList.isEmpty? shimmerLoadingWidget(): GridView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categoryList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of items per row
                      crossAxisSpacing:
                          5.0, // Spacing between items horizontally
                      mainAxisSpacing:
                          1.0, // Vertical spacing between grid items
                      // Adjust this to control item size
                    ),
                    itemBuilder: (context, item) {
                      final Categories category = controller.categoryList[item];
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.setCategoryForUpdate(category);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: GetImageUrl.url(category.image!),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 50.0.w,
                                      height: 50.0.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0),
                                            //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        shimmerLoadingWidget(
                                            borderRadius: 50,
                                            height: 50.0.h,
                                            width: 50.0.w),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Expanded(
                                    child: AppTextStyleOverFlow(
                                      text: category.categoryName!
                                          .split(' ')[0]
                                          .toString(),
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      fontSize: 11.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0.h,
                            right: 20.w,
                            child: Container(
                              height: 20.h,
                              width: 20.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorName.white),
                              child: const Center(
                                child: Icon(
                                  Icons.edit,
                                  size: 12,
                                  color: ColorName.gray410,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),
              5.height,
              labels(
                  text: 'Add New Category',
                  fontSize: 16.sp,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500),
              5.height,
              labels(
                  text: 'Here you can add/update new category',
                  fontSize: 11.sp,
                  textAlign: TextAlign.start,
                  color: ColorName.gray410,
                  fontWeight: FontWeight.w400),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    customBottomSheet(
                        context: context,
                        onTap1: () {
                          controller.getProfileImageFromFile();
                          Get.back();
                        },
                        svgIcon1: Assets.images.file,
                        text1: 'File',
                        onTap2: () {
                          controller.getProfileImageFromCamera();
                          Get.back();
                        },
                        svgIcon2: Assets.images.camera,
                        text2: 'Camera',
                        icon2Height: 45.h,
                        icon2Width: 45.w);
                  },
                  borderRadius: BorderRadius.circular(20.r),
                  child: Obx(() {
                    if (controller.isUpdateMode.value) {
                      if (controller.isGetImageFromFile.value) {
                        return showImageFromFile(
                            image: controller.selectedPhoto.value!.path,
                            deleteOnTap: () {
                              controller.clear();
                            });
                      } else {
                        return showImageFromNetwork(
                            image: controller.selectedPhoto.value!.path,
                            deleteOnTap: () {
                              controller.clear();
                            });
                      }
                    } else {
                      if (controller.isGetImageFromFile.value) {
                        return showImageFromFile(
                            image: controller.selectedPhoto.value!.path,
                            deleteOnTap: () {
                              controller.clear();
                            });
                      } else {
                        return picPlaceholderContainer(
                            color: controller.selectedPhoto.value == null
                                ? controller.errorColor
                                : Colors.grey,
                            widget: const Icon(
                              Icons.add_a_photo_rounded,
                              size: 60,
                              color: ColorName.primaryColor,
                            ));
                      }
                    }
                  }),
                ),
              ),
              30.height,
              labels(
                  text: 'Add Name',
                  fontSize: 16.sp,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500),
              5.height,
              FlutterInputField(
                textFieldController: controller.categoryName,
                borderColor: Colors.transparent,
                hintText: 'Category Name',
                labelText: '',
                filledColor: ColorName.white,
                lineHeight: 1,
                validateTextField: (value) {
                  if (value != null && int.tryParse(value) == null) {
                    return 'Required';
                  }
                  return null;
                },
                onChange: (String str) {},
                onDone: () {},
              ),
              20.height,
              labels(
                  text: 'Add Description',
                  fontSize: 16.sp,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500),
              5.height,
              FlutterInputField(
                textFieldController: controller.categoryDescription,
                borderColor: Colors.transparent,
                hintText: 'Category Description',
                labelText: '',
                filledColor: ColorName.white,
                lineHeight: 3,
                onChange: (String str) {},
                onDone: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          return loadingButton(
            onTap: () {
              if (controller.validateInputs()) {
                if (controller.isUpdateMode.value) {
                  // Update Category
                  controller.updateCategory(
                    id: controller.selectedCategoryId.value,
                    name: controller.categoryName.text,
                    desc: controller.categoryDescription.text,
                  );
                } else {
                  // Add Category
                  controller.addCategory(
                    name: controller.categoryName.text,
                    desc: controller.categoryDescription.text,
                    img: controller.selectedPhoto.value!.path,
                  );
                }
              } else {
                controller.btnController.stop();
              }
            },
            controller: controller.btnController,
            text: controller.isUpdateMode.value
                ? "Update Category"
                : "Add Category",
          );
        }),
      ),
    );
  }
}
