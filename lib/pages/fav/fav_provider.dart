
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
            Fav(name: 'Articles', favourite: false),
            Fav(name: 'News', favourite: false),
            Fav(name: 'Services', favourite: false),
            Fav(name: 'Webinars', favourite: false),
          ],
          filterItems: [],
        ));

  // Toggle favorite and move between lists
  void toggleFavorite(Fav fav) {
    final allItems = List<Fav>.from(state.allItems);
    final filterItems = List<Fav>.from(state.filterItems);

    if (filterItems.any((item) => item.name == fav.name)) {
      filterItems.removeWhere((item) => item.name == fav.name);
      allItems[allItems.indexWhere((item) => item.name == fav.name)] =
          fav.copyWith(favourite: false);
    } else {
      filterItems.add(fav.copyWith(favourite: true));
      allItems[allItems.indexWhere((item) => item.name == fav.name)] =
          fav.copyWith(favourite: true);
    }

    state = FavState(allItems: allItems, filterItems: filterItems);
  }

  // Method to manually add an item to the allItems list (for testing)
  void addItem(Fav item) {
    final allItems = List<Fav>.from(state.allItems);
    allItems.add(item);
    state = state.copyWith(allItems: allItems);
  }
  
   // Method to update the list order
  void updateItems(List<Fav> newItems) {
    state = FavState(
      allItems: newItems,
      filterItems: state.filterItems,
    );
  }
}

 

