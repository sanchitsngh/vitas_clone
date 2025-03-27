
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/pages/fav/fav_state.dart';


// Create a provider for the FavNotifier
final favProvider = StateNotifierProvider<FavNotifier, FavState>((ref) {
  return FavNotifier();
});

class FavNotifier extends StateNotifier<FavState> {
  FavNotifier()
      : super(FavState(
          allItems: [
            Fav(name: 'Item 1', favourite: false),
            Fav(name: 'Item 2', favourite: false),
            Fav(name: 'Item 3', favourite: false),
            Fav(name: 'Item 4', favourite: false),
          ],
          filterItems: [],
        ));

  // Toggle favorite and move between lists
  void toggleFavorite(Fav fav) {
    final allItems = List<Fav>.from(state.allItems);
    final filterItems = List<Fav>.from(state.filterItems);

    // If the item is currently in filterItems (favorite), remove it from there and make it un-favorite in allItems
    if (filterItems.any((item) => item.name == fav.name)) {
      filterItems.removeWhere((item) => item.name == fav.name);
      allItems[allItems.indexWhere((item) => item.name == fav.name)] = fav.copyWith(favourite: false);
    } 
    // Otherwise, add it to filterItems and make it favorite
    else {
      filterItems.add(fav.copyWith(favourite: true));
      allItems[allItems.indexWhere((item) => item.name == fav.name)] = fav.copyWith(favourite: true);
    }

    // Update state
    state = state.copyWith(allItems: allItems, filterItems: filterItems);
  }

  // Method to manually add an item to the allItems list (for testing)
  void addItem(Fav item) {
    final allItems = List<Fav>.from(state.allItems);
    allItems.add(item);
    state = state.copyWith(allItems: allItems);
  }
}

