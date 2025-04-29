import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa_seller/app/models/brand/brand_model.dart';
import 'package:shop_villa_seller/app/models/product_model/sort_filter__list_model.dart';
import 'package:shop_villa_seller/global/app_input_textformfield.dart';
import 'package:shop_villa_seller/global/loading_button.dart';
import 'package:shop_villa_seller/global/server_error_widget.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/global_snackbar.dart';
import '../../../models/category/Category_Model/category_model.dart';
import '../../../models/category/sub_category/sub_category_model.dart';
import '../../../models/supplier/supplier_get_model.dart';
import '../controllers/add_product_controller.dart';
import '../widget/add_product_title_text.dart';
import '../widget/easy_stepper.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(
            text: controller.appBarTitle.value.isEmpty
                ? 'Add Product step-1'
                : controller.appBarTitle.value),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isInitializing.value == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    controller.activeStep.value;
                    return const AddProductEasyStepper();
                  }),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: AppTextStyle(
                            text: "Product Information's",
                            color: Colors.grey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        20.height,
                        titleText("Product Name"),
                        5.height,
                        AppInputTextFormField(
                          controller: controller.nameEditingController,
                          hintText: 'Product Name',
                          fontSize: 13.sp,
                          autoValidateMode: AutovalidateMode.disabled,
                          errorBorderColor: ColorName.textFieldErrorColor,
                          errorTextColor: ColorName.textFieldErrorColor,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return 'Please enter a Product Name';
                            }
                            return null;
                          },
                        ),
                        15.height,
                        titleText("Product SKU"),
                        5.height,
                        AppInputTextFormField(
                          controller: controller.skuEditingController,
                          hintText: 'Product SKU',
                          fontSize: 13.sp,
                          autoValidateMode: AutovalidateMode.disabled,
                          errorBorderColor: ColorName.textFieldErrorColor,
                          errorTextColor: ColorName.textFieldErrorColor,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return 'Please enter a Product SKU';
                            }
                            return null;
                          },
                        ),
                        15.height,

                        titleText('Product Description'),
                        5.height,
                        AppInputTextFormField(
                          controller: controller.descriptionEditingController,
                          hintText: 'Product Description',
                          maxLines: 5,
                          fontSize: 13.sp,
                          autoValidateMode: AutovalidateMode.disabled,
                          errorBorderColor: ColorName.textFieldErrorColor,
                          errorTextColor: ColorName.textFieldErrorColor,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return 'Please enter a Product Description';
                            }
                            return null;
                          },
                        ),
                        15.height,

                        ///     Category
                        titleText('Categories Name'),
                        5.height,
                        Obx(
                          () => DropDownContainer(
                            isSelected: controller.isCategorySelected.value,
                            validatorText: 'Please enter a Category',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Categories>(
                                borderRadius: BorderRadius.circular(10.r),
                                hint: AppTextStyle(
                                  text: 'Select Category',
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                ),
                                isExpanded: true,
                                value: controller.selectedCategory.value,
                                items: controller.categoryList.map((category) {
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
                          ),
                        ),
                        15.height,

                        ///   Sub Category
                        titleText('Sub Categories Name'),
                        5.height,
                        Obx(() => DropDownContainer(
                              isSelected:
                                  controller.isSubCategorySelected.value,
                              validatorText: 'Please enter a Sub Category',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<SubCategory>(
                                  borderRadius: BorderRadius.circular(10.r),
                                  hint: AppTextStyle(
                                    text: controller.subCategoryList.isEmpty
                                        ? 'There are no subcategory within this category'
                                        : 'Select SubCategory',
                                    textAlign: TextAlign.start,
                                    color: controller.subCategoryList.isEmpty
                                        ? Colors.red.shade200
                                        : Colors.grey,
                                    fontSize: 12.sp,
                                  ),
                                  isExpanded: true,
                                  value: controller.selectedSubCategory.value,
                                  items: controller.subCategoryList
                                      .map((subCategory) {
                                    return DropdownMenuItem<SubCategory>(
                                      value: subCategory,
                                      child: Text(subCategory.name ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (SubCategory? newValue) {
                                    controller.selectSubCategory(newValue);
                                  },
                                ),
                              ),
                            )),
                        15.height,

                        ///     Product Type
                        titleText('Product Type Name'),
                        5.height,
                        Obx(
                          () => DropDownContainer(
                            isSelected: controller.isSelectedType.value,
                            validatorText: 'Please enter a Product Type',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<FilterType>(
                                borderRadius: BorderRadius.circular(10.r),
                                hint: AppTextStyle(
                                  text: 'Select Type',
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                ),
                                isExpanded: true,
                                value: controller.selectedType.value,
                                items: controller.typeList.map((type) {
                                  return DropdownMenuItem<FilterType>(
                                    value: type,
                                    child: Text(type.status ?? ''),
                                  );
                                }).toList(),
                                onChanged: (FilterType? newValue) {
                                  controller.selectProductType(newValue);
                                },
                              ),
                            ),
                          ),
                        ),
                        15.height,

                        ///    Brand
                        titleText('Brand Name'),
                        5.height,
                        DropDownContainer(
                          isSelected: true,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<BrandData>(
                              borderRadius: BorderRadius.circular(10.r),
                              hint: AppTextStyle(
                                text: 'Select Brand',
                                color: Colors.grey,
                                fontSize: 13.sp,
                              ),
                              isExpanded: true,
                              value: controller.selectedBrand.value,
                              items: controller.brandList.map((brand) {
                                return DropdownMenuItem<BrandData>(
                                  value: brand,
                                  child: Text(brand.name ?? ''),
                                );
                              }).toList(),
                              onChanged: (BrandData? newValue) {
                                controller.selectBrand(newValue);
                              },
                            ),
                          ),
                        ),
                        15.height,

                        ///    Supplier
                        titleText('Supplier Name'),
                        5.height,
                        DropDownContainer(
                          isSelected: true,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Supplier>(
                              borderRadius: BorderRadius.circular(10.r),
                              hint: AppTextStyle(
                                text: 'Select Supplier',
                                color: Colors.grey,
                                fontSize: 13.sp,
                              ),
                              isExpanded: true,
                              value: controller.selectedSupplier.value,
                              items: controller.supplierList.map((supplier) {
                                return DropdownMenuItem<Supplier>(
                                  value: supplier,
                                  child: Text(supplier.supplierName ?? ''),
                                );
                              }).toList(),
                              onChanged: (Supplier? newValue) {
                                controller.selectSupplier(newValue);
                              },
                            ),
                          ),
                        ),
                        15.height,

                        ///     Gender
                        titleText('Gender'),
                        5.height,
                        Obx(
                          () => DropDownContainer(
                            isSelected: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<GenderStaticModel>(
                                borderRadius: BorderRadius.circular(10.r),
                                hint: AppTextStyle(
                                  text: 'Select Gender',
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                ),
                                isExpanded: true,
                                value: controller.selectedGender.value,
                                items: controller.genderList.map((gender) {
                                  return DropdownMenuItem<GenderStaticModel>(
                                    value: gender,
                                    child: Text(gender.name ?? ''),
                                  );
                                }).toList(),
                                onChanged: (GenderStaticModel? newValue) {
                                  controller.selectGender(newValue);
                                },
                              ),
                            ),
                          ),
                        ),

                        // 15.height,
                        // ///    Product Status
                        // titleText(' Product Status Name'),
                        // 5.height,
                        // Obx(
                        //   () => DropDownContainer(
                        //     isSelected: controller.isStatusSelected.value,
                        //     validatorText: 'Please enter a Product Status',
                        //     child: DropdownButtonHideUnderline(
                        //       child: DropdownButton<ProductStatusStaticModel>(
                        //         borderRadius: BorderRadius.circular(10.r),
                        //         hint: AppTextStyle(
                        //           text: 'Select Status',
                        //           color: Colors.grey,
                        //           fontSize: 13.sp,
                        //         ),
                        //         isExpanded: true,
                        //         value: controller.selectedProductStatus.value,
                        //         items: controller.productStatusList.map((status) {
                        //           return DropdownMenuItem<ProductStatusStaticModel>(
                        //             value: status,
                        //             child: Text(status.name ?? ''),
                        //           );
                        //         }).toList(),
                        //         onChanged: (ProductStatusStaticModel? newValue) {
                        //           controller.selectProductStatus(newValue);
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        15.height,
                        titleText('Sort Video URL'),
                        5.height,
                        AppInputTextFormField(
                          controller: controller.videoURLEditingController,
                          hintText: 'Video URL',
                          maxLines: 3,
                          fontSize: 13.sp,
                          autoValidateMode: AutovalidateMode.disabled,

                          // validator: (value) {
                          //   if (value == null ||
                          //       value.isEmpty ||
                          //       value.trim().isEmpty) {
                          //     return 'Please enter a Video URL';
                          //   }
                          //   return null;
                          // },
                        ),

                        30.height,
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (controller.isInitializing.value == 1) {
          return Center(
            child: LoadingAnimationWidget.stretchedDots(
              size: 40,
              color: ColorName.primaryColor,
            ),
          );
        } else {
          return ServerErrorWidget(
            iconWidth: Get.width,
            iconHeight: 300.h,
          );
        }
      }),

      ///           Button        ///
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: loadingButton(
            onTap: () {
              if (formKey.currentState!.validate() &&
                      controller.isCategorySelected.value &&
                      controller.isSubCategorySelected.value &&
                      controller.isSelectedType.value
                  // &&  controller.isStatusSelected.value,
                  ) {
                if (controller.isProductUpdateMode.value) {
                  ///   for Update product
                  controller.fetchUpdateProduct();
                } else {
                  ///  for add new Product
                  controller.fetchAddProduct();
                }
              } else {
                globalSnackBar(
                    title: 'Alert!',
                    message: "Please enter all required feeds");
                controller.btnController.stop();
              }
              //
              // controller.activeStep.value++;
              // Get.to(() => const AddProduct2View(), arguments: {"id": 33});
              // controller.btnController.stop();
            },
            controller: controller.btnController,
            text: 'Continue Add Product'),
      ),
    );
  }
}
