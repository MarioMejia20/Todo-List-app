import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/routing/router.dart';
import 'package:todo/src/features/authentication/business_logic/bloc/authentication_bloc.dart';

@RoutePage()
class AuthWrapperScreen extends StatelessWidget {
  const AuthWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) =>
          previous.screenStatus != current.screenStatus ||
          previous.isLogged != current.isLogged,
      builder: (context, state) {
        return AutoRouter.declarative(
          routes: (_) => [
            if (state.screenStatus.isTodoList)
              TodoListRoute()
            else
              SignInRoute(),
          ],
        );
      },
    );
  }
}
