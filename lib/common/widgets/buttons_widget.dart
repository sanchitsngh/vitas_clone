import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/common/widgets/text_widgets.dart';
import '../../core/constants/app_colors.dart';
import 'app_shadow.dart';

Widget appButton({
  double width = 325,
  double height = 50,
  String buttonText = "",
  bool isLogin = true,
  BuildContext? context,
  void Function()? func,
  Color? buttonColor,  // Added buttonColor parameter
  Color? textColor,   // Added textColor parameter
}) {
  // Determine if the button should be enabled
  final bool isEnabled = func != null;

  return GestureDetector(
    onTap: isEnabled ? func : null,  // Disable tap when func is null
    child: Container(
      width: width.w,
      height: height.h,
      decoration: appBoxShadow(
        color: buttonColor ??
            (isEnabled
                ? (isLogin ? AppColors.primaryElement : Colors.white)
                : Colors.grey),  // Use grey when disabled
      ),
      child: Center(
        child: text16Normal(
          text: buttonText,
          color: textColor ??
              (isEnabled
                  ? (isLogin ? AppColors.primaryBackground : Colors.black)
                  : Colors.grey[600]!),  // Grey text when disabled
        ),
      ),
    ),
  );
}