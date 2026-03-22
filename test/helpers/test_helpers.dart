import 'package:get_it/get_it.dart';

void resetGetIt() { if (GetIt.I.isRegistered<Object>()) GetIt.I.reset(); }
void registerMock<T extends Object>(T mock) {
  final sl = GetIt.I;
  if (sl.isRegistered<T>()) sl.unregister<T>();
  sl.registerLazySingleton<T>(() => mock);
}
