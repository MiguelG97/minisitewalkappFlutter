import 'package:get_it/get_it.dart';

class DI {
  static DI di = DI._internal();

  DI._internal();

  factory DI() {
    return di;
  }

  GetIt getIt = GetIt.I;
}
