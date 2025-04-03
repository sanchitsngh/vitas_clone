import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/core/utils/validators.dart';
import 'package:vitas_clone/pages/auth/presentation/controllers/sign_up_controller.dart';
import '../../../../common/utils/global loader/provider/global_loader.dart';
import '../../../../common/widgets/app_textfields.dart';
import '../../../../common/widgets/buttons_widget.dart';
import '../../../../common/widgets/text_widgets.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/sign_up/signup_notifier.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(appLoaderProvider);
    final registerState = ref.watch(registerNotifierProvider);
    final controller = SignUpController(ref: ref);
    final isFormValid = controller.isFormValid();

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Register", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: loader == false
              ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(child: text14Normal(text: "Enter your details below & free sign up")),
                SizedBox(height: 50.h),
                AppTextField(
                  text: "Username",
                  hintText: "Enter Username",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Image.asset(
                      "assets/icons/user.png",
                      width: 20.w,
                      height: 20.h,
                      color: Colors.grey,
                    ),
                  ),
                  ref: ref,
                  func: (value) => ref.read(registerNotifierProvider.notifier).onUserNameChange(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username is required";
                    }
                    if (!Validators.isValidName(value)) {
                      return "Only letters, digits (1-9), and special symbols \$, @, _ are allowed";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  text: "Email",
                  hintText: "Enter Email",
                  ref: ref,
                  func: (value) => ref.read(registerNotifierProvider.notifier).onUserEmailChange(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!Validators.isValidEmail(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  text: "Password",
                  hintText: "Enter Password",
                  obscureText: true,
                  uniqueId: "sign_up_password",
                  ref: ref,
                  func: (value) => ref.read(registerNotifierProvider.notifier).onUserPasswordChange(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (!Validators.isValidPassword(value)) {
                      return "Password must be at least 8 characters long, contain a number, and an uppercase letter";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  text: "Confirm Password",
                  hintText: "Confirm Password",
                  obscureText: true,
                  uniqueId: "sign_up_confirm_password",
                  ref: ref,
                  func: (value) => ref.read(registerNotifierProvider.notifier).onUserConfirmPasswordChange(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    }
                    if (value != registerState.password) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
                  child: text14Normal(
                    text: "By creating an account you have to agree with our terms and conditions.",
                  ),
                ),
                SizedBox(height: 50.h),
                Center(
                  child: appButton(
                    buttonText: "Register",
                    context: context,
                    buttonColor: isFormValid ? null : Colors.grey[400],
                    textColor: isFormValid ? null : Colors.white,
                    func: isFormValid
                        ? () => SignUpController(ref: ref).handleSignUp()
                        : null,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          )
              : Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryElement,
              backgroundColor: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}