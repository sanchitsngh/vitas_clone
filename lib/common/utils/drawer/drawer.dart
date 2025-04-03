import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/common/utils/drawer/settings.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';
import 'package:vitas_clone/pages/fav/fav_screen.dart';
import 'package:vitas_clone/pages/auth/presentation/providers/google_auth/google_auth_notifier.dart';
import '../../../pages/auth/presentation/pages/sign_in_page.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favState = ref.watch(favProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "PROFILE ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 63, 14, 90),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
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
            leading: const Icon(Icons.favorite_border_outlined),
            title: const Text('Favourite'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FilteredItemsScreen(filteredItems: favState.filterItems),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.login_sharp),
            title: const Text('Sign Out'),
            onTap: () async {
              // Call sign-out from GoogleAuthNotifier
              await ref.read(googleAuthNotifierProvider.notifier).signOut();

              // Check if sign-out was successful (no error)
              final googleAuthState = ref.read(googleAuthNotifierProvider);
              if (googleAuthState.errorMessage == null) {
                // Redirect to SignIn screen and clear navigation stack
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                      (route) => false,
                );
              } else {
                // Show error message if sign-out fails
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Sign-out failed: ${googleAuthState.errorMessage}'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}