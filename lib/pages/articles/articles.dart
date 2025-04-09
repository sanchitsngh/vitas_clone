import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/common/utils/global%20navbar/global_nav_bar.dart';
import 'package:vitas_clone/pages/articles/details.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/common/utils/drawer/drawer.dart';
import 'package:vitas_clone/common/widgets/app_bar.dart';
import 'package:vitas_clone/pages/articles/database.dart'; // If used for app-specific logic


class Articles extends ConsumerWidget {
  Articles({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favState = ref.watch(favProvider); // Watch the favProvider here

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: buildAppBar(
        appBarTitle: "Articles",
        onDrawerTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: FutureBuilder<List<Fav>>(
        future: firestoreService.fetchArticles(), // Fetch the articles first
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<Fav> articles = snapshot.data ?? [];

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              Fav article = articles[index];

              // Get the description for each article from Firestore
              return FutureBuilder<String>(
                future: firestoreService.fetchArticleDescriptionByName(article.name),
                builder: (context, descriptionSnapshot) {
                  if (descriptionSnapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text(article.name),
                      subtitle: Text("Loading..."), // Show loading while fetching description
                    );
                  }

                  if (descriptionSnapshot.hasError) {
                    return ListTile(
                      title: Text(article.name),
                      subtitle: Text("Error: ${descriptionSnapshot.error}"), // Error in fetching description
                    );
                  }

                  String description = descriptionSnapshot.data ?? 'No description available';

                  // Check if the article is favorited
                  bool isFavorited = favState.filterItems.any((fav) => fav.name == article.name);

                  return ListTile(
                    title: Text(article.name),
                    subtitle: Text(description), // Display the fetched description
                    trailing: IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : null,
                      ),
                      onPressed: () {
                        // Toggle the favorite status
                        ref.read(favProvider.notifier).toggleFavorite(article);
                      },
                    ),
                    onTap: () {
                      // Navigate to the article details page when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                            articleName: article.name,
                            description: description,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: GlobalNavBar(),
    );
  }
}
