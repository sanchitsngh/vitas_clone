import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';
import '../../common/widgets/app_bar.dart';
import '../../common/utils/drawer/drawer.dart';
import '../../common/utils/global navbar/global_nav_bar.dart';

class Homepage extends ConsumerWidget {
  Homepage({super.key});

   // Create a GlobalKey for ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favState = ref.watch(favProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(appBarTitle: "Home",
      onDrawerTap: () {
          // Open the drawer when the icon in AppBar is tapped
          _scaffoldKey.currentState?.openDrawer();
        }),
        drawer: CustomDrawer(),

      body: ListView.builder(
        itemCount: favState.allItems.length,
        itemBuilder: (context, index) {
          Fav fav = favState.allItems[index];

          // Check if the item is in the filterItems list (favorite)
          bool isInFilter = favState.filterItems.any((item) => item.name == fav.name);

          return ListTile(
            title: Text(fav.name),
            trailing: IconButton(
              icon: Icon(
                isInFilter ? Icons.favorite : Icons.favorite_border,
                color: isInFilter ? Colors.red : null,  // Red if it's in filterItems (favorite)
              ),
              onPressed: () {
                ref.read(favProvider.notifier).toggleFavorite(fav); // Toggle favorite status
              },
            ),
          );
        },
      ),
      bottomNavigationBar: GlobalNavBar(),
    );
  }
}
