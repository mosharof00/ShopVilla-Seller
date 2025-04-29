import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackCircle extends StatelessWidget {
  const StackCircle({super.key, this.top, this.bottom, this.left, this.right});
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      right: right,
      left: left,
      child: Container(
        height: 200.h,
        width: 200.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }
}
