part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnUserNameChangedEvent extends AuthenticationEvent {
  final String userName;

  const OnUserNameChangedEvent({required this.userName});
}

class OnUserPasswordChangedEvent extends AuthenticationEvent {
  final String password;

  const OnUserPasswordChangedEvent({required this.password});
}

class ToggleUserPasswordEvent extends AuthenticationEvent {
  final bool showPassword;

  const ToggleUserPasswordEvent({
    required this.showPassword,
  });
}

class OnSignInEnableButtonEvent extends AuthenticationEvent {
  final bool enable;

  const OnSignInEnableButtonEvent({required this.enable});
}

class OnUserValidationEvent extends AuthenticationEvent {
  final bool hideSnackBar;
  const OnUserValidationEvent({this.hideSnackBar = false});
}

class NavigationScreensEvent extends AuthenticationEvent {
  final AuthenticationScreenStatus moveToScreen;

  const NavigationScreensEvent({
    required this.moveToScreen,
  });
}
