import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:redux_todo_app/models/model.dart';
import 'package:redux_todo_app/redux/actions.dart';

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

// actual middleware
// next is function dispatcher to chain this middleware to next dispatcher if there is one
void appStateMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  if (action is AddItemAction ||
      action is RemoveItemsAction ||
      action is RemoveItemsAction) {
    saveToPrefs(store.state);
  }

  if (action is GetItemsAction) {
    await loadedFromPrefs()
        .then((state) => store.dispatch(LoadedItemsAction(state.items)));
  }
}
