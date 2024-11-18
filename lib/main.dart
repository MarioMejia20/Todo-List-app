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
      title: 'To-Do-List',
      routerConfig: _appRouter.config(),
    );
  }
}
