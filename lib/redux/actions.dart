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

class GetItemsAction {
  
}

class LoadedItemsAction {
  final List<Item> items;

  LoadedItemsAction(this.items);
}

class ItemCompletedAction {
  final Item item;

  ItemCompletedAction(this.item);
}

// // Actions for routes
// class NavigateReplaceAction {
//   final String routeName;
  
//   NavigateReplaceAction(this.routeName);

//   @override
//   String toString() {
//     return 'MainMenuNavigateAction{routeName: $routeName}';
//   }
// }

// class NavigatePushAction {
//   final String routeName;

//   NavigatePushAction(this.routeName);

//   @override
//   String toString() {
//     return 'NavigatePushAction{routeName: $routeName}';
//   }
// }

// class NavigatePopAction {

//   @override
//   String toString() {
//     return 'NavigatePopAction';
//   }
// }


