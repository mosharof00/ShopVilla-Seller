import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../gen/colors.gen.dart';
import 'app_text_style.dart';

Widget badgeWidget({
  int? count,
  Function()? onTap,
  required Widget icon,
}) {
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: -5, end: 4),
    showBadge: true,
    ignorePointer: true,
    onTap: onTap,
    badgeContent: count != 0
        ? AppTextStyle(
            text: count.toString(),
            color: ColorName.white,
          )
        : const SizedBox.shrink(),
    badgeAnimation: const badges.BadgeAnimation.slide(
      animationDuration: Duration(seconds: 1),
      colorChangeAnimationDuration: Duration(seconds: 1),
      loopAnimation: false,
      curve: Curves.fastOutSlowIn,
      colorChangeAnimationCurve: Curves.easeInCubic,
    ),
    badgeStyle: badges.BadgeStyle(
      shape: badges.BadgeShape.circle,
      badgeColor: count != 0 ? Colors.blue : Colors.transparent,
      padding: const EdgeInsets.all(5),
      borderRadius: BorderRadius.circular(4),
      badgeGradient: const badges.BadgeGradient.linear(
        colors: [ColorName.gradientStart, ColorName.gradientEnd],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      elevation: 0,
    ),
    child: IconButton(
      onPressed: onTap,
      icon: icon ??
          Icon(
            MdiIcons.bellOutline,
            size: 30,
          ),
    ),
  );
}
