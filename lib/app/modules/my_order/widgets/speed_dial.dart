import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa_seller/app/modules/my_order/controllers/my_order_controller.dart';
import '../../../../gen/colors.gen.dart';

class SpeedDialFloatingButton extends StatelessWidget {
  const SpeedDialFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    return SpeedDial(
      closeDialOnPop: false,
      mini: false,
      backgroundColor: ColorName.green,
      icon: MdiIcons.messageTextOutline,
      iconTheme: const IconThemeData(
          color: ColorName.white
      ),
      activeIcon: Icons.close,
      spacing: 5,
      openCloseDial: controller.isDialOpen,
      children: [
        SpeedDialChild(
          onTap: (){},
          label: 'Chat with Seller'.tr,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
          shape: const CircleBorder(),
          child: Container(
            height: 50.h,
            width: 50.w,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorName.green),
            child: IconButton(
              onPressed: (){},
              icon:  Icon(MdiIcons.storeEditOutline, color: ColorName.white,),
            ),
          ),
        ),
        SpeedDialChild(
          onTap: (){},
          label: 'Chat with CustomerCare'.tr,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
          shape: const CircleBorder(),
          child: Container(
            height: 50.h,
            width: 50.w,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorName.green),
            child: IconButton(
              onPressed: (){},
              icon:  Icon(MdiIcons.account, color: ColorName.white,),
            ),
          ),
        ),
      ],
    );
  }
}
