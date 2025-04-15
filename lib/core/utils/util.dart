import 'package:flutter/material.dart';

bool isTablet(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  return screenWidth > 600 ? true : false;
}
