import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/core/utils/validators.dart';
import 'package:vitas_clone/pages/auth/presentation/controllers/sign_in_controller.dart';
import 'package:vitas_clone/pages/auth/presentation/widgets/sign_in_widgets.dart';
import '../../../../common/utils/global loader/provider/global_loader.dart';
import '../../../../common/widgets/app_textfields.dart';
import '../../../../common/widgets/buttons_widget.dart';
import '../../../../common/widgets/text_widgets.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/sign_in/sign_in_notifier.dart';
import '../providers/google_auth/google_auth_notifier.dart';

class SignIn extends ConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loader = ref.watch(appLoaderProvider);
    final signInState = ref.watch(signInNotifierProvider);
    final googleAuthState = ref.watch(googleAuthNotifierProvider);
    final isFormValid = signInState.isValid;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Login", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: loader
              ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryElement,
              backgroundColor: Colors.blue,
            ),
          )
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                thirdPartyLogin(context, ref), // Updated with params
                Center(
                  child: text14Normal(
                      text: "or use your email account to login"),
                ),
                SizedBox(height: 50.h),
                AppTextField(
                  text: "Email",
                  hintText: "Enter Email",
                  ref: ref,
                  func: (value) {
                    ref
                        .read(signInNotifierProvider.notifier)
                        .onUserEmailChange(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!Validators.isValidEmail(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  text: "Password",
                  hintText: "Enter Password",
                  obscureText: true,
                  uniqueId: "sign_in_password",
                  ref: ref,
                  func: (value) {
                    ref
                        .read(signInNotifierProvider.notifier)
                        .onUserPasswordChange(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
                  child: textUnderline(
                    text: "Forgot Password?",
                    onTap: () => Navigator.pushNamed(context, "ForgotPassword")
                  ),
                ),
                SizedBox(height: 50.h),
                Center(
                  child: appButton(
                    buttonText: "Login",
                    context: context,
                    buttonColor:
                    isFormValid ? null : Colors.grey[400],
                    textColor: isFormValid ? null : Colors.white,
                    func: isFormValid
                        ? () => SignInController(
                        ref: ref, context: context)
                        .handleSignIn()
                        : null,
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: appButton(
                    buttonText: "Register",
                    isLogin: false,
                    context: context,
                    func: () =>
                        Navigator.pushNamed(context, "Register"),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}