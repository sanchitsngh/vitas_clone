import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/app_textfields.dart';
import '../../../../common/widgets/buttons_widget.dart';
import '../../../../common/widgets/text_widgets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/forgot_password_controller.dart';
import '../providers/forgot_password/forgot_password_notifier.dart';

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordNotifierProvider);
    final controller = ForgotPasswordController(ref: ref, context: context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            text14Normal(text: "Enter your email to receive a password reset link"),
            SizedBox(height: 30.h),
            AppTextField(
              text: "Email",
              hintText: "Enter your email",
              ref: ref,
              func: controller.handleEmailUpdate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }
                if (!Validators.isValidEmail(value)) {
                  return "Invalid email format";
                }
                return null;
              },
            ),
            if (state.emailError != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  state.emailError!,
                  style: TextStyle(color: Colors.red, fontSize: 12.sp),
                ),
              ),
            SizedBox(height: 30.h),
            appButton(
              buttonText: "Send Reset Link",
              context: context,
              func: state.isLoading ? null : controller.handleSendResetEmail,
            ),
            if (state.isLoading)
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primaryElement),
                ),
              ),
          ],
        ),
      ),
    );
  }
}