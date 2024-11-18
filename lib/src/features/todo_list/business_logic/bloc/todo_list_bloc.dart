import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/features/todo_list/data/repositories/todo_list_repository.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final TodoListRepository _todoListRepository;

  TodoListBloc({required TodoListRepository todoListRepository})
      : _todoListRepository = todoListRepository,
        super(TodoListState()) {
    on<OnTodoItemChangedEvent>(_onTodoItemChanged);
    on<ShowTodoItemDialogEvent>(_showTodoItemDialog);
    on<OnAddTodoItemEvent>(_addTodoItemList);
    on<OnDeleteTodoItemEvent>(_deleteTodoItem);
    on<GetAllLocalTaskEvent>(_getAllTaskData);
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

  ///Business Logic
  void _addTodoItemList(
      OnAddTodoItemEvent event, Emitter<TodoListState> emitter) {
    var todoCopyList = List<String>.from(state.todoList);

    if (state.todoItem != null && state.todoItem!.isNotEmpty) {
      _saveTaskItemLocal(taskItem: state.todoItem ?? '');
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

    _todoListRepository.removeTaskFromHive(event.itemPosition);

    emitter(state.copyWith(todoList: todoCopyList));
  }

  ///Manage Task data locally with Hive
  void _saveTaskItemLocal({required String taskItem}) async {
    await _todoListRepository.saveEncryptedTaskData(task: taskItem);
  }

  void _getAllTaskData(
      GetAllLocalTaskEvent event, Emitter<TodoListState> emitter) async {
    var data = await _todoListRepository.getEncryptedTaskData();
    emitter(state.copyWith(todoList: data));
  }
}
