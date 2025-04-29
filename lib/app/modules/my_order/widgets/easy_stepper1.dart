import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa_seller/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

class EasyStepperWidget1 extends StatelessWidget {
  const EasyStepperWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    return Container(
      decoration: BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          10.height,
          // IconStepper(
          //   icons: [
          //     Icon(
          //       MdiIcons.packageVariantClosed,
          //       color: ColorName.white,
          //     ),
          //     Icon(
          //       MdiIcons.truckOutline,
          //       color: ColorName.white,
          //     ),
          //     Icon(
          //       MdiIcons.packageVariantClosedCheck,
          //       color: ColorName.white,
          //     ),
          //     Icon(
          //       MdiIcons.packageVariant,
          //       color: ColorName.white,
          //     ),
          //   ],
          //   stepReachedAnimationEffect: Curves.bounceOut,
          //   activeStep: myOrderController.activeStep.value,
          //   stepColor: ColorName.gray70,
          //   activeStepColor: ColorName.green,
          //   activeStepBorderColor: ColorName.green,
          //   activeStepBorderWidth: 1,
          //   lineColor: ColorName.green,
          //   enableNextPreviousButtons: false,
          //   onStepReached: (index) {
          //     myOrderController.activeStep.value = index;
          //   },
          // ),
          Obx(() {
            controller.activeStep.value;
            return EasyStepper(
                showTitle: false,
                lineStyle: const LineStyle(
                  lineType: LineType.dotted,
                  unreachedLineColor: ColorName.gray70,
                  activeLineColor: ColorName.green,
                  finishedLineColor: ColorName.green,
                  lineThickness: 1.5,
                  lineSpace: 3,
                  unreachedLineType: LineType.dotted,
                ),
                alignment: Alignment.center,
                activeStep: controller.activeStep.value,
                // direction: Axis.horizontal,
                stepShape: StepShape.circle,
                stepBorderRadius: 32,
                borderThickness: 2,
                stepRadius: 28,
                finishedStepBorderType: BorderType.dotted,
                finishedStepBorderColor: Colors.grey,
                finishedStepTextColor: Colors.black,
                finishedStepBackgroundColor: ColorName.green,
                stepAnimationCurve: Curves.bounceInOut,
                activeStepIconColor: Colors.white,
                unreachedStepBackgroundColor: ColorName.gray70,
                unreachedStepTextColor: ColorName.gray70,
                unreachedStepBorderColor: ColorName.gray70,
                activeStepBorderColor: ColorName.green,
                activeStepBackgroundColor: ColorName.green,
                activeStepBorderType: BorderType.normal,
                steps: [
                  EasyStep(
                    icon: Icon(
                      MdiIcons.packageVariantClosed,
                      color: ColorName.white,
                    ),
                  ),
                  EasyStep(
                    icon: Icon(
                      MdiIcons.truckOutline,
                      color: ColorName.white,
                    ),
                  ),
                  EasyStep(
                    icon: Icon(
                      MdiIcons.packageVariantClosedCheck,
                      color: ColorName.white,
                    ),
                  ),
                  EasyStep(
                    icon: Icon(
                      MdiIcons.packageVariant,
                      color: ColorName.white,
                    ),
                  ),
                ],
                onStepReached: (index) {
                  controller.activeStep.value = index;
                });
          }),
          AppTextStyle(
            text: 'Order has Arrived',
            fontSize: 14.sp,
          ),
          5.height,
        ],
      ),
    );
  }
}
