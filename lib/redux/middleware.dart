import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:redux_todo_app/models/model.dart';
import 'package:redux_todo_app/redux/actions.dart';

List<Middleware<AppState>> appStateMiddleware(
    [AppState state = const AppState(items: [])]) {
  final loadItems = _loadFromPrefs(state);
  final saveItems = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemsAction>(saveItems),
    TypedMiddleware<AppState, GetItemsAction>(loadItems),
  ];
}

// returns middleware closure
Middleware<AppState> _loadFromPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    loadedFromPrefs()
        .then((state) => store.dispatch(LoadedItemsAction(state.items)));
  };
}

Middleware<AppState> _saveToPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    saveToPrefs(store.state);
  };
}

// save data into shared preferences store
void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string =
      json.encode(state.toJson()); // take json encoder and store as str
  await preferences.setString(
      'itemsState', string); // put into json preferences store
}

// load data from shared preferences store
Future<AppState> loadedFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('itemsState');

  // if itemsState is not null, returns list of items
  if (string != null) {
    Map map = json.decode(string);
    return AppState.fromJson(map);
  }
  return AppState.initialState();
}
