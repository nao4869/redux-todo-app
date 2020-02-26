import 'package:flutter/material.dart';

// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';

// import 'package:redux_todo_app/models/model.dart';
// import 'package:redux_todo_app/redux/actions.dart';
// import 'package:redux_todo_app/redux/reducers.dart';

// import 'package:redux_dev_tools/redux_dev_tools.dart';
// import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';

// import 'package:redux_todo_app/redux/middleware.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({Key key}) : super(key: key);
  static const routeName = 'item_detail_page';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _ItemBody(),
    );
  }
}

class _ItemBody extends StatelessWidget {
  const _ItemBody({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 275 / 414,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Test'),
            ),
          ],
        ),
      ),
    );
  }
}
