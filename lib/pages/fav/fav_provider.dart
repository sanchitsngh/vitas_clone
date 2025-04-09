
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/pages/articles/database.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/pages/fav/fav_state.dart';


// Create a provider for the FavNotifier
final favProvider = StateNotifierProvider<FavNotifier, FavState>((ref) {
  return FavNotifier();
});

class FavNotifier extends StateNotifier<FavState> {
     FavNotifier()
      : super(FavState(allItems: [], filterItems: [])) {
    _loadArticles();
  }

  // 
  
   // Toggle favorite and move between lists
  void toggleFavorite(Fav fav) {
    final allItems = List<Fav>.from(state.allItems);
    final filterItems = List<Fav>.from(state.filterItems);

    // If the article is already in filterItems (favorites list), remove it
    if (filterItems.any((item) => item.name == fav.name)) {
      filterItems.removeWhere((item) => item.name == fav.name);
      allItems[allItems.indexWhere((item) => item.name == fav.name)] =
          fav.copyWith(favourite: false); // Mark as non-favorite
    } else {
      // If the article is not in filterItems, add it
      filterItems.add(fav.copyWith(favourite: true));
      allItems[allItems.indexWhere((item) => item.name == fav.name)] =
          fav.copyWith(favourite: true); // Mark as favorite
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

    // Load articles from Firestore
  Future<void> _loadArticles() async {
    final firestoreService = FirestoreService();
    final articles = await firestoreService.fetchArticles();
    
    // Sync the favourite status with filterItems
    final allItems = articles.map((article) {
      // Check if the article is already in filterItems
      final isFavorite = state.filterItems.any((fav) => fav.name == article.name);
      return article.copyWith(favourite: isFavorite);
    }).toList();

    state = FavState(allItems: allItems, filterItems: state.filterItems);
  }
}

 

