import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitas_clone/pages/fav/fav.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Fav>> fetchArticles() async {
  try {
    print("Fetching articles...");
    QuerySnapshot snapshot = await _db.collection('articles').get();
    print("Articles fetched successfully.");
    return snapshot.docs.map((doc) {
      return Fav(
        name: doc['name'],
        favourite: false, // Default to false for all articles
      );
    }).toList();
  } catch (e) {
    print("Error fetching articles: $e");
    rethrow;
  }
}
 Future<String> fetchArticleDescriptionByName(String articleName) async {
  try {
    QuerySnapshot snapshot = await _db
        .collection('articles')
        .where('name', isEqualTo: articleName) // Query by the 'name' field
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Assuming we have only one document with the name
      DocumentSnapshot doc = snapshot.docs[0];
      return doc['description'] ?? 'No description available';
    } else {
      return 'No description available';
    }
  } catch (e) {
    print("Error fetching article description: $e");
    return 'No description available';
  }
}


}
