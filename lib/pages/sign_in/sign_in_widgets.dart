import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget thirdPartyLogin() {
  return Container(
    margin: EdgeInsets.only(left: 80.w, right: 80.w, top: 40.h, bottom: 20.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _loginButton("google.png"),
        _loginButton("apple.png"),
        _loginButton("facebook.png"),
      ],
    ),
  );
}

Widget _loginButton(String imagePath) {
  return GestureDetector(
    onTap: () {

    },
    child: SizedBox(
      width: 40.h,
      height: 40.h,
      child: Image.asset("assets/icons/$imagePath"),
    ),
  );
}
