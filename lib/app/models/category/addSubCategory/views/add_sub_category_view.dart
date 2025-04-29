import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/category/addCategory/controllers/add_category_controller.dart';
import 'package:shop_villa_seller/global/app_text_style_over_flow.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/FlutterInputField.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/bottomSheet/custom_bottom_sheet.dart';
import '../../../../../global/loading_button.dart';
import '../../../../../global/methods/get_image_url.dart';
import '../../../../modules/sales_summary/widgets/product_labels.dart';
import '../../../../repository/api_endpoint.dart';
import '../../Category_Model/category_model.dart';
import '../controllers/add_sub_category_controller.dart';

class AddSubCategoryView extends GetView<AddSubCategoryController> {
  const AddSubCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddSubCategoryController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labels(
                    text: 'Category',
                    fontSize: 16.sp,
                    textAlign: TextAlign.start,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    width: 350.w,
                    child: AppTextStyleOverFlow(
                      text: 'select category to add sub category.',
                      fontSize: 11.sp,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      color: ColorName.gray410,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              15.height,

              Obx(() {
                final addCategoryController = Get.put(AddCategoryController());
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorName.gray70),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Categories>(
                      hint: AppTextStyle(
                        text: 'Select Category',
                        color: Colors.black,
                        fontSize: 13.sp,
                      ),
                      isExpanded: true,
                      value: controller.selectedCategory.value,
                      items: addCategoryController.categoryList.map((category) {
                        return DropdownMenuItem<Categories>(
                          value: category,
                          child: Text(category.categoryName ?? ''),
                        );
                      }).toList(),
                      onChanged: (Categories? newValue) {
                        controller.selectCategory(newValue);
                      },
                    ),
                  ),
                );
              }),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labels(
                          text: 'Sub Category',
                          fontSize: 16.sp,
                          textAlign: TextAlign.start,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        width: 240.w,
                        child: AppTextStyleOverFlow(
                            text: 'add sub category of selected category.',
                            fontSize: 11.sp,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            color: ColorName.gray410,
                            fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: ColorName.white,
                      ),
                      onPressed: () {
                        controller.isAddNew.value = !controller.isAddNew.value;
                      },
                      child: const Text(
                        'Add New',
                        style: TextStyle(color: ColorName.primaryColor),
                      ))
                ],
              ),
              10.height,

              Obx(() {
                return controller.isAddNew.value
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          border: Border.all(color: ColorName.gray70),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Obx(
                                  () {
                                    return InkWell(
                                      onTap: () {
                                        customBottomSheet(
                                            context: context,
                                            onTap1: () {
                                              controller.selectedPhoto.value =
                                                  null;
                                              controller
                                                  .getProfileImageFromFile();
                                              Get.back();
                                            },
                                            svgIcon1: Assets.images.file,
                                            text1: 'File',
                                            onTap2: () {
                                              controller.selectedPhoto.value =
                                                  null;

                                              controller
                                                  .getProfileImageFromCamera();
                                              Get.back();
                                            },
                                            svgIcon2: Assets.images.camera,
                                            text2: 'Camera',
                                            icon2Height: 45.h,
                                            icon2Width: 45.w);
                                      },
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: controller.selectedPhoto.value ==
                                              null
                                          ? DottedBorder(
                                              borderType: BorderType.Circle,
                                              radius: const Radius.circular(12),
                                              color: Colors.grey,
                                              strokeWidth: 1,
                                              child: Container(
                                                height: 80.h,
                                                width: 80.w,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorName.white,
                                                ),
                                                child: const Icon(
                                                  Icons.add_a_photo_rounded,
                                                  size: 30,
                                                  color: ColorName.gray410,
                                                ),
                                              ),
                                            )
                                          : controller.isUpdateMode.value
                                              ? Stack(
                                                  children: [
                                                    Container(
                                                      height: 80.h,
                                                      width: 80.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            blurRadius: 5.r,
                                                          )
                                                        ],
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            '${ApiEndpoint.domainUrl}/${controller.selectedPhoto.value!.path}',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: -10.h,
                                                      left: -10.w,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          controller.clear();
                                                          controller
                                                              .isUpdateMode
                                                              .value = false;
                                                        },
                                                        icon: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.white54,
                                                          ),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            size: 25,
                                                            color: ColorName
                                                                .crimsonRed,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  height: 80.h,
                                                  width: 80.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 5.r,
                                                      )
                                                    ],
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(
                                                        File(
                                                          controller
                                                              .selectedPhoto
                                                              .value!
                                                              .path,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            10.width,
                            Expanded(
                              flex: 3,
                              child: FlutterInputField(
                                textFieldController:
                                    controller.subCategoryDescription,
                                borderColor: Colors.transparent,
                                hintText: 'Sub Category Name',
                                labelText: '',
                                filledColor: ColorName.white,
                                lineHeight: 1,
                                onChange: (String str) {},
                                onDone: () {},
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink();
              }),

              10.height,
              //List of Sub Category with image and name and edit button
              Obx(() {
                return ListView.builder(
                  itemCount: controller.subCategoryList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final subCategory = controller.subCategoryList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: ColorName.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    GetImageUrl.url(subCategory.image!) ?? '',
                                height: 50.h,
                                width: 50.w,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 80.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              10.width,
                              AppTextStyle(
                                text: subCategory.name ?? '',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              controller.isAddNew.value = true;
                              controller.subCategoryID.value = subCategory.id!;
                              Log.w(controller.subCategoryID.value);
                              controller.setSubCategoryForUpdate(subCategory);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: ColorName.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
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
                  // Update Sub Category
                  controller.updateSubCategory(
                    categoryID: controller.selectedCategoryId!,
                    subCategoryID: controller.subCategoryID.value,
                    name: controller.subCategoryDescription.text,
                    image: controller.selectedPhoto.value!.path,
                  );
                } else {
                  // Add Sub Category
                  controller.postSubCategory(
                    id: controller.selectedCategoryId!,
                    name: controller.subCategoryDescription.text,
                    image: controller.selectedPhoto.value!.path,
                  );
                }
              } else {
                controller.btnController.stop();
              }
            },
            controller: controller.btnController,
            text: controller.isUpdateMode.value
                ? "Update Sub Category"
                : "Add Sub Category",
          );
        }),
      ),
    );
  }
}
