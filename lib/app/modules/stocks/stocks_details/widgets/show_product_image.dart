import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/models/product_model/porduct_model_api.dart';
import 'package:shop_villa_seller/app/modules/stocks/stocks_details/controllers/stocks_details_controller.dart';
import 'package:shop_villa_seller/global/methods/get_image_url.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/shimmer_loading.dart';
import '../../../../repository/api_endpoint.dart';

class ShowProductImage extends StatelessWidget {
  const ShowProductImage({super.key, required this.product});
  final ProductData product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StocksDetailsController());
    final height = 35.h;
    final width = 35.w;
    return SizedBox(
      height: 300.h,
      width: Get.width,
      child: Stack(
        children: [
          Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CachedNetworkImage(
                imageUrl: GetImageUrl.url(product
                    .productvariations![controller.selectedImage.value].image!),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image:
                        DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    shimmerLoadingWidget(height: Get.height, width: Get.width),
                errorWidget: (context, url, error) => Image.asset(
                  fit: BoxFit.cover,
                  Assets.images.phoneimage.path,
                  width: Get.width,
                ),
              ),
            ),
          ),
          ...List.generate(
            product.productvariations!.length,
            (index) {
              return Positioned(
                left: 5,
                bottom: 80 + (index * 50),
                child: GestureDetector(
                  onTap: () {
                    controller.selectedImage.value = index;
                  },
                  child: Obx(
                    () => SizedBox(
                      height: height,
                      width: width,
                      child: Material(
                        elevation:
                            controller.selectedImage.value == index ? 5 : 0,
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                  color: controller.selectedImage.value == index
                                      ? Colors.amber
                                      : ColorName.gray70),
                              boxShadow: controller.selectedImage.value == index
                                  ? [
                                      const BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                        blurRadius: 3,
                                      ),
                                    ]
                                  : []),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CachedNetworkImage(
                              imageUrl:
                                  GetImageUrl.url(product.productvariations![index].image!),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill),
                                ),
                              ),
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  shimmerLoadingWidget(
                                      height: 300, width: Get.width),
                              errorWidget: (context, url, error) => Image.asset(
                                Assets.images.phoneimage.path,
                                width: Get.width,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
