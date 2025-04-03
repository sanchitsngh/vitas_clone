import 'package:flutter/material.dart';
import '../../common/widgets/app_bar.dart';
import '../../common/utils/drawer/drawer.dart';
import '../../common/utils/global navbar/global_nav_bar.dart';

class Referral extends StatelessWidget {
  Referral({super.key});
  // Create a GlobalKey for ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey, // Assign the GlobalKey to Scaffold
      drawer: CustomDrawer(),
      appBar: buildAppBar(appBarTitle: "Referral",
      onDrawerTap: () {
          // Open the drawer when the icon in AppBar is tapped
          _scaffoldKey.currentState?.openDrawer();
        },),
      body: Center(
        child: Text("Referral Page", style: TextStyle(fontSize: 25)),
      ),
      bottomNavigationBar: GlobalNavBar(),
    );
  }
}
