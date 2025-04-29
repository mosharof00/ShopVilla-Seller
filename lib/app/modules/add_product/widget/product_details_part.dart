import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shop_villa_seller/app/modules/products/productDetails/widget/product_details.dart';
import 'package:shop_villa_seller/app/modules/products/productDetails/widget/show_product_image.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:html/parser.dart' as htmlparser;
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/not_search_items_found_widget.dart';
import '../../../models/product_details/product_details_model.dart';
import '../controllers/add_product_variation_controller.dart';

class ProductDetailsPart extends StatelessWidget {
  const ProductDetailsPart({
    super.key,
    required this.productDetails,
    required this.controller,
  });
  final ProductDetailsData productDetails;
  final AddProductVariationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Obx((){
        if(controller.isFetchProductDetailsLoading.value == 0){
          return   ProductImage(
            productIndex: productDetails,
          );
        }else {
          return NotSearchedItemFoundWidget(
            iconSvgPath: Assets.images.emptySearch,
            heightLogo: 100.h,
            widthLogo: 100.w,
            title: 'Empty Image',
            description: "No image have been added to this product yet. Please add variations.",
          );
        }
      }),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: AppTextStyle(
            text: productDetails.productName!,
            maxLines: 2,
            textAlign: TextAlign.start,
            color: ColorName.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        10.height,
        AppTextStyle(
          text: 'Product Details:',
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        5.height,
        ProductDetails(productDetails: productDetails),
        8.height,
        ReadMoreText(
          productDetails.productDescription == null
              ? ''
              : htmlparser.parse(productDetails.productDescription!)
                  .documentElement!
                  .text,
          trimMode: TrimMode.Line,
          trimLines: 2,
          colorClickableText: ColorName.primaryColor,
          trimCollapsedText: 'see more',
          trimExpandedText: 'see less',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          moreStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        10.height,
      ],
    );
  }
}
