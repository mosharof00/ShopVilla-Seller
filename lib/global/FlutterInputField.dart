import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';

class FlutterInputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function onChange;
  final Function onDone;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color borderColor;
  final TextEditingController? textFieldController;
  final Function? suffixTap;
  final Function? validateTextField;
  final Color? filledColor;
  final bool isSecure;
  final int lineHeight;
  final double labelFontSize;
  final double hintFontSize;

  const FlutterInputField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.onChange,
    required this.onDone,
    this.prefixWidget,
    this.suffixWidget,
    this.borderColor = Colors.blue,
    this.textFieldController,
    this.suffixTap,
    this.validateTextField,
    this.filledColor = Colors.lightBlue,
    this.isSecure = false,
    this.lineHeight = 1,
    this.labelFontSize = 16,
    this.hintFontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      obscureText: isSecure,
      maxLines: lineHeight,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        errorStyle: const TextStyle(
          fontSize: 16,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        filled: true,
        fillColor: filledColor ?? const Color(0xFFe9ecef),
        hintText: hintText,
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
        labelStyle: TextStyle(
          fontSize: labelFontSize,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Color(0xFFadb5bd),
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Color(0xFFadb5bd),
            width: 0,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Color(0xFFadb5bd),
            width: 0,
          ),
        ),
      ),
      onChanged: (String str) {
        onChange(str);
      },
      validator: (String? value) {
        return validateTextField!(value);
      },
      onEditingComplete: () {
        onDone();
      },
    );
  }
}
