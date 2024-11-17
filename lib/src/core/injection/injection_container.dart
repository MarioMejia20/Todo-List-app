import 'package:get_it/get_it.dart';
import 'package:todo/src/features/authentication/data/models/authentication_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  AuthenticationModule(sl).init();
}
