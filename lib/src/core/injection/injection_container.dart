import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/src/features/authentication/data/models/authentication_module.dart';
import 'package:todo/src/features/todo_list/data/repositories/todo_list_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();

  sl.registerLazySingleton((() => TodoListRepository()));

  AuthenticationModule(sl).init();
}
