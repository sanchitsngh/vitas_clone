import 'package:flutter/material.dart';
import '../../common/utils/global navbar/global_nav_bar.dart';
import '../../common/widgets/app_bar.dart';

class Webinars extends StatelessWidget {
  const Webinars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarTitle: "Webinars"),
      body: Center(
        child: Text("Webinars Page", style: TextStyle(fontSize: 25),),
      ),
      bottomNavigationBar: GlobalNavBar(),
    );
  }
}
