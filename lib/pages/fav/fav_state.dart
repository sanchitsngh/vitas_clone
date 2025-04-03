import 'fav.dart';

class FavState {
  final List<Fav> allItems;
  final List<Fav> filterItems;
  FavState({required this.allItems, required this.filterItems});

  FavState copyWith({
    List<Fav> ? allItems,
    List<Fav> ? filterItems,
  
  }){return FavState(
    allItems: allItems ?? this.allItems, 
    filterItems: filterItems ?? this.filterItems, );
  }
}