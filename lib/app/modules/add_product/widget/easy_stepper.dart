import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa_seller/app/modules/add_product/controllers/add_product_controller.dart';
import '../../../../../gen/colors.gen.dart';

class AddProductEasyStepper extends StatelessWidget {
  const AddProductEasyStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddProductController());
    return EasyStepper(
        showTitle: false,
        lineStyle: const LineStyle(
          lineType: LineType.dotted,
          unreachedLineColor: ColorName.gray70,
          activeLineColor: ColorName.primaryColor,
          finishedLineColor: ColorName.primaryColor,
          lineThickness: 1.5,
          lineSpace: 3,
          unreachedLineType: LineType.dotted,
        ),
        alignment: Alignment.center,
        activeStep: controller.activeStep.value,
        // direction: Axis.horizontal,
        stepShape: StepShape.circle,
        stepBorderRadius: 30.sp,
        borderThickness: 2,
        stepRadius: 25.sp,
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
              MdiIcons.numeric1CircleOutline,
              color: ColorName.white,
            ),
          ),
          EasyStep(
            icon: Icon(
              MdiIcons.numeric2CircleOutline,
              color: ColorName.white,
            ),
          ),
          EasyStep(
            icon: Icon(
              MdiIcons.numeric3CircleOutline,
              color: ColorName.white,
            ),
          ),
        ],
        onStepReached: (index) {
          controller.activeStep.value = index;
        });
  }
}
