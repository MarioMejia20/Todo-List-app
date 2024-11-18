import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState()) {
    on<OnTodoItemChangedEvent>(_onTodoItemChanged);
    on<ShowTodoItemDialogEvent>(_showTodoItemDialog);
    on<OnAddTodoItemEvent>(_addTodoItemList);
    on<OnDeleteTodoItemEvent>(_deleteTodoItem);
  }

  /// Changed Texfield Actions
  void _onTodoItemChanged(
      OnTodoItemChangedEvent event, Emitter<TodoListState> emitter) {
    emitter(
      state.copyWith(
        todoItem: event.item,
        enableToAdd: event.item.isNotEmpty,
      ),
    );
  }

  ///Toggle Actions
  void _showTodoItemDialog(
      ShowTodoItemDialogEvent event, Emitter<TodoListState> emitter) {
    emitter(state.copyWith(
      showTodoItemDialog: event.showDialog,
      todoItem: '',
      enableToAdd: false,
    ));
  }

  void _addTodoItemList(
      OnAddTodoItemEvent event, Emitter<TodoListState> emitter) {
    var todoCopyList = List<String>.from(state.todoList);
    if (state.todoItem != null && state.todoItem!.isNotEmpty) {
      todoCopyList.add(state.todoItem ?? '');
      emitter(state.copyWith(
        todoList: todoCopyList,
        todoItem: '',
        showTodoItemDialog: false,
      ));
    }
  }

  void _deleteTodoItem(
      OnDeleteTodoItemEvent event, Emitter<TodoListState> emitter) {
    var todoCopyList = List<String>.from(state.todoList);
    todoCopyList.removeAt(event.itemPosition);

    emitter(state.copyWith(todoList: todoCopyList));
  }
}
