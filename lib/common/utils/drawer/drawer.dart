import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/core/utils/drawer/settings.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';
import 'package:vitas_clone/pages/fav/fav_screen.dart';

class CustomDrawer extends ConsumerWidget {
  

  const CustomDrawer({
    Key? key,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

     final favState = ref.watch(favProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "PROFILE ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png', // Your logo path
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color:  const Color.fromARGB(255, 63, 14, 90),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReorderableListScreen(),
      ),
    );
  },
            
          ),
          ListTile(
            leading: Icon(Icons.favorite_border_outlined),
            title: Text('Favourite'),
            onTap: () {
               // Navigate to the filtered items screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilteredItemsScreen(filteredItems: favState.filterItems),
                ),
              );
            },
          ),
          
          ListTile(
            leading: Icon(Icons.login_sharp),
            title: Text('Sign Out'),
            onTap: () {
              
            },
          ),

        ],
      ),
    );
  }
}


//  Widget itemdrawer(Icon ic, String txt){
//   return ListTile(
//     leading: Icon(Icons.person),
//     title: Text('Profile'),
//     onTap: () {
//               onItemTap(3); // Profile
//               Navigator.pop(context);
//             },
//   );

//  }