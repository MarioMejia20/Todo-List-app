part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object?> get props => [];
}

class OnTodoItemChangedEvent extends TodoListEvent {
  final String item;

  const OnTodoItemChangedEvent({required this.item});
}

class ShowTodoItemDialogEvent extends TodoListEvent {
  final bool showDialog;

  const ShowTodoItemDialogEvent({required this.showDialog});
}

class OnAddTodoItemEvent extends TodoListEvent {
  const OnAddTodoItemEvent();
}

class OnDeleteTodoItemEvent extends TodoListEvent {
  final int itemPosition;

  const OnDeleteTodoItemEvent({required this.itemPosition});
}
