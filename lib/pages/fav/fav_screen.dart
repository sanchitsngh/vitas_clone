
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';

class FilteredItemsScreen extends ConsumerWidget {
  final List<Fav> filteredItems;

  const FilteredItemsScreen({super.key, required this.filteredItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Screen'),
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          Fav fav = filteredItems[index];

          return ListTile(
            title: Text(fav.name),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                ref.read(favProvider.notifier).toggleFavorite(fav); // Move back to allItems
              },
            ),
          );
        },
      ),
    );
  }
}



 //i want that item from alllist should only change the heart icon to colored heart when its clicked also going to filterlist and dont be removed from alllist and when that colored heart icon is clicked again in alllist make the heart outlined and remove from filterlist . simultaneously when item is clicked in filterlist i want to remove from there and change heart icon to outlined in alllist, which shows that its being removed from filterlist