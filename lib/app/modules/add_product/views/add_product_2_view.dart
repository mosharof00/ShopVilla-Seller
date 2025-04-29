import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/add_product/controllers/add_product_controller.dart';
import 'package:shop_villa_seller/app/modules/add_product/views/add_product_3_view.dart';
import 'package:shop_villa_seller/app/modules/add_product/widget/view_variations.dart';
import 'package:shop_villa_seller/app/modules/sales_summary/widgets/product_labels.dart';
import 'package:shop_villa_seller/gen/assets.gen.dart';
import 'package:shop_villa_seller/global/awesome_alert_dialog.dart';
import 'package:shop_villa_seller/global/bottomSheet/custom_svg_image.dart';
import 'package:shop_villa_seller/global/global_controllers/product_attributes_controller.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import 'package:shop_villa_seller/global/loading_button.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import 'package:shop_villa_seller/global/methods/get_image_url.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/global_button.dart';
import '../../../models/add_product_model/product_attribute_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_product_variation_controller.dart';
import '../widget/add_product_title_text.dart';
import '../widget/add_variation_bottom_sheet.dart';
import '../widget/easy_stepper.dart';

class AddProduct2View extends GetView<AddProductVariationController> {
  const AddProduct2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddProductVariationController());
    ProductAttributesController productAttributesController =
        Get.put(ProductAttributesController());
    AddProductController addProductController = Get.put(AddProductController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool, dynamic) {
        awesomeAlertDialog(
          context,
          DialogType.warning,
          'Warning! Cancelling Product',
          'Want to Cancel this Product?',
          'No',
          () {},
          'Yes',
          () {
            Get.delete<AddProductController>();
            Get.delete<AddProductVariationController>();
            Get.delete<ProductAttributesController>();
            Get.toNamed(Routes.MAIN_PAGE);
          },
          true,
        );
      },
      child: Scaffold(
        backgroundColor: ColorName.bgColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {
          //     addProductController.activeStep.value--;
          //     Get.back();
          //   },
          //   icon: const Icon(Icons.arrow_back_sharp),
          // ),
          title: appbarTitle(
              text: addProductController.appBarTitle.value.isEmpty
                  ? 'Add Product step-2'
                  : addProductController.appBarTitle.value),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  addProductController.activeStep.value;
                  return const AddProductEasyStepper();
                }),
                10.height,
                ViewVariations(
                  controller: controller,
                  editVariation: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorName.gray70,
                    ),
                    onPressed: () {
                      controller.setupToUpdateProductVariation();
                      if (controller.subVariationList.isEmpty) {
                        controller.isSubVariationSelect.value = false;
                      }
                      controller.isSubVariationSelect.value = true;
                      variationAddCustomDialog(productAttributesController);
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: ColorName.primaryColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              globalButton(
                  fontSize: 15.sp,
                  width: Get.width / 2.5,
                  onTap: () {
                    controller.clearSelectedVariations();
                    controller.isWantToUpdate.value = false;
                    variationAddCustomDialog(productAttributesController);
                  },
                  text: 'Add Variation'),
              globalButton(
                  fontSize: 15.sp,
                  width: Get.width / 2.5,
                  onTap: () {
                    addProductController.activeStep.value++;
                    // controller.submitProduct();
                    Get.to(() => const AddProduct3View());
                  },
                  text: 'Next Step'),
            ],
          ),
        ),
      ),
    );
  }

  variationAddCustomDialog(
      ProductAttributesController productAttributesController) {
    return showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        final formKey = GlobalKey<FormState>();
        return Container(
          height: Get.height * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorName.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///                    Select Color       ///
              titleText('Select Color'),
              5.height,
              Obx(() {
                if (controller.isWantToUpdate.value) {
                  return Row(
                    children: [
                      Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                                  controller.selectedProductVariation.value!
                                      .colorCode!
                                      .substring(1, 7),
                                  radix: 16,
                                ) +
                                0xFF000000,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.r,
                            ),
                          ],
                        ),
                      ),
                      10.width,
                      AppTextStyle(
                        text: controller.selectedProductVariation.value!.color!
                            .toString(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  );
                } else {
                  return DropDownContainer(
                    isSelected: controller.isColorSelected.value,
                    validatorText: 'Please enter a Category',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Attribute>(
                        borderRadius: BorderRadius.circular(10.r),
                        hint: AppTextStyle(
                          text: 'Select Color',
                          color: Colors.grey,
                          fontSize: 13.sp,
                        ),
                        isExpanded: true,
                        value: controller.selectedColor.value,
                        items:
                            productAttributesController.colorList.map((color) {
                          return DropdownMenuItem<Attribute>(
                            value: color,
                            child: Row(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    color: Color(
                                      int.parse(
                                            color.colorCode!.substring(1, 7),
                                            radix: 16,
                                          ) +
                                          0xFF000000,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.r,
                                      ),
                                    ],
                                  ),
                                ),
                                5.width,
                                Text(color.name ?? ''),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (Attribute? newValue) {
                          controller.selectColor(newValue);
                        },
                      ),
                    ),
                  );
                }
              }),
              15.height,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  titleText('Image'),
                  5.height,
                  Obx(() {
                    // final controller = Get.find<AddProductController>();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 100.h,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.selectedImageList.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return InkWell(
                                    onTap: () {
                                      // controller.imageList.add(
                                      //     "https://img.freepik.com/premium-photo/skincare-beauty-product_946209-6411.jpg");
                                      //
                                      controller.pickImage();
                                    },
                                    child: DottedBorder(
                                      color: controller.isImageSelect.value
                                          ? Colors.grey
                                          : ColorName.textFieldErrorColor,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      strokeWidth: 1,
                                      child: Container(
                                        height: 100.h,
                                        width: 100.w,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: ColorName.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.add_a_photo_rounded,
                                              size: 60,
                                              color: ColorName.gray410,
                                            ),
                                            // Spacing between icon and text
                                            5.height,
                                            const AppTextStyle(
                                              text: 'Add Image',
                                              fontWeight: FontWeight.w600,
                                              color: ColorName.gray410,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  final bool isImageFromNetWork = controller
                                              .selectedImageList[index - 1]
                                              .split('/')[0] ==
                                          'public'
                                      ? true
                                      : false;
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 100.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5.r,
                                        )
                                      ],
                                      image: isImageFromNetWork
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                GetImageUrl.url(controller
                                                        .selectedImageList[
                                                    index - 1]),
                                              ),
                                            )
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(
                                                  controller.selectedImageList[
                                                      index - 1]!,
                                                ),
                                              )),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        onTap: () {
                                          controller
                                              .removeSelectedImage(index - 1);
                                        },
                                        child: Container(
                                          height: 20.h,
                                          width: 20.w,
                                          padding: EdgeInsets.all(4.r),
                                          margin: EdgeInsets.all(2.r),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          child: Center(
                                            child: customSvgImage(
                                                imagePath: Assets
                                                    .icons.crossOutlineIcon,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ),
                        controller.isImageSelect.value
                            ? 0.width
                            : AppTextStyle(
                                text: 'Please select minimum 1 image',
                                fontSize: 12.sp,
                                color: ColorName.textFieldErrorColor,
                              )
                      ],
                    );
                  }),
                ],
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  labels(
                      text: 'Product Sub Variation',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                  InkWell(
                    onTap: () {
                      controller.clearSubVariationsData();
                      addVariationBottomSheet(
                        context: Get.context!,
                        formKey: formKey,
                        pricesEditingController:
                            controller.pricesEditingController,
                        quantityEditingController:
                            controller.quantityEditingController,
                        discountEditingController:
                            controller.discountEditingController,
                        purchaseEditingController:
                            controller.purchaseEditingController,
                        applyOnTap: () {
                          if (formKey.currentState!.validate() &&
                              controller.isSizeSelect.value) {
                            controller.addSubVariation();
                            controller.isSubVariationSelect.value = true;
                          } else {
                            globalSnackBar(
                                durationInSeconds: 2,
                                title: 'Alert!',
                                message: "Please enter all required feeds");
                          }
                        },
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.add_box,
                            color: ColorName.primaryColor),
                        5.width,
                        AppTextStyle(
                          text: 'Add New',
                          color: ColorName.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Obx(() => controller.isSubVariationSelect.value
                  ? 0.width
                  : AppTextStyle(
                      text: 'Please select minimum 1 SubVariation',
                      fontSize: 12.sp,
                      color: ColorName.textFieldErrorColor,
                    )),
              10.height,
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.subVariationList.length,
                      itemBuilder: (context, index) {
                        final SubVariationModel data =
                            controller.subVariationList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorName.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5.r,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        viewText(
                                            key: 'Size:', value: data.size),
                                        viewText(
                                            key: 'price:', value: data.price),
                                        viewText(
                                            key: 'Dis:', value: data.discount),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        viewText(
                                            key: 'buy Price:',
                                            value: data.purchasePrice),
                                        viewText(
                                            key: 'Qty:', value: data.quantity),
                                        105.width,
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              30.width,
                              InkWell(
                                onTap: () {
                                  controller.removeSubVariation(index: index);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              30.height,
              Obx(
                () => loadingButton(
                    controller: controller.btnController,
                    fontSize: 15.sp,
                    onTap: () {
                      if (controller.isWantToUpdate.value) {
                        if (controller.selectedImageList.isEmpty) {
                          globalSnackBar(
                              durationInSeconds: 2,
                              title: 'Alert!',
                              message: "Please select an Image");
                          controller.btnController.stop();
                        } else {
                          controller.updateProductVariations(
                              variationID: controller
                                  .selectedProductVariation.value!.id
                                  .toString());
                          Get.back();
                        }
                      } else {
                        if (controller.isColorSelected.value == false ||
                            controller.selectedImageList.isEmpty ||
                            controller.subVariationList.isEmpty) {
                          controller.isImageSelect.value = false;
                          controller.isSubVariationSelect.value = false;
                          globalSnackBar(
                              durationInSeconds: 2,
                              title: 'Alert!',
                              message: "Please enter all required feeds");
                          controller.btnController.stop();
                        } else {
                          controller.isImageSelect.value = true;

                          ///   check is already variation existing or not
                          if (controller.isAlreadyExistedVariation(
                              selectedColorID:
                                  controller.selectedColor.value!.id!)) {
                            Log.i("Already Variation added called");
                            awesomeAlertDialog(
                                context,
                                DialogType.warning,
                                'Alert!',
                                "This Variation is Already added. \n Do you want to update or replace the variation?.\n note: If don't want to update, please change the variation via Color.",
                                'No',
                                () {
                                  // Get.back();
                                  controller.btnController.stop();
                                },
                                'Yes',
                                () {
                                  controller.updateProductVariations(
                                      variationID: controller
                                          .variationAddToUpdateSelectedID
                                          .value);
                                  Get.back();
                                },
                                false);
                          } else {
                            Log.i("Add variation called");
                            controller.addProductVariations();
                            Get.back();
                          }
                        }
                      }
                    },
                    text: controller.isWantToUpdate.value
                        ? 'Update Variation'
                        : 'Add Variation'),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget viewText({required String key, required String value}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      AppTextStyle(
        text: key,
        fontSize: 12.sp,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
      2.width,
      AppTextStyle(
        text: value,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    ],
  );
}
