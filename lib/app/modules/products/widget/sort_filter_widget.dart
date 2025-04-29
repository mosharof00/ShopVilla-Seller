import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/filter_sort_widget.dart';
import '../../../../global/global_button.dart';
import '../../../../global/global_controllers/product_attributes_controller.dart';
import '../../../../global/log_printer.dart';
import '../../../../global/methods/get_color_from_hex.dart';
import '../../../models/product_model/sort_filter__list_model.dart';
import '../controllers/products_controller.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.put(ProductsController());
    return Obx(() => SortFilter(
      text: 'Sort',
      filterIcon: false,
      textColor: productsController.isSorted.value
          ? ColorName.primaryColor
          : Colors.black,
      iconColor: productsController.isSorted.value
          ? ColorName.primaryColor
          : Colors.black,
      onTap: () {
        showModalBottomSheet(
          backgroundColor: ColorName.white,
          context: context,
          useSafeArea: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  5.height,
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 2.h,
                      width: 35.w,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  10.height,
                  Align(
                      alignment: Alignment.topCenter,
                      child: AppTextStyle(
                        text: 'Sort',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      )),
                  10.height,
                  Container(
                    height: 1.h,
                    width: Get.width,
                    color: Colors.grey.shade300,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                    Get.find<DashboardController>().sortList.length,
                    itemBuilder: (context, index) {
                      final Sort sort =
                      Get.find<DashboardController>().sortList[index];
                      return Obx(() {
                        return RadioListTile(
                          value: index,
                          groupValue:
                          productsController.selectedSortIndex.value,
                          onChanged: (value) {
                            productsController.selectedSortIndex.value =
                            value as int;
                            productsController.selectedSortName.value =
                            sort.value!;
                          },
                          title: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextStyle(
                                text: sort.status!,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          activeColor: ColorName.primaryColor,
                        );
                      });
                    },
                  ),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      globalButton(
                        onTap: () {
                          ///   Reset Sort onTap Button
                          productsController.resetSortData();
                          if (productsController.isFromSearch.value) {
                            productsController.fetchSearchProduct(
                                text:
                                productsController.searchedText.value);
                            Get.back();
                          } else {
                            productsController.selectedFilterTypeName
                                .value = productsController.initialType;
                            productsController.fetchProducts();
                            Get.back();
                          }
                        },
                        text: 'Reset',
                        width: 150.w,
                        shadowColor: Colors.transparent,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.grey, Colors.grey.shade400],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: globalButton(
                          onTap: () {
                            ///  fetching sorted  product
                            if (productsController
                                .selectedSortName.value.isEmpty) {
                              globalSnackBar(
                                  title: 'Alert!',
                                  message:
                                  'Please select an filter option');
                            } else {
                              Log.i(
                                  "Selected variation is: ${productsController.selectedSizeName.value}  & ID is : ${productsController.selectedFilterSizeID.value}");
                              if (productsController.isFromSearch.value) {
                                productsController.isSorted.value = true;
                                productsController.fetchSearchProduct(
                                    text: productsController
                                        .searchedText.value);
                                Get.back();
                              } else {
                                productsController.isSorted.value = true;
                                productsController.fetchProducts();
                                Get.back();
                              }
                            }
                          },
                          text: 'Apply',
                          shadowColor: Colors.transparent,
                          width: 150.w,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    ));
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.put(ProductsController());
    final productAttributesController =
        productsController.productAttributesController;
    return Obx(() => SortFilter(
      text: 'Filter',
      filterIcon: true,
      textColor: productsController.isFiltered.value
          ? ColorName.primaryColor
          : Colors.black,
      iconColor: productsController.isFiltered.value
          ? ColorName.primaryColor
          : Colors.black,
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: ColorName.white,
          context: context,
          useSafeArea: true,
          builder: (BuildContext context) {
            return SizedBox(
              // height: 510.h,
              width: Get.width,
              child: Padding(
                padding:
                EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    5.height,
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 2.h,
                        width: 35.w,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    10.height,
                    Align(
                        alignment: Alignment.topCenter,
                        child: AppTextStyle(
                          text: 'Filter',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        )),
                    10.height,
                    Container(
                      height: 1.h,
                      width: Get.width,
                      color: Colors.grey.shade300,
                    ),
                    5.height,
                    Visibility(
                      visible: !productsController.isFromSearch.value,
                      child: AppTextStyle(
                        text: 'Type',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.height,
                    Visibility(
                      visible: !productsController.isFromSearch.value,
                      child: Obx(() => ListView.builder(
                        shrinkWrap: true,
                        itemCount: Get.find<DashboardController>()
                            .typeList
                            .length,
                        itemBuilder: (context, index) {
                          final FilterType filterType =
                          Get.find<DashboardController>()
                              .typeList[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 0.h),
                            child: TextButton(
                              onPressed: () {
                                ///    for false/unselect selected value
                                if (productsController
                                    .selectedFilterTypeIndex
                                    .value ==
                                    index) {
                                  productsController
                                      .selectedFilterTypeName
                                      .value = '';
                                  productsController
                                      .selectedFilterTypeIndex
                                      .value = 10000;
                                  productsController
                                      .isFilterTypeSelected
                                      .value = false;
                                } else {
                                  ///    for true/ selected value
                                  productsController
                                      .selectedFilterTypeIndex
                                      .value = index;
                                  productsController
                                      .selectedFilterTypeName
                                      .value = filterType.value!;
                                  productsController
                                      .isFilterTypeSelected
                                      .value = true;
                                }
                              },
                              child: Row(
                                children: [
                                  Obx(() {
                                    if (productsController
                                        .selectedFilterTypeIndex
                                        .value ==
                                        index) {
                                      return SvgPicture.asset(
                                        Assets.icons.radioOnIcon,
                                        height: 16.h,
                                        width: 16.w,
                                        colorFilter:
                                        const ColorFilter.mode(
                                            ColorName.primaryColor,
                                            BlendMode.srcIn),
                                      );
                                    } else {
                                      return SvgPicture.asset(
                                        Assets.icons.redioOffIcon,
                                        height: 15.h,
                                        width: 15.w,
                                        colorFilter:
                                        const ColorFilter.mode(
                                            ColorName.black,
                                            BlendMode.srcIn),
                                      );
                                    }
                                  }),
                                  20.width,
                                  AppTextStyle(
                                    text: filterType.status!,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                    ),
                    10.height,

                    ///   for variation / Size selection         ///
                    Row(
                      children: [
                        AppTextStyle(
                          text: "${'Variants'.tr} :  ",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        Obx(
                              () => AppTextStyle(
                            text: productsController.selectedSizeName.value
                                .toString(),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorName.black,
                          ),
                        ),
                      ],
                    ),
                    10.height,
                    Obx(() {
                      return Wrap(
                        spacing: 10,
                        children: List.generate(
                          productAttributesController.sizeList.length,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                if (productsController
                                    .selectedSizeIndex.value ==
                                    index) {
                                  ///   For false /  UnSelected Size
                                  productsController
                                      .selectedFilterSizeID.value = 0;
                                  productsController
                                      .selectedSizeName.value = '';
                                  productsController
                                      .selectedSizeIndex.value = 10000;
                                } else {
                                  ///   For true /  Selected Size
                                  productsController
                                      .selectedSizeIndex.value = index;
                                  productsController
                                      .selectedFilterSizeID.value =
                                  productAttributesController
                                      .sizeList[productsController
                                      .selectedSizeIndex.value]
                                      .id!;
                                  productsController
                                      .selectedSizeName.value =
                                      productAttributesController
                                          .sizeList[productsController
                                          .selectedSizeIndex.value]
                                          .name
                                          .toString();
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                      color: productsController
                                          .selectedSizeIndex
                                          .value ==
                                          index
                                          ? ColorName.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                        color: productsController
                                            .selectedSizeIndex
                                            .value ==
                                            index
                                            ? Colors.transparent
                                            : Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(15.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(3.r),
                                    child: AppTextStyle(
                                      text: productAttributesController
                                          .sizeList[index].name
                                          .toString(),
                                      color: productsController
                                          .selectedSizeIndex
                                          .value ==
                                          index
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            );
                          },
                        ),
                      );
                    }),
                    10.height,

                    ///     for Color  selection            ////
                    Row(
                      children: [
                        AppTextStyle(
                          text: "${'Color'.tr} :  ",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        Obx(
                              () => AppTextStyle(
                            text: productsController
                                .selectedFilterColorName.value
                                .toString(),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorName.black,
                          ),
                        ),
                      ],
                    ),
                    10.height,
                    SizedBox(
                      height: 40.h,
                      width: Get.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productAttributesController.colorList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (productsController.selectedColorIndex.value == index) {
                                /// For false / UnSelected color
                                productsController.selectedFilterColorID.value = 0;
                                productsController.selectedFilterColorName.value = '';
                                productsController.selectedColorIndex.value = 10000;
                              } else {
                                /// For true / Selected Size
                                productsController.selectedColorIndex.value = index;
                                productsController.selectedFilterColorID.value =
                                productAttributesController.colorList[productsController.selectedColorIndex.value].id!;
                                productsController.selectedFilterColorName.value =
                                    productAttributesController.colorList[productsController.selectedColorIndex.value].name.toString();
                              }
                            },
                            child: Obx(() {
                              return Container(
                                height: 30.h,
                                width: 30.w,
                                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GetColorFromHex.getColor(
                                      hexColor: productAttributesController.colorList[index].colorCode.toString()),
                                  border: Border.all(
                                    color: ColorName.gray70,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 15,
                                  color: productsController.selectedColorIndex.value == index
                                      ? Colors.grey.shade400
                                      : Colors.transparent,
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),

                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        globalButton(
                          onTap: () {
                            ///    Reset filter onTap Button
                            productsController.resetAllFilterData();
                            if (productsController.isFromSearch.value) {
                              productsController.fetchSearchProduct(
                                  text: productsController
                                      .searchedText.value);
                              Get.back();
                            } else {
                              productsController.selectedFilterTypeName
                                  .value = productsController.initialType;
                              productsController.fetchProducts();
                              Get.back();
                            }
                          },
                          text: 'Reset',
                          width: 150.w,
                          shadowColor: Colors.transparent,
                          blurRadius: 0,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.grey, Colors.grey.shade400]),
                        ),
                        20.height,
                        globalButton(
                            onTap: () {
                              ///   Apply filter  onTap Button
                              if (productsController
                                  .selectedFilterSizeID.value ==
                                  0 &&
                                  productsController
                                      .selectedFilterColorID.value ==
                                      0 &&
                                  productsController
                                      .isFilterTypeSelected.value ==
                                      false) {
                                globalSnackBar(
                                    title: "Alert",
                                    message:
                                    'Please Select an filter option',
                                    durationInSeconds: 2);
                              } else {
                                if (productsController.isFromSearch.value) {
                                  productsController.isFiltered.value =
                                  true;
                                  productsController.fetchSearchProduct(
                                      text: productsController
                                          .searchedText.value);
                                  Get.back();
                                } else {
                                  productsController.isFiltered.value =
                                  true;
                                  productsController.fetchProducts();
                                  Get.back();
                                }
                              }
                            },
                            text: 'Apply',
                            shadowColor: Colors.transparent,
                            width: 150.w),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    ));
  }
}