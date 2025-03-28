import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastInfo(String message, {Color backgroundColor = Colors.redAccent, Color textColor = Colors.white}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.sp
  );
}