import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/common/utils/drawer/provider/settings_provider.dart';
//import 'package:vitas_clone/pages/fav/fav_provider.dart';
//import 'package:vitas_clone/pages/fav/widget_order_provider.dart'; // Import the new provider

class ReorderableListScreen extends ConsumerWidget {
  const ReorderableListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the widgetOrderProvider for the current widget names
    final widgetNames = ref.watch(widgetOrderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reorder Widgets"),
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

            // Reorder the items and update the state using widgetOrderProvider
            final List<String> reorderedItems = List<String>.from(widgetNames);
            final item = reorderedItems.removeAt(oldIndex);
            reorderedItems.insert(newIndex, item);

            // Update the provider with the new list order
            ref.read(widgetOrderProvider.notifier).updateWidgetOrder(reorderedItems);
          },
          children: [
            for (final widgetName in widgetNames)
              Container(
                key: ValueKey(widgetName), // Unique key for each item
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
                child: GestureDetector(
                  onTap: () {
                    // You can add any action on tap if required
                  },
                  child: Column(
                    children: [
                      // The drag handle
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.drag_handle,
                          color: Colors.blueGrey[600],
                        ),
                      ),
                      // Widget content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widgetName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
