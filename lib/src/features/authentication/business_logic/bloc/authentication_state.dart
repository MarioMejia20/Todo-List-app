part of 'authentication_bloc.dart';

enum AuthenticationScreenStatus {
  signIn,
  todoList;

  bool get isSignIn => this == signIn;
  bool get isTodoList => this == todoList;
}

class AuthenticationState extends Equatable {
  final AuthenticationScreenStatus screenStatus;
  final String? userName;
  final String? password;
  final bool isLogged;
  final bool showPassword;
  final bool signInEnabled;
  final bool isValidUser;
  final bool showUserError;

  const AuthenticationState({
    this.screenStatus = AuthenticationScreenStatus.signIn,
    this.userName,
    this.password,
    this.isLogged = false,
    this.showPassword = false,
    this.signInEnabled = false,
    this.isValidUser = false,
    this.showUserError = false,
  });

  AuthenticationState copyWith({
    AuthenticationScreenStatus? screenStatus,
    String? userName,
    String? password,
    bool? isLogged,
    bool? showPassword,
    bool? signInEnabled,
    bool? isValidUser,
    bool? showUserError,
  }) {
    return AuthenticationState(
      screenStatus: screenStatus ?? this.screenStatus,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      isLogged: isLogged ?? this.isLogged,
      signInEnabled: signInEnabled ?? this.signInEnabled,
      isValidUser: isValidUser ?? this.isValidUser,
      showUserError: showUserError ?? this.showUserError,
    );
  }

  @override
  List<Object?> get props => [
        screenStatus,
        userName,
        password,
        showPassword,
        isLogged,
        signInEnabled,
        isValidUser,
        showUserError,
      ];
}
