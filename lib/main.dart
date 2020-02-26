import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:redux_todo_app/models/model.dart';
import 'package:redux_todo_app/redux/actions.dart';
import 'package:redux_todo_app/redux/reducers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = Store<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
    );

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux todo app'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(
            store), // takes store and convert into view model for descending widget
        builder: (BuildContext context, _ViewModel viewModel) => Column(
          // takes in whatever we return in coverter
          children: <Widget>[
            AddItemWidget(viewModel), // call add item actions, text box
            Expanded(
              child: ItemListWidget(viewModel),
            ), // display items list
            RemoveItemsButton(viewModel), // call remove item actions
          ],
        ),
      ),
    );
  }
}

// *************** Add Item Widget, state ******************** //
// all the widget recieves view model
class AddItemWidget extends StatefulWidget {
  final _ViewModel model;

  AddItemWidget(this.model);

  @override
  _AddItemState createState() => _AddItemState();
}

// text form field for adding item
class _AddItemState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Add an New Item',
      ),
      onSubmitted: (String s) {
        widget.model.onAddItem(s);
        controller.text = '';
      },
    );
  }
}
// ***************************************** //

// *************** Item List Widget, state ******************** //
class ItemListWidget extends StatelessWidget {
  final _ViewModel model;

  ItemListWidget(this.model);

  // display all of items in the app state
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: model.items
          .map(
            (Item item) => ListTile(
              title: Text(item.body),
              leading: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => model.onRemoveItem(item),
              ),
            ),
          )
          .toList(),
    );
  }
}
// ***************************************** //

// *************** Item List Widget, state ******************** //
class RemoveItemsButton extends StatelessWidget {
  final _ViewModel model;

  RemoveItemsButton(this.model);

  // widget to display remove button
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Remove all items'),
      onPressed: () => model.onRemoveItems(),
    );
  }
}

// ************************************************************ //

class _ViewModel {
  final List<Item> items;

  // represent user actions, bound to each actions
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  _ViewModel({
    this.items,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveItems,
  });

  factory _ViewModel.create(Store<AppState> store) {
    _onAddItem(String body) {
      store.dispatch(AddItemAction(body));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction());
    }

    return _ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
    );
  }
}
