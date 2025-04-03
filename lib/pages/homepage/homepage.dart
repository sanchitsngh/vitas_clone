import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vitas_clone/common/utils/drawer/drawer.dart';
import 'package:vitas_clone/common/widgets/app_shadow.dart';
import 'package:vitas_clone/pages/articles/articles.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';
import 'package:vitas_clone/pages/fav/fav_screen.dart';
import 'package:vitas_clone/pages/news/news.dart';
import 'package:vitas_clone/pages/services/services.dart';
import 'package:vitas_clone/pages/webinars/webinars.dart';
import '../../common/utils/global navbar/global_nav_bar.dart';
import '../../common/widgets/app_bar.dart';
 
import '../../common/utils/drawer/drawer.dart';


class Homepage extends ConsumerWidget {
  Homepage({super.key});

  // Create a GlobalKey for ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favState = ref.watch(favProvider);

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
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 10, // Space between columns
          mainAxisSpacing: 10, // Space between rows
          childAspectRatio: 1.5, // Aspect ratio of the boxes
        ),
        itemCount: favState.allItems.length,
        itemBuilder: (context, index) {
          Fav fav = favState.allItems[index];

          // Check if the item is in the filterItems list (favorite)
          bool isInFilter =
              favState.filterItems.any((item) => item.name == fav.name);

          return GestureDetector(
            onTap: () {
              // Based on the name of the Fav item, navigate to different screens
              if (fav.name == 'Articles') {
                // Navigate to a specific screen for Item 1
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Articles(),
                  ),
                );
              } else if (fav.name == 'News') {
                // Navigate to a different screen for Item 2
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => News(),
                  ),
                );
              }else if (fav.name == 'Webinars') {
                // Navigate to a different screen for Item 2
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Webinars(),
                  ),
                );
              }
              
               else {
                // Default navigation (you can customize further)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Services(), // Default screen
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              //decoration: appBoxShadow(),
              decoration: BoxDecoration(
                color: isInFilter ? Colors.yellow.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  // Title at the top-left corner
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      fav.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Heart icon at the bottom-right corner
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        // Toggle the favorite status when the heart icon is clicked
                        ref.read(favProvider.notifier).toggleFavorite(fav);
                      },
                      child: Icon(
                        isInFilter ? Icons.favorite : Icons.favorite_border,
                        color: isInFilter ? Colors.red : Colors.grey,
                        size: 24, // Small size for the heart icon
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
