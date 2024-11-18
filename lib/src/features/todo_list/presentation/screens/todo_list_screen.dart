import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/features/todo_list/business_logic/bloc/todo_list_bloc.dart';

@RoutePage()
class TodoListScreen extends StatelessWidget implements AutoRouteWrapper {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textFieldController = TextEditingController();
    return BlocConsumer<TodoListBloc, TodoListState>(
      listenWhen: (previous, current) =>
          previous.showTodoItemDialog != current.showTodoItemDialog ||
          previous.todoList != current.todoList,
      listener: (context, state) async {
        if (state.showTodoItemDialog) {
          _textFieldController.text = '';
          showDialog(
            context: context,
            builder: (builder) => AlertDialog(
              title: Text('Add a task to your List'),
              content: TextFormField(
                controller: _textFieldController,
                onChanged: (value) {
                  context
                      .read<TodoListBloc>()
                      .add(OnTodoItemChangedEvent(item: value));
                },
                decoration: InputDecoration(
                  labelText: 'Task',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.maybePop();
                    context.read<TodoListBloc>().add(
                          ShowTodoItemDialogEvent(showDialog: false),
                        );
                  },
                  child: Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    if (_textFieldController.text.isNotEmpty) {
                      context.read<TodoListBloc>().add(OnAddTodoItemEvent());
                      context.maybePop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('A task can not be empty'),
                        ),
                      );
                    }
                  },
                  child: Text('ADD'),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('To-Do List'),
          ),
          body: state.todoList.isEmpty
              ? _emptyTaskWidget()
              : ListView.separated(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    final todoItem = state.todoList[index];
                    return Dismissible(
                      key: Key(todoItem),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          context.read<TodoListBloc>().add(
                                OnDeleteTodoItemEvent(itemPosition: index),
                              );
                        }
                      },
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      child: ListTile(
                        title: Text(todoItem),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context
                  .read<TodoListBloc>()
                  .add(const ShowTodoItemDialogEvent(showDialog: true));
            },
            tooltip: 'Add Item',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _emptyTaskWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_note_rounded,
            color: Colors.deepPurple.shade50,
            size: 80,
          ),
          Text(
            'Your task list is empty',
            style: TextStyle(
              color: Colors.deepPurple.shade100,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoListBloc(),
      child: this,
    );
  }
}
