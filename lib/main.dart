import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/routing/router.dart';
import 'package:todo/src/core/injection/injection_container.dart';
import 'package:todo/src/features/authentication/business_logic/bloc/authentication_bloc.dart';

import 'src/core/injection/injection_container.dart' as injection;

void main() async {
  await injection.init();
  runApp(
    BlocProvider(
      create: (_) => sl.get<AuthenticationBloc>(),
      lazy: false,
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  TodoApp({super.key});

  final _appRouter = TodoAppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: 'ToDo',
      routerConfig: _appRouter.config(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'To-Do-List', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _displayDialog(context)
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title) {
    //Wrapping it inside a set state will notify
    // the app that the state has changed

    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  //Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
    );
  }

  //Generate a single item widget
  // Future<AlertDialog> _displayDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Add a task to your List'),
  //           content: TextField(
  //             controller: _textFieldController,
  //             decoration: const InputDecoration(hintText: 'Enter task here'),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: const Text('ADD'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 _addTodoItem(_textFieldController.text);
  //               },
  //             ),
  //             FlatButton(
  //               child: const Text('CANCEL'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}
