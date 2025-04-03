import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/pages/fav/fav.dart';
import 'package:vitas_clone/pages/fav/fav_provider.dart';

class ReorderableListScreen extends ConsumerWidget {
  const ReorderableListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favState = ref.watch(favProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reorder Items"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            // Reorder the items and update the state
            final List<Fav> reorderedItems = List<Fav>.from(favState.allItems);
            final item = reorderedItems.removeAt(oldIndex);
            reorderedItems.insert(newIndex, item);

            // Update the provider with the new list order
            ref.read(favProvider.notifier).updateItems(reorderedItems);
          },
          children: [
            for (final fav in favState.allItems)
              Container(
                key: ValueKey(fav.name),  // Unique key for each item
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  leading: Icon(
                    Icons.drag_handle,
                    color: Colors.blueGrey[600],
                  ),
                  title: Text(
                    fav.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Drag to reorder", style: TextStyle(fontSize: 12, color: Colors.blueGrey[400])),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
