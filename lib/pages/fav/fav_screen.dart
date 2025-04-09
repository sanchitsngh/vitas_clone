import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/pages/articles/database.dart';
import 'package:vitas_clone/pages/articles/details.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';


class FilteredItemsScreen extends ConsumerWidget {
  const FilteredItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the favProvider to get filterItems
    final favState = ref.watch(favProvider);
    final favoriteArticles = favState.filterItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Articles'),
      ),
      body: favoriteArticles.isEmpty
          ? Center(child: Text('No favorite articles yet.'))
          : ListView.builder(
              itemCount: favoriteArticles.length,
              itemBuilder: (context, index) {
                Fav fav = favoriteArticles[index];

                return GestureDetector(
                  onTap: () async {
                    // Fetch the description of the article before navigating
                    String description = await FirestoreService().fetchArticleDescriptionByName(fav.name);

                    // Navigate to the ArticleDetailScreen and pass article details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailScreen(
                          articleName: fav.name,
                          description: description, // Pass the fetched description
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
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
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              // Toggle favorite status when heart icon is clicked
                              ref.read(favProvider.notifier).toggleFavorite(fav);
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
