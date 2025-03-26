import 'package:flutter/material.dart';
import 'package:vitas_clone/common/widgets/text_widgets.dart';
import '../utils/app_colors.dart';

AppBar buildAppBar({required String appBarTitle, bool showProfileIcon = true}) {
  return AppBar(
    //automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Container(
        color: Colors.grey.withOpacity(0.5),
        height: 1 ,
      ),
    ),
    centerTitle: true,
    title: text16Normal(text: appBarTitle, color: AppColors.primaryText),
  );
}