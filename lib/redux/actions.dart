import 'package:redux_todo_app/models/model.dart';

class AddItemAction {
  static int _id = 0;
  final String item;

  AddItemAction(this.item) {
    _id++;
  }

  int get id {
    return _id;
  }
}

// remove sibgle item from app state
class RemoveItemAction {
  final Item item;

  RemoveItemAction(
    this.item,
  );
}

// remove all items from app state
class RemoveItemsAction {
  
}
