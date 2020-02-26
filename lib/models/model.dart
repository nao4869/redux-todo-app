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

  Item.fromJson(Map json)
      : body = json['body'],
        id = json['id'];

  // create map as id, body and turn it into json format
  Map toJson() => {
        'id': (id as int),
        'body': body,
      };
}

class AppState {
  final List<Item> items;

  AppState({
    @required this.items,
  });

  // constructor take json item and covert into list
  AppState.fromJson(Map json)
      : items = (json['items'] as List).map((i) => Item.fromJson(i)).toList();

  // take items and put into map with key being items
  Map toJson() => {'items': items};

  // named constructor, immutable
  AppState.initialState() : items = List.unmodifiable(<Item>[]);
}
