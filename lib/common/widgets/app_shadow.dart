import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

BoxDecoration appBoxShadow({
  Color color = AppColors.primaryElement,
  double radius = 15,
  double sR = 0.5,
  double bR = 5,
  Border? border,  // Added border parameter
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    border: border,  // Added border property
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryThreeElementText,
        spreadRadius: sR,
        blurRadius: bR,
        offset: Offset(0, 1),
      )
    ],
  );
}

BoxDecoration appBoxDecorationTextField({
  Color color = AppColors.primaryBackground,
  double radius = 15,
  Color borderColor = AppColors.primaryThreeElementText,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: borderColor),
  );
}