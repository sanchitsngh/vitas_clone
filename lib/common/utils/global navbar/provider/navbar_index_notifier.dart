import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'navbar_index_notifier.g.dart';

 @riverpod
 class NavBarIndexNotifier extends _$NavBarIndexNotifier {
  @override
  int build() {
    return 0;
  }

  void setIndex(BuildContext context, int index) {
   state = index;
   switch (index) {
    case 0:
     Navigator.pushReplacementNamed(context, "Home");
     break;
    case 1:
     Navigator.pushReplacementNamed(context, "Webinars");
     break;
    case 2:
     Navigator.pushReplacementNamed(context, "Referrals");
     break;
   }
  }

 }