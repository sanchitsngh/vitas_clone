import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/common/widgets/text_widgets.dart';
import '../utils/app_colors.dart';
import 'app_shadow.dart';

Widget appButton({
  double width = 325,
  double height = 50,
  String buttonText = "",
  bool isLogin = true,
  BuildContext? context,
  void Function()? func,
}) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: width.w,
      height: height.h,
      decoration: appBoxShadow(color: isLogin ? AppColors.primaryElement : Colors.white),
      child: Center(child: text16Normal(text: buttonText, color: isLogin ? AppColors.primaryBackground : Colors.black)),
    ),
  );
}