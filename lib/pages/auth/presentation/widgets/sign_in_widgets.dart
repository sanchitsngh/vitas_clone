import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/common/widgets/popup_messages.dart';
import '../controllers/google_auth_controller.dart';
import '../providers/google_auth/google_auth_notifier.dart';

// thirdPartyLogin widget
Widget thirdPartyLogin(BuildContext context, WidgetRef ref) {
  final googleAuthController = GoogleAuthController(ref: ref, context: context);
  final googleState = ref.watch(googleAuthNotifierProvider);

  return Container(
    margin: EdgeInsets.only(left: 80.w, right: 80.w, top: 40.h, bottom: 20.h),
    child: Column(
      children: [
        if (googleState.isLoading)
          const CircularProgressIndicator(),
        if (googleState.errorMessage != null)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              googleState.errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _loginButton("google.png", () {
              if (!googleState.isLoading) {
                googleAuthController.handleGoogleSignIn();
              }
            }),
            _loginButton("apple.png", () {
              toastInfo("Feature coming soon", backgroundColor: Colors.cyan);
            }),
            _loginButton("facebook.png", () {
              toastInfo("Feature coming soon", backgroundColor: Colors.cyan);
            }),
          ],
        ),
      ],
    ),
  );
}

Widget _loginButton(String imagePath, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 40.h,
      height: 40.h,
      child: Image.asset("assets/icons/$imagePath"),
    ),
  );
}