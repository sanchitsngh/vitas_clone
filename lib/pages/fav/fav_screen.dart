import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';
import 'package:vitas_clone/pages/articles/articles.dart';
import 'package:vitas_clone/pages/news/news.dart';
import 'package:vitas_clone/pages/webinars/webinars.dart';
import 'package:vitas_clone/pages/services/services.dart';

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

          // Check if the item is in the filterItems list (favorite)
          bool isInFilter = filteredItems.any((item) => item.name == fav.name);

          return GestureDetector(
            onTap: () {
              // Navigate to different pages based on the favorite item's name
              if (fav.name == 'Articles') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Articles(),
                  ),
                );
              } else if (fav.name == 'News') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => News(),
                  ),
                );
              } else if (fav.name == 'Webinars') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Webinars(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Services(),
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isInFilter ? Colors.yellow.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  // Title at the top-left corner
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
                  // Heart icon at the bottom-right corner
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        // Toggle the favorite status when the heart icon is clicked
                        ref.read(favProvider.notifier).toggleFavorite(fav);
                      },
                      child: Icon(
                        isInFilter ? Icons.favorite : Icons.favorite_border,
                        color: isInFilter ? Colors.red : Colors.grey,
                        size: 24, // Small size for the heart icon
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
