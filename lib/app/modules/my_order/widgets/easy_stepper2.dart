import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa_seller/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/divider.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

class EasyStepperWidget2 extends StatelessWidget {
  const EasyStepperWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: ColorName.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: AppTextStyle(text: 'Delivery Status',
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,),
            ),
            10.height,
            divider(height: 1.h, width: Get.width, color: Colors.pink.shade50),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EasyStepper(
                    showTitle: false,
                    lineStyle: const LineStyle(
                      lineType: LineType.dotted,
                      unreachedLineColor: ColorName.gray70,
                      activeLineColor: ColorName.green,
                      finishedLineColor: ColorName.green,
                      lineThickness: 1.5,
                      lineSpace: 5,
                      lineLength: 60,
                      unreachedLineType: LineType.dashed,
                    ),
                    alignment: Alignment.centerLeft,
                    activeStep: controller.activeStep.value,
                    direction: Axis.vertical,
                    stepShape: StepShape.circle,
                    stepBorderRadius: 0,
                    borderThickness: 1,
                    stepRadius: 30,
                    finishedStepBorderType: BorderType.normal,
                    finishedStepBorderColor: Colors.green,
                    finishedStepTextColor: Colors.black,
                    finishedStepBackgroundColor: ColorName.green,
                    stepAnimationCurve: Curves.bounceIn,
                    activeStepIconColor: Colors.redAccent,
                    unreachedStepBackgroundColor: ColorName.gray70,
                    unreachedStepTextColor: ColorName.gray70,
                    unreachedStepBorderColor: ColorName.gray410,
                    unreachedStepBorderType: BorderType.dotted,
                    activeStepBorderColor: ColorName.green,
                    activeStepBackgroundColor: ColorName.green,
                    activeStepBorderType: BorderType.normal,
                    steps: [
                      EasyStep(
                        lineText: 'sdas',
                        icon: const Icon(Icons.access_time_filled),
                        customStep: controller.activeStep.value >= 1
                            ? LoadingAnimationWidget.beat(
                          size: 40,
                          color: ColorName.white,
                        )
                            : const Icon(
                          Icons.check_circle,
                          color: ColorName.white,
                        ),
                        customTitle: const Text(
                          'Dash 1',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: controller.activeStep.value >= 2
                            ? LoadingAnimationWidget.beat(
                          size: 40,
                          color: ColorName.white,
                        )
                            : const Icon(
                          Icons.check_circle,
                          color: ColorName.white,
                        ),
                        customTitle: const Text(
                          'Dash 2',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: controller.activeStep.value >= 3
                            ? LoadingAnimationWidget.beat(
                          size: 40,
                          color: ColorName.white,
                        )
                            : const Icon(
                          Icons.check_circle,
                          color: ColorName.white,
                        ),
                        customTitle: const Text(
                          'Dash 3',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: controller.activeStep.value >= 4
                            ? LoadingAnimationWidget.beat(
                          size: 40,
                          color: ColorName.white,
                        )
                            : const Icon(
                          Icons.check_circle,
                          color: ColorName.white,
                        ),
                        customTitle: const Text(
                          'Dash 4',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    onStepReached: (index) {
                      controller.activeStep.value = index;
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ...List.generate(4, (index) =>
                    //     Column(
                    //       children: [
                    //         20.height,
                    //         AppTextStyle(text: 'Order Has Arrived - May 1,2023',
                    //           fontSize: 14.sp,
                    //           fontWeight: FontWeight.w600,),
                    //         AppTextStyle(text: 'Order Has Arrived - May 1,2023',
                    //           fontSize: 12.sp,
                    //           fontWeight: FontWeight.w400,),
                    //         50.height,
                    //       ],
                    //     ),
                    // )

                  ],
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
