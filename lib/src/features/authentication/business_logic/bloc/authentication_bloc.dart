import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/src/core/app_constants.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    on<OnUserNameChangedEvent>(_onUserNameChanged);
    on<OnUserPasswordChangedEvent>(_onPasswordChanged);
    on<ToggleUserPasswordEvent>(_toggleShowPassword);
    on<OnSignInEnableButtonEvent>(_enableSignInButton);
    on<OnUserValidationEvent>(_validateUserCredentials);
    on<NavigationScreensEvent>(_navigationScreen);
  }

  /// Changed Texfield Actions
  void _onUserNameChanged(
      OnUserNameChangedEvent event, Emitter<AuthenticationState> emitter) {
    var signInEnabled = true;

    if (state.password != null) {
      signInEnabled = state.password!.isNotEmpty;
    } else {
      signInEnabled = false;
    }

    add(OnSignInEnableButtonEvent(
      enable: event.userName.isNotEmpty && signInEnabled,
    ));

    emitter(state.copyWith(
      userName: event.userName,
      showUserError: false,
    ));
  }

  void _onPasswordChanged(
      OnUserPasswordChangedEvent event, Emitter<AuthenticationState> emitter) {
    var signInEnabled = true;

    if (state.userName != null) {
      signInEnabled = state.userName!.isNotEmpty;
    } else {
      signInEnabled = false;
    }

    add(OnSignInEnableButtonEvent(
      enable: event.password.isNotEmpty && signInEnabled,
    ));
    emitter(state.copyWith(
      password: event.password,
      showUserError: false,
    ));
  }

  /// Toggle Actions
  void _toggleShowPassword(
      ToggleUserPasswordEvent event, Emitter<AuthenticationState> emitter) {
    emitter(state.copyWith(showPassword: event.showPassword));
  }

  void _enableSignInButton(
      OnSignInEnableButtonEvent event, Emitter<AuthenticationState> emitter) {
    emitter(state.copyWith(signInEnabled: event.enable));
  }

  ///Business Logic
  void _validateUserCredentials(
      OnUserValidationEvent event, Emitter<AuthenticationState> emitter) {
    final isValidUser = state.userName == AppConstants.defaultUserName &&
        state.password == AppConstants.defaultPassword;

    emitter(
      state.copyWith(
        isValidUser: isValidUser,
        showUserError: !isValidUser,
      ),
    );
  }

  void _navigationScreen(
      NavigationScreensEvent event, Emitter<AuthenticationState> emitter) {
    emitter(state.copyWith(screenStatus: event.moveToScreen));
  }
}
