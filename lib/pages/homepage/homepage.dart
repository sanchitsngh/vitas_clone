import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/common/utils/drawer/provider/settings_provider.dart';
import 'package:vitas_clone/common/widgets/app_bar.dart';
import 'package:vitas_clone/pages/articles/articles.dart';

import 'package:vitas_clone/pages/news/news.dart';
import 'package:vitas_clone/pages/services/services.dart';
import 'package:vitas_clone/pages/webinars/webinars.dart';
import 'package:vitas_clone/common/utils/drawer/drawer.dart';
import 'package:vitas_clone/common/utils/global%20navbar/global_nav_bar.dart';


class Homepage extends ConsumerWidget {
  Homepage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the widgetOrderProvider to get the current widget order
    final widgetNames = ref.watch(widgetOrderProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(
        appBarTitle: "Home",
        onDrawerTap: () {
          // Open the drawer when the icon in AppBar is tapped
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: CustomDrawer(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemCount: widgetNames.length, // Dynamically get count from provider
        itemBuilder: (context, index) {
          String title = widgetNames[index];
          Widget page;

          switch (title) {
            case 'Articles':
              page = Articles();
              break;
            case 'News':
              page = News();
              break;
            case 'Webinars':
              page = Webinars();
              break;
            case 'Services':
              page = Services();
              break;
            default:
              page = Container();
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GlobalNavBar(),
    );
  }
}
