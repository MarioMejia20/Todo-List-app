part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<String> todoList;
  final String? todoItem;
  final bool showTodoItemDialog;
  final bool enableToAdd;

  const TodoListState({
    this.todoList = const [],
    this.todoItem,
    this.showTodoItemDialog = false,
    this.enableToAdd = false,
  });

  TodoListState copyWith({
    List<String>? todoList,
    String? todoItem,
    bool? showTodoItemDialog,
    bool? enableToAdd,
  }) {
    return TodoListState(
      todoList: todoList ?? this.todoList,
      todoItem: todoItem ?? this.todoItem,
      showTodoItemDialog: showTodoItemDialog ?? this.showTodoItemDialog,
      enableToAdd: enableToAdd ?? this.enableToAdd,
    );
  }

  @override
  List<Object?> get props => [
        todoList,
        todoItem,
        showTodoItemDialog,
        enableToAdd,
      ];
}
