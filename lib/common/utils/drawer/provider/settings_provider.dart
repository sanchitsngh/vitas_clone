import 'package:flutter_riverpod/flutter_riverpod.dart';

// This provider will manage the order of widget names.
final widgetOrderProvider = StateNotifierProvider<WidgetOrderNotifier, List<String>>((ref) {
  return WidgetOrderNotifier();
});

class WidgetOrderNotifier extends StateNotifier<List<String>> {
  WidgetOrderNotifier() : super([
    'Articles',
    'News',
    'Webinars',
    'Services',
  ]); // Initial order of widget names.

  void updateWidgetOrder(List<String> updatedOrder) {
    state = updatedOrder;
  }
}
