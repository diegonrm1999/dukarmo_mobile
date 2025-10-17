import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

void registerSingleton<T extends Object>(T instance) {
  _getIt.registerSingleton<T>(instance);
}

T getSingleton<T extends Object>() {
  return _getIt.get<T>();
}

void registerLazySingleton<T extends Object>(T Function() instance) {
  _getIt.registerLazySingleton<T>(instance);
}

void removeSingleton<T extends Object>() {
  _getIt.unregister<T>();
}
