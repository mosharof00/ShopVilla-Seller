import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shop_villa_seller/app/modules/add_product/controllers/add_product_variation_controller.dart';
import 'package:shop_villa_seller/app/modules/add_product/widget/add_product_title_text.dart';
import 'package:shop_villa_seller/global/global_controllers/product_attributes_controller.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_input_textformfield.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/bottomSheet/custom_bottom_sheet.dart';
import '../../../../../global/global_button.dart';
import '../../../models/add_product_model/product_attribute_model.dart';
import '../controllers/add_product_controller.dart';

Future addVariationBottomSheet({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required VoidCallback applyOnTap,
  required TextEditingController pricesEditingController,
  required TextEditingController quantityEditingController,
  required TextEditingController discountEditingController,
  required TextEditingController purchaseEditingController,
}) {
  final controller = Get.put(AddProductVariationController());
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    elevation: 5,
    builder: (BuildContext context) {
      return Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: ColorName.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x33000000),
              offset: Offset(1, 1),
            )
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: AppTextStyle(
                            text: "Select Variation",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
          
                  15.height,
                  AppTextStyle(
                    text: 'Size',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  5.height,
                  Obx(
                    () => DropDownContainer(
                      isSelected: controller.isSizeSelect.value,
                      validatorText: 'Please enter a Size',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Attribute>(
                          borderRadius: BorderRadius.circular(10.r),
                          hint: AppTextStyle(
                            text: 'Select Size',
                            color: Colors.grey,
                            fontSize: 13.sp,
                          ),
                          isExpanded: true,
                          value: controller.selectedSize.value,
                          items: Get.find<ProductAttributesController>()
                              .sizeList
                              .map((size) {
                            return DropdownMenuItem<Attribute>(
                              value: size,
                              child: Text(size.name ?? ''),
                            );
                          }).toList(),
                          onChanged: (Attribute? newValue) {
                            controller.selectedSize(newValue);
                            controller.isSizeSelect.value = true;
                          },
                        ),
                      ),
                    ),
                  ), //Class
                  15.height,
                  AppTextStyle(
                    text: 'Price',
                    textAlign: TextAlign.left,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  5.height,
                  AppInputTextFormField(
                    controller: pricesEditingController,
                    hintText: 'Price per Size',
                    fillColor: ColorName.white,
                    width: Get.width,
                    keyboardType: TextInputType.number,
                    autoValidateMode: AutovalidateMode.disabled,
                    errorBorderColor: ColorName.textFieldErrorColor,
                    errorTextColor: ColorName.textFieldErrorColor,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return 'Please enter a Price per Size';
                      }
                      return null;
                    },
                  ),
          
                  15.height,
                  AppTextStyle(
                    text: 'Discount',
                    textAlign: TextAlign.left,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  5.height,
                  AppInputTextFormField(
                    controller: discountEditingController,
                    hintText: 'Discount',
                    fillColor: ColorName.white,
                    keyboardType: TextInputType.number,
                    autoValidateMode: AutovalidateMode.disabled,
                    errorBorderColor: ColorName.textFieldErrorColor,
                    errorTextColor: ColorName.textFieldErrorColor,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return 'Please enter a Product Discount';
                      }
                      return null;
                    },
                  ),
                  15.height,
                  AppTextStyle(
                    text: 'Purchase Price',
                    textAlign: TextAlign.left,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  5.height,
                  AppInputTextFormField(
                    controller: purchaseEditingController,
                    hintText: 'Purchase Price',
                    fillColor: ColorName.white,
                    keyboardType: TextInputType.number,
                    autoValidateMode: AutovalidateMode.disabled,
                    errorBorderColor: ColorName.textFieldErrorColor,
                    errorTextColor: ColorName.textFieldErrorColor,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return 'Please enter Purchase Price';
                      }
                      return null;
                    },
                  ),
                  15.height,
                  AppTextStyle(
                    text: 'Quantity',
                    textAlign: TextAlign.left,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  5.height,
                  AppInputTextFormField(
                    controller: quantityEditingController,
                    hintText: 'How many Pieces  ',
                    fillColor: ColorName.white,
                    keyboardType: TextInputType.number,
                    autoValidateMode: AutovalidateMode.disabled,
                    errorBorderColor: ColorName.textFieldErrorColor,
                    errorTextColor: ColorName.textFieldErrorColor,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return 'Please enter Quantity';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  globalButton(
                    onTap: applyOnTap,
                    width: Get.width,
                    text: 'Save Size',
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
