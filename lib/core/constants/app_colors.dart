import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {

  /// white background
  static const Color primaryBackground = Color.fromARGB(255, 255, 255, 255);
  /// grey background
  static const Color primarySecondaryBackground = Color.fromARGB(255, 247, 247, 249);
  /// main widget color blue
  static const Color primaryElement = Color.fromARGB(255, 61, 61, 216);
  /// main text color black
  static const Color primaryText = Color.fromARGB(255, 0, 0, 0);
  // video background color
  static const Color primary_bg = Color.fromARGB(210, 32, 47, 62);
  /// main widget text color white
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);
  // main widget text color grey
  static const Color primarySecondaryElementText = Color.fromARGB(255, 102, 102, 102);
  // main widget third color grey
  static const Color primaryThreeElementText = Color.fromARGB(255, 170, 170, 170);

  static const Color primaryFourElementText = Color.fromARGB(255, 204, 204, 204);
  //state color
  static const Color primaryElementStatus = Color.fromARGB(255, 88, 174, 127);

  static const Color primaryElementBg = Color.fromARGB(255, 238, 121, 99);

}

Color parseHex(String hexColor) {
  return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
}

const backgroundWhite = Color(0XFFFBFDFF);
const grey6 = Color(0XFF3F4A56);
const grey5 = Color(0XFF667587);
const grey4 = Color.fromRGBO(128, 145, 165, 1);
const grey2 = Color(0XFFDFE6EE);
const colorDividerStrong = Color(0XFFDFE6EE);
const colorDivider = Color(0XFFF3F7FA);
const colorDividerPurple = Color(0xFF7B54A0);
const shadowColorLowElevation = Color.fromRGBO(176, 186, 197, .38);
const shadowColorHighElevation = Color.fromRGBO(102, 117, 135, .40);

MaterialColor colorPurple = MaterialColor(0xFF4E288E, purple);
MaterialColor colorGrayscale = MaterialColor(0xFF4E288E, grayscale);
MaterialColor colorYellow = MaterialColor(0xFF4E288E, yellow);
MaterialColor colorOrange = MaterialColor(0xFF4E288E, orange);
MaterialColor colorRed = MaterialColor(0xFF4E288E, red);
MaterialColor colorGreen = MaterialColor(0xFF4E288E, green);
MaterialColor colorSea = MaterialColor(0xFF4E288E, sea);
MaterialColor colorBlue = MaterialColor(0xFF4E288E, blue);
MaterialColor colorSky = MaterialColor(0xFF4E288E, sky);

const Map<int, Color> purple = {
  50: Color.fromRGBO(234, 229, 241, 1),
  100: Color.fromRGBO(202, 191, 221, 1),
  200: Color.fromRGBO(167, 148, 199, 1),
  300: Color.fromRGBO(134, 125, 227, 1), // Primary Purple
  400: Color.fromRGBO(105, 96, 193, 1), // Secondary Purple
  500: Color.fromRGBO(78, 40, 142, 1), // Brand Purple
  600: Color.fromRGBO(71, 36, 134, 1),
  700: Color.fromRGBO(61, 30, 123, 1),
  800: Color.fromRGBO(53, 24, 113, 1),
  900: Color.fromRGBO(37, 15, 95, 1),
};

const Map<int, Color> yellow = {
  50: Color.fromRGBO(254, 246, 231, 1),
  100: Color.fromRGBO(253, 232, 195, 1),
  200: Color.fromRGBO(252, 217, 155, 1),
  300: Color.fromRGBO(251, 204, 121, 1), // Primary Yellow
  400: Color.fromRGBO(251, 200, 114, 1), // Secondary Yellow
  500: Color.fromRGBO(249, 178, 54, 1), // Brand Yellow
  600: Color.fromRGBO(255, 255, 255, 1),
  700: Color.fromRGBO(255, 248, 241, 1),
  800: Color.fromRGBO(255, 222, 190, 1),
  900: Color.fromRGBO(255, 209, 165, 1),
};

const Map<int, Color> grayscale = {
  50: Color.fromRGBO(255, 255, 255, 1), // White
  100: Color.fromRGBO(251, 253, 255, 1), // Background White
  200: Color.fromRGBO(243, 247, 250, 1), // Gray 1
  300: Color.fromRGBO(223, 230, 238, 1), // Gray 2
  400: Color.fromRGBO(176, 186, 197, 1), // Gray 3
  500: Color.fromRGBO(128, 145, 165, 1), // Gray 4
  600: Color.fromRGBO(102, 117, 135, 1), // Gray 5
  700: Color.fromRGBO(63, 74, 86, 1), // Gray 6
  800: Color.fromRGBO(29, 36, 44, 1),
  900: Color.fromRGBO(12, 16, 20, 1),
};

