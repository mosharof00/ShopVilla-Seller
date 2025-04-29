import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/loading_button.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import 'package:shop_villa_seller/helper/roundedLeading.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../global/not_search_items_found_widget.dart';
import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        automaticallyImplyLeading: true,
        title: appbarTitle(text: 'Supplier'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return loadingAnimationWidget();
        } else if (controller.supplierList.isEmpty) {
          return NotSearchedItemFoundWidget(
            iconSvgPath: Assets.images.emptySearch,
            heightLogo: 150.h,
            widthLogo: 150.w,
            title: 'Empty Supplier',
            description: "No Supplier have been added yet.",
          );
        } else {
          return ListView.builder(
            itemCount: controller.supplierList.length,
            itemBuilder: (context, index) {
              final supplier = controller.supplierList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTileCard(
                  elevation: 3,
                  key: controller.keys[index],
                  baseColor: ColorName.white,
                  expandedColor: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  animateTrailing: true,
                  leading: roundedLeading(index: index),
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextStyle(
                      text: supplier.supplierName!,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextStyle(
                      text: supplier.supplierEmail!,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  children: [
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    //   child: Container(
                    //     height: 70.h,
                    //     width: Get.width,
                    //     decoration: BoxDecoration(
                    //         color: ColorName.primaryColor.withOpacity(0.3),
                    //         borderRadius: BorderRadius.circular(15.r)),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 8.0, vertical: 8),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           rowContainerLabelValue(
                    //             title: 'Total',
                    //             value: supplier.supplierTotalAmount.toString(),
                    //             containerColor: ColorName.primaryColor,
                    //             titleFontColor: ColorName.white,
                    //             valueFontColor: ColorName.white,
                    //             titleFontSize: 11.sp,
                    //             valueFontSize: 10.sp,
                    //           ),
                    //           rowContainerLabelValue(
                    //             title: 'Paid',
                    //             value: supplier.supplierPaidAmount.toString(),
                    //             containerColor: ColorName.primaryColor,
                    //             titleFontColor: ColorName.white,
                    //             valueFontColor: ColorName.white,
                    //             titleFontSize: 11.sp,
                    //             valueFontSize: 10.sp,
                    //           ),
                    //           rowContainerLabelValue(
                    //             title: 'Due',
                    //             value: supplier.supplierDueAmount.toString(),
                    //             containerColor: ColorName.primaryColor,
                    //             titleFontColor: ColorName.white,
                    //             valueFontColor: ColorName.white,
                    //             titleFontSize: 11.sp,
                    //             valueFontSize: 10.sp,
                    //           ),
                    //           rowContainerLabelValue(
                    //             title: 'Partial',
                    //             value: supplier.supplierPartialAmount.toString(),
                    //             containerColor: ColorName.primaryColor,
                    //             titleFontColor: ColorName.white,
                    //             valueFontColor: ColorName.white,
                    //             titleFontSize: 11.sp,
                    //             valueFontSize: 10.sp,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // 10.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          Icon(MdiIcons.domain,
                              color: Colors.blueAccent, size: 18),
                          10.width,
                          AppTextStyle(
                            text: index == 1
                                ? 'Bata'
                                : index == 2
                                ? 'Apex'
                                : index == 3
                                ? 'Artisan'
                                : 'Yellow',
                            fontSize: 14.sp,
                            color: ColorName.gray410,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.phone,
                              color: Colors.blueAccent, size: 18),
                          10.width,
                          AppTextStyle(
                            text: supplier.supplierPhone.toString(),
                            fontSize: 14.sp,
                            color: ColorName.gray410,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.redAccent, size: 18),
                          10.width,
                          SizedBox(
                            width: 290.w,
                            child:  ReadMoreText(
                              supplier.supplierAddress!,
                              trimMode: TrimMode.Line,
                              trimLines: 2,
                              colorClickableText: ColorName.primaryColor,
                              trimCollapsedText: 'see more',
                              trimExpandedText: 'see less',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: ColorName.gray410),
                              ),
                              moreStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            // AppTextStyleOverFlow(
                            //   text: supplier.supplierAddress!,
                            //   fontSize: 14.sp,
                            //   maxLines: 3,
                            //   color: ColorName.gray410,
                            //   fontWeight: FontWeight.w500,
                            //   textAlign: TextAlign.start,
                            // ),
                          ),
                        ],
                      ),
                    ),
                    OverflowBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.call, color: Colors.green),
                          onPressed: () async {
                            makePhoneCall(supplier.supplierPhone.toString());
                          },
                        ),
                        IconButton(
                          icon:
                          const Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () async {
                            controller.isUpdateMode.value = true;
                            controller.setSupplierUpdate(supplier);
                            showAddSupplierSheet(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            controller.deleteSupplier(id: supplier.id);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorName.primaryColor,
        onPressed: () {
          controller.isUpdateMode.value = false;
          controller.clear();
          controller.btnController.reset();
          showAddSupplierSheet(context);
        },
        child: const Icon(Icons.add, color: ColorName.white),
      ),
    );
  }

  void showAddSupplierSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Allow BottomSheet to resize with keyboard
      builder: (BuildContext context) {
        return Obx(() {
          return Padding(
            // Add a padding that considers the keyboard height using MediaQuery
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  20, // Adjust the bottom padding
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Only take the necessary space
                children: [
                  AppTextStyle(
                    text: controller.isUpdateMode.value
                        ? 'Update Supplier'
                        : 'Add New Supplier',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  20.height,
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      labelText: 'Supplier Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r)),
                    ),
                  ),
                  10.height,
                  TextField(
                    controller: controller.phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r)),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  10.height,
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  10.height,
                  TextField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r)),
                    ),
                  ),
                  20.height,
                  SizedBox(
                    width: 250.w,
                    child: Obx(() {
                      return loadingButton(
                        onTap: () {
                          if (controller.isUpdateMode.value) {
                            controller.updateSupplier(
                              name: controller.nameController.text,
                              phone: controller.phoneController.text,
                              email: controller.emailController.text,
                              address: controller.addressController.text,
                              id: controller.supplierID.value.toString(),
                            );
                          } else {
                            controller.addSupplier(
                              name: controller.nameController.text,
                              phone: controller.phoneController.text,
                              email: controller.emailController.text,
                              address: controller.addressController.text,
                            );
                          }
                        },
                        controller: controller.btnController,
                        text: controller.isUpdateMode.value
                            ? 'Update Supplier'
                            : 'Add Supplier',
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  // Function to make phone call
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
    try {
      await launchUrl(phoneUri);
    } catch (error) {
      throw ("Cannot dial");
    }
  }
}

Widget rowContainerLabelValue({
  double? containerWidth,
  double? containerHeight,
  Color? containerColor,
  Color? containerBorderColor,
  required String title,
  required String value,
  double? titleFontSize,
  double? valueFontSize,
  FontWeight? titleFontWeight,
  FontWeight? valueFontWeight,
  Color? titleFontColor,
  Color? valueFontColor,
}) {
  return SizedBox(
    width: containerWidth ?? 0.20.sw,
    height: containerHeight,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: containerBorderColor ?? ColorName.gray70),
        color: containerColor ?? ColorName.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextStyle(
            text: title,
            fontSize: titleFontSize ?? 12.sp,
            fontWeight: titleFontWeight ?? FontWeight.w600,
            color: titleFontColor,
          ),
          3.height,
          AppTextStyle(
            text: value,
            fontSize: valueFontSize ?? 12.sp,
            fontWeight: valueFontWeight ?? FontWeight.w600,
            color: valueFontColor,
          ),
        ],
      ),
    ),
  );
}