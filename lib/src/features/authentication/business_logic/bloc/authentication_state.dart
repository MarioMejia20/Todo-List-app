part of 'authentication_bloc.dart';

enum AuthenticationScreenStatus {
  signIn,
  home;

  bool get isSignIn => this == signIn;
  bool get isHome => this == home;
}

class AuthenticationState extends Equatable {
  final AuthenticationScreenStatus screenStatus;
  final bool isLogged;

  const AuthenticationState({
    this.screenStatus = AuthenticationScreenStatus.signIn,
    this.isLogged = false,
  });

  AuthenticationState copyWith({
    AuthenticationScreenStatus? screenStatus,
    bool? isLogged,
  }) {
    return AuthenticationState(
      screenStatus: screenStatus ?? this.screenStatus,
      isLogged: isLogged ?? this.isLogged,
    );
  }

  @override
  List<Object?> get props => [
        screenStatus,
        isLogged,
      ];
}
