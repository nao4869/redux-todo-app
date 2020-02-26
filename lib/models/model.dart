import 'package:flutter/foundation.dart';

class Item {
  final int id;
  final String body;
  final bool completed;

  Item({
    @required this.id,
    @required this.body,
    this.completed = false,
  });

  // replace with new object
  // reducer uses copyWith and create new state
  Item copyWith({int id, String body, bool completed}) {
    // ?? means to use current value if nothing passed
    return Item(
      id: id ?? this.id,
      body: body ?? this.body,
      completed: completed ?? this.completed,
    );
  }

  Item.fromJson(Map json)
      : body = json['body'],
        id = json['id'],
        completed = json['completed'];


  // create map as id, body and turn it into json format
  Map toJson() => {
        'id': (id as int),
        'body': body,
        'completed': completed,
      };

  @override
    String toString() {
      return toJson().toString();
    }
}

class AppState {
  final List<Item> items;
  
  // for navigation
  //final String name;

  const AppState({
    @required this.items,
    //this.name,
  });

  // constructor take json item and covert into list
  AppState.fromJson(Map json)
      : items = (json['items'] as List).map((i) => Item.fromJson(i)).toList();

  // take items and put into map with key being items
  Map toJson() => {'items': items};

  // named constructor, immutable
  AppState.initialState() : items = List.unmodifiable(<Item>[]);
  // factory AppState.changeName(String name) => AppState(items, name);
}