import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/pages/sign_up/sign_up_controller.dart';
import '../../common/utils/app_colors.dart';
import '../../common/utils/global loader/global_loader.dart';
import '../../common/widgets/app_bar.dart';
import '../../common/widgets/app_textfields.dart';
import '../../common/widgets/buttons_widget.dart';
import '../../common/widgets/text_widgets.dart';
import 'notifier/signup_notifier.dart';

class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loader = ref.watch(appLoaderProvider);
    final regProvider = ref.watch(registerNotifierProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppBar(appBarTitle: "Register"),
            backgroundColor: Colors.white,
            body: loader == false ?  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  // signup message
                  Center(child: text14Normal(text: "Enter your details below & free sign up")),
                  SizedBox(height: 50.h,),
                  // username text box
                  appTextField(
                      text: "Username",
                      iconName: "assets/icons/user.png",
                      hintText: "Enter Username",
                      func: (value) => ref.read(registerNotifierProvider.notifier).onUserNameChange(value)
                  ),
                  SizedBox(height: 20.h,),
                  // email text box
                  appTextField(
                      text: "Email",
                      iconName: "assets/icons/user.png",
                      hintText: "Enter Email",
                      func: (value) => ref.read(registerNotifierProvider.notifier).onUserEmailChange(value)
                  ),
                  SizedBox(height: 20.h,),
                  // password text box
                  appTextField(
                      text: "Password",
                      iconName: "assets/icons/lock.png",
                      hintText: "Enter Password",
                      obscureText: true,
                      func: (value) => ref.read(registerNotifierProvider.notifier).onUserPasswordChange(value)
                  ),
                  SizedBox(height: 20.h,),
                  //confirm password
                  appTextField(
                      text: "Confirm Password",
                      iconName: "assets/icons/lock.png",
                      hintText: "Confirm Password",
                      obscureText: true,
                      func: (value) => ref.read(registerNotifierProvider.notifier).onUserConfirmPasswordChange(value)
                  ),
                  // Terms and conditions text
                  Container(
                      margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
                      child: text14Normal(text: "By creating an account you have to agree with our terms and conditions.")
                  ),
                  SizedBox(height: 50.h,),
                  // app signup button
                  Center(child: appButton(buttonText: "Register", context: context, func: SignUpController(ref : ref).handleSignUp)),
                  SizedBox(height: 20.h,),

                ],
              ),
            ) : Center(child: CircularProgressIndicator(
              color: AppColors.primaryElement,
              backgroundColor: Colors.blue,
            ))
        ),
      ),
    );
  }
}
