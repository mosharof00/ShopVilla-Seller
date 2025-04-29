import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/add_product/controllers/add_product_controller.dart';
import 'package:shop_villa_seller/global/awesome_alert_dialog.dart';
import 'package:shop_villa_seller/global/global_button.dart';
import 'package:shop_villa_seller/global/global_snackbar.dart';
import 'package:shop_villa_seller/global/loading_button.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/global_controllers/product_attributes_controller.dart';
import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';
import '../widget/product_details_part.dart';
import '../controllers/add_product_variation_controller.dart';
import '../widget/easy_stepper.dart';
import '../widget/view_variations.dart';

class AddProduct3View extends GetView<AddProductVariationController> {
  const AddProduct3View({super.key});

  @override
  Widget build(BuildContext context) {
    final addProductController = Get.put(AddProductController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        leading: IconButton(
          onPressed: () {
            addProductController.activeStep.value--;
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        title: appbarTitle(text: 'Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Obx(() {
                addProductController.activeStep.value;
                return const AddProductEasyStepper();
              }),
              ProductDetailsPart(
                productDetails: controller.product.value,
                controller: controller,
              ),
              10.height,
              ViewVariations(
                controller: controller,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            globalButton(
                onTap: () {
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
                text: 'Cancel',
                width: Get.width / 2.5),
            loadingButton(
                controller: controller.btnController,
                onTap: () {
                  if (controller.product.value.productvariations!.isEmpty) {
                    globalSnackBar(
                        title: 'Empty Variation',
                        message:
                            "No image have been added to this product yet. Please add variations.");
                    controller.btnController.stop();
                  } else {
                    controller.fetchUpdateProduct(
                        status: HelperUtils.productActiveStatus,
                        context: context);
                  }
                },
                text: 'Publish',
                width: Get.width / 2.5),
          ],
        ),
      ),
    );
  }
}
