import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitas_clone/common/utils/global%20navbar/provider/navbar_index_notifier.dart';

class GlobalNavBar extends ConsumerWidget {
  const GlobalNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navBarIndexNotifierProvider);
    return NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            ref.read(navBarIndexNotifierProvider.notifier).setIndex(context, index);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home,), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.profile_add), label: "Webinars"),
            NavigationDestination(icon: Icon(Iconsax.document), label: "Referrals"),
          ]
    );
  }
}
