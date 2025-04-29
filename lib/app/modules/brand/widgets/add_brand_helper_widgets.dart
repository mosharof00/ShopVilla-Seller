import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/methods/get_image_url.dart';

Widget showImageFromFile(
    {required String image, required VoidCallback deleteOnTap}) {
  return customContainer(
    decorationImage: DecorationImage(
      fit: BoxFit.cover,
      image: FileImage(
        File(image),
      ),
    ),
    widget: Stack(children: [
      Positioned(
        top: 0.h,
        right: 0.w,
        child: IconButton(
          onPressed: deleteOnTap,
          icon: const Icon(
            Icons.delete,
            size: 25,
            color: ColorName.crimsonRed,
          ),
        ),
      ),
    ]),
  );
}

Widget showImageFromNetwork(
    {required String image, required VoidCallback deleteOnTap}) {
  return customContainer(
    decorationImage: DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(
        GetImageUrl.url(image),
      ),
    ),
    widget: Stack(children: [
      Positioned(
        top: 0.h,
        right: 0.w,
        child: IconButton(
          onPressed: deleteOnTap,
          icon: const Icon(
            Icons.delete,
            size: 25,
            color: ColorName.crimsonRed,
          ),
        ),
      ),
    ]),
  );
}

Widget customContainer(
    {required Widget widget, DecorationImage? decorationImage, Color? color}) {
  return Container(
    height: 100.h,
    width: 100.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: const Color(0xFFe9ecef),
        border: Border.all(
          color: color ?? Colors.transparent,
          width: 1,
        ),
        image: decorationImage),
    child: widget,
  );
}


Widget picPlaceholderContainer(
    {required Widget widget, DecorationImage? decorationImage, Color? color}) {

  return  Column(
    children: [
      DottedBorder(
        color: ColorName.gray410,
        strokeWidth: 1,
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: ColorName.white,
            image: decorationImage,
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
    ],
  );

}
