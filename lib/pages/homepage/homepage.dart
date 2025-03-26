import 'package:flutter/material.dart';
import '../../common/utils/global navbar/global_nav_bar.dart';
import '../../common/widgets/app_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarTitle: "Home"),
      body: Center(
        child: Text(
          "Homepage", style: TextStyle(fontSize: 25),
        ),
      ),
      bottomNavigationBar: GlobalNavBar(),
    );
  }
}
