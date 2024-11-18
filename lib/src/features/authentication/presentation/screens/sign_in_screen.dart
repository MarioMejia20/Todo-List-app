import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/features/authentication/business_logic/bloc/authentication_bloc.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous.userName != current.userName ||
          previous.password != current.password ||
          previous.showPassword != current.showPassword ||
          previous.isValidUser != current.isValidUser ||
          previous.showUserError != current.showUserError,
      listener: (context, state) {
        if (state.showUserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Incorrect user or password'),
            ),
          );
        }

        if (state.isValidUser) {
          context.read<AuthenticationBloc>().add(
                NavigationScreensEvent(
                  moveToScreen: AuthenticationScreenStatus.todoList,
                ),
              );
        }
      },
      builder: (context, state) {
        final statusBarSize = kIsWeb ? 0 : 50;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              controller: ScrollController(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - statusBarSize,
                  maxWidth: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          children: [
                            Text(
                              'ToDo App',
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.w500),
                            ),
                            Text('Sign In'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                onChanged: (value) => context
                                    .read<AuthenticationBloc>()
                                    .add(
                                      OnUserNameChangedEvent(userName: value),
                                    ),
                                decoration: InputDecoration(
                                  labelText: 'User',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                onChanged: (value) =>
                                    context.read<AuthenticationBloc>().add(
                                          OnUserPasswordChangedEvent(
                                              password: value),
                                        ),
                                obscureText: !state.showPassword,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      state.showPassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                    onPressed: () {
                                      context.read<AuthenticationBloc>().add(
                                            ToggleUserPasswordEvent(
                                              showPassword: !state.showPassword,
                                            ),
                                          );
                                    },
                                  ),
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: state.signInEnabled
                                      ? Colors.deepPurple
                                      : Colors.deepPurple.shade50,
                                  foregroundColor: state.signInEnabled
                                      ? Colors.white
                                      : Colors.deepPurple.shade200,
                                ),
                                onPressed: () =>
                                    context.read<AuthenticationBloc>().add(
                                          const OnUserValidationEvent(),
                                        ),
                                child: Text('SignIn'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
