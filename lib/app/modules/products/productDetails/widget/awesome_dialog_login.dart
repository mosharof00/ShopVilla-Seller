import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../../../gen/colors.gen.dart';

class DialogUtils {
  static void showWarningDialog({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onOkPressed,
    String btnOkText = 'Login',
    String btnCancelText = 'Cancel',
    bool dismissOnBackKeyPress = false,
    bool dismissOnTouchOutside = false,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: title,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
      ),
      desc: description,
      descTextStyle: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dismissOnTouchOutside: dismissOnTouchOutside,
      btnCancelColor: ColorName.gray410,
      btnOkColor: ColorName.primaryColor,
      btnOkText: btnOkText.tr,
      btnCancelText: btnCancelText.tr,
      btnOkOnPress: onOkPressed,
    ).show();
  }
}
