import 'package:get_it/get_it.dart';

abstract class BaseModule {
  final GetIt sl;

  BaseModule(this.sl);
  Future<void> init();
}
