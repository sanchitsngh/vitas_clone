import 'package:flutter/material.dart';
import '../../common/utils/global navbar/global_nav_bar.dart';
import '../../common/widgets/app_bar.dart';

class Referral extends StatelessWidget {
  const Referral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarTitle: "Referral"),
      body: Center(
        child: Text("Referral Page", style: TextStyle(fontSize: 25)),
      ),
      bottomNavigationBar: GlobalNavBar(),
    );
  }
}
