import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shop_villa_seller/global/shimmer_loading.dart';


class LoadingProductGridview extends StatelessWidget {
  const LoadingProductGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.all(8.0.r),
            child: shimmerLoadingWidget(
                height: 260.h,
                width: Get.width,
                borderRadius: 20.r
            ),
          );
        },
      ),
    );
  }
}
