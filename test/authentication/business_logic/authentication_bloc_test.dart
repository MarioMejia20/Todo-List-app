import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/src/core/app_constants.dart';
import 'package:todo/src/features/authentication/business_logic/bloc/authentication_bloc.dart';

import '../mocks/mock_authentication_state.dart';

void main() {
  group('AuthenticationBlocTest', () {
    late AuthenticationBloc authenticationBloc;

    setUp(() {
      authenticationBloc = AuthenticationBloc();
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'AuthenticationBlocTest - SignInValidation Success',
      seed: () => mockSignInValidation.copyWith(
        userName: AppConstants.defaultUserName,
        password: AppConstants.defaultPassword,
      ),
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(OnUserValidationEvent()),
      expect: () => [
        isA<AuthenticationState>()
            .having((s) => s.isValidUser, 'isValidUser', true)
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'AuthenticationBlocTest - SignInValidation Fail',
      seed: () => mockSignInValidation.copyWith(
        userName: 'TestUser',
        password: 'Test123',
      ),
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(OnUserValidationEvent()),
      expect: () => [
        isA<AuthenticationState>()
            .having((s) => s.isValidUser, 'isValidUser', false)
      ],
    );
  });
}
