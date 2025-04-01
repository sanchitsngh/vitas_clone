import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/pages/sign_in/sign_in_controller.dart';
import 'package:vitas_clone/pages/sign_in/sign_in_widgets.dart';
import '../../common/utils/app_colors.dart';
import '../../common/utils/global loader/global_loader.dart';
import '../../common/widgets/app_bar.dart';
import '../../common/widgets/app_textfields.dart';
import '../../common/widgets/buttons_widget.dart';
import '../../common/widgets/text_widgets.dart';
import 'notifier/sign_in_notifier.dart';

class SignIn extends ConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loader = ref.watch(appLoaderProvider);
    final signInProvider = ref.watch(signInNotifierProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          //appBar: buildAppBar(appBarTitle: "Login"),
          appBar: AppBar(
            title: Text("Login", style: TextStyle(color: Colors.black,)),
          ),
          backgroundColor: Colors.white,
          body:  loader == false ?  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top login buttons
                thirdPartyLogin(),
                // more login options message
                Center(child: text14Normal(text: "or use your email account to login")),
                SizedBox(height: 50.h,),
                // email text box
                appTextField(
                    text: "Email",
                    iconName: "assets/icons/user.png",
                    hintText: "Enter Email",
                    func: (value) => ref.read(signInNotifierProvider.notifier).onUserEmailChange(value)
                ),
                SizedBox(height: 20.h,),
                // password text box
                appTextField(
                    text: "Password",
                    iconName: "assets/icons/lock.png",
                    hintText: "Enter Password",
                    obscureText: true,
                    func: (value) => ref.read(signInNotifierProvider.notifier).onUserPasswordChange(value)
                ),
                // Forgot Text
                Container(
                  margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
                  child: textUnderline(text: "Forgot Password?")
                ),
                SizedBox(height: 50.h,),
                // app login button
                Center(child: appButton(buttonText: "Login", context: context, func: SignInController(ref : ref).handleSignIn)),
                SizedBox(height: 20.h,),
                // app register button
                Center(
                    child: appButton(
                        buttonText: "Register",
                        isLogin: false,
                        context: context,
                      func: () => Navigator.pushNamed(context, "Register")

                )),
                SizedBox(height: 20.h,)
              ],
            ),
          ) :
          Center(child: CircularProgressIndicator(
            color: AppColors.primaryElement,
            backgroundColor: Colors.blue,
          ),
          )
        ),
      ),
    );
  }
}
