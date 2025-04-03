import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

Widget text24Normal({
  String text = "", Color color = AppColors.primaryText}) {
   return Text(text,
     textAlign: TextAlign.center,
     style: TextStyle(
         color: color,
         fontSize: 24.sp,
         fontWeight: FontWeight.normal
     ),
   );
}

Widget text18Normal({
  String text = "", Color color = AppColors.primarySecondaryElementText}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: color,
        fontSize: 18.sp,
        fontWeight: FontWeight.normal
    ),
  );
}

Widget text16Normal({
  String text = "", Color color = AppColors.primarySecondaryElementText}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal
    ),
  );
}

Widget text14Normal({
  String text = "", Color color = AppColors.primaryThreeElementText}) {
  return Text(
    text,
    textAlign: TextAlign.start,
    style: TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.normal
    ),
  );
}

Widget textUnderline({
  String text = "Your Text",
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.primaryText,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.sp,
      ),
    ),
  );
}