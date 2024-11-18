import 'package:todo/src/core/app_constants.dart';
import 'package:todo/src/features/authentication/business_logic/bloc/authentication_bloc.dart';

final AuthenticationState authenticationStateInit = AuthenticationState();

final AuthenticationState mockSignInValidation =
    authenticationStateInit.copyWith(
  userName: AppConstants.defaultUserName,
  password: AppConstants.defaultPassword,
);
