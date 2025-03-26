import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets/app_shadow.dart';
import '../../common/widgets/text_widgets.dart';

Widget appOnBoardingPage(
    PageController controller,
    {
      String imagePath = "assets/images/reading.png",
      String title = "",
      String subTitle = "",
      index = 0,
      required BuildContext context
    }) {
  return Column(
    children: [
      Image.asset(imagePath),
      Container(
        margin: EdgeInsets.all(16),
        child: text24Normal(text: title),
      ),
      Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: text16Normal(text: subTitle),
      ),
      _nextButton(index, controller, context)
    ],
  );
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: (){
      if(index < 3) {
        controller.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.linear
        );
      }
      else {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn()));
        Navigator.pushNamed(context, "SignIn");
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(top: 30.h, left: 25.w, right: 25.w),
      decoration: appBoxShadow(),
      child: Center(child: text16Normal(text: index < 3 ? "Next" : "Get Started", color: Colors.white)),
    ),
  );
}