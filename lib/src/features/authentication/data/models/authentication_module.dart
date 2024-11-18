import 'package:get_it/get_it.dart';
import 'package:todo/src/core/injection/base_module.dart';
import 'package:todo/src/features/authentication/business_logic/bloc/authentication_bloc.dart';

class AuthenticationModule extends BaseModule {
  AuthenticationModule(GetIt sl) : super(sl);

  @override
  Future<void> init() async {
    sl.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc());
  }
}