const Map<int, Color> orange = {
  50: Color.fromRGBO(253, 238, 233, 1),
  100: Color.fromRGBO(250, 212, 201, 1),
  200: Color.fromRGBO(247, 183, 165, 1),
  300: Color.fromRGBO(243, 154, 128, 1),
  400: Color.fromRGBO(255, 143, 104, 1), // Primary Orange
  500: Color.fromRGBO(238, 111, 74, 1), // Secondary Orange
  600: Color.fromRGBO(255, 255, 255, 1),
  700: Color.fromRGBO(255, 235, 232, 1),
  800: Color.fromRGBO(255, 191, 181, 1),
  900: Color.fromRGBO(255, 169, 156, 1),
};

const Map<int, Color> red = {
  50: Color.fromRGBO(253, 231, 234, 1),
  100: Color.fromRGBO(250, 194, 202, 1),
  200: Color.fromRGBO(246, 154, 167, 1),
  300: Color.fromRGBO(242, 113, 131, 1),
  400: Color.fromRGBO(249, 80, 91, 1), // Primary Red
  500: Color.fromRGBO(237, 52, 78, 1), // Secondary Red
  600: Color.fromRGBO(235, 47, 71, 1),
  700: Color.fromRGBO(232, 39, 61, 1),
  800: Color.fromRGBO(229, 33, 53, 1),
  900: Color.fromRGBO(224, 21, 37, 1),
};

const Map<int, Color> green = {
  50: Color.fromRGBO(227, 249, 244, 1),
  100: Color.fromRGBO(186, 239, 227, 1),
  200: Color.fromRGBO(140, 229, 208, 1),
  300: Color.fromRGBO(94, 219, 189, 1),
  400: Color.fromRGBO(80, 227, 194, 1), // Primary Green
  500: Color.fromRGBO(25, 203, 160, 1), // Secondary Green
  600: Color.fromRGBO(22, 198, 152, 1),
  700: Color.fromRGBO(18, 190, 142, 1),
  800: Color.fromRGBO(14, 184, 132, 1),
  900: Color.fromRGBO(8, 172, 115, 1),
};

const Map<int, Color> sea = {
  50: Color.fromRGBO(233, 243, 243, 1),
  100: Color.fromRGBO(200, 225, 224, 1),
  200: Color.fromRGBO(163, 205, 204, 1),
  300: Color.fromRGBO(126, 185, 184, 1),
  400: Color.fromRGBO(121, 201, 199, 1), // Primary Sea
  500: Color.fromRGBO(71, 155, 153, 1), // Secondary Sea
  600: Color.fromRGBO(64, 147, 145, 1),
  700: Color.fromRGBO(55, 137, 134, 1),
  800: Color.fromRGBO(47, 127, 124, 1),
  900: Color.fromRGBO(32, 109, 107, 1),
};

const Map<int, Color> blue = {
  50: Color.fromRGBO(224, 243, 246, 1),
  100: Color.fromRGBO(179, 224, 233, 1),
  200: Color.fromRGBO(128, 203, 219, 1),
  300: Color.fromRGBO(77, 182, 205, 1),
  400: Color.fromRGBO(0, 210, 255, 1), // Primary Blue
  500: Color.fromRGBO(0, 151, 183, 1), // Secondary Blue
  600: Color.fromRGBO(0, 143, 176, 1),
  700: Color.fromRGBO(0, 132, 167, 1),
  800: Color.fromRGBO(0, 122, 159, 1),
  900: Color.fromRGBO(0, 105, 144, 1),
};

const Map<int, Color> sky = {
  50: Color.fromRGBO(224, 240, 251, 1),
  100: Color.fromRGBO(179, 218, 244, 1),
  200: Color.fromRGBO(128, 194, 237, 1),
  300: Color.fromRGBO(77, 169, 230, 1),
  400: Color.fromRGBO(74, 183, 255, 1), // Primary Sky
  500: Color.fromRGBO(0, 132, 219, 1), // Secondary Sky
  600: Color.fromRGBO(0, 124, 215, 1),
  700: Color.fromRGBO(0, 113, 210, 1),
  800: Color.fromRGBO(0, 103, 205, 1),
  900: Color.fromRGBO(0, 84, 196, 1),
};
