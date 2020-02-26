import 'package:flutter/foundation.dart';

class Item {
  final int id;
  final String body;

  Item({
    @required this.id,
    @required this.body,
  });

  // replace with new object
  // reducer uses copyWith and create new state
  Item copyWith({int id, String body}) {
    // ?? means to use current value if nothing passed
    return Item(
      id: id ?? this.id,
      body: body ?? this.body,
    );
  }

}

class AppState {
  final List<Item> items;

  AppState({
    @required this.items,
  });

  // named constructor, immutable
  AppState.initialState() : items = List.unmodifiable(<Item>[]);
}