import 'package:flutter/cupertino.dart';
import '../gen/colors.gen.dart';

Widget divider({required double height,required double width,Color? color}  ){
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: Container(
      height: height,
      width: width,
      color: color ?? ColorName.gray70,
    ),
  );
}