// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:shop_villa_seller/app/modules/dashboard/controllers/dashboard_controller.dart';
// import '../../../../../gen/assets.gen.dart';
// import '../../../../../gen/colors.gen.dart';
// import '../../../../../global/app_text_style_over_flow.dart';
// import '../../../../../global/shimmer_loading.dart';
// import '../../../../global/app_text_style.dart';
// import '../../../models/product_model/porduct_model_api.dart';
// import '../../../routes/app_pages.dart';
//
// class ProductsList extends StatelessWidget {
//   const ProductsList({super.key, this.height, this.width, this.imageHeight});
//   final double? height;
//   final double? width;
//   final double? imageHeight;
//   @override
//   Widget build(BuildContext context) {
//     final dashboardController = Get.find<DashboardController>();
//     return SizedBox(
//       height: height ?? 230.h,
//       width: Get.width,
//       child: Obx(() {
//         if (dashboardController.productList.isEmpty) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {
//           return ListView.builder(
//             // padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
//             scrollDirection: Axis.horizontal,
//             shrinkWrap: true,
//             itemCount: dashboardController.productList.length,
//             itemBuilder: (context, item) {
//               final Product product = dashboardController.productList[item];
//               return InkWell(
//                 onTap: () {
//                   Get.toNamed(
//                     Routes.PRODUCT_DETAILS,
//                     arguments: product,
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Material(
//                     elevation: 5,
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       width: width ?? 140.w,
//                       decoration: BoxDecoration(
//                         color: ColorName.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border(
//                             top: BorderSide(width: 7.w, color: ColorName.white),
//                             left:
//                                 BorderSide(width: 7.w, color: ColorName.white),
//                             right:
//                                 BorderSide(width: 7.w, color: ColorName.white)),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       })
//     );
//   }
// }
