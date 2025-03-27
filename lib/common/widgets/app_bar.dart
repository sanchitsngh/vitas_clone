import 'package:flutter/material.dart';
import 'package:vitas_clone/common/widgets/text_widgets.dart';
import '../utils/app_colors.dart';

AppBar buildAppBar({required String appBarTitle, 
bool showProfileIcon = true,
VoidCallback? onDrawerTap,
}) {
  return AppBar(
    //automaticallyImplyLeading: false,
    backgroundColor:const Color.fromARGB(255, 63, 14, 90),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Container(
        color: Colors.grey.withOpacity(0.5),
        height: 1 ,
      ),
    ),
    centerTitle: true,
    title: text16Normal(text: appBarTitle, color: AppColors.primaryBackground),

    leading: GestureDetector(
        onTap: onDrawerTap, // Trigger the onDrawerTap function passed from Navbar
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 63, 14, 90),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.png', // Your logo path
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
  );
}