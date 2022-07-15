import 'package:djamo_tdd/features/todos/data/datasources/todo_remote_datasources.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  // Here you register all your services
  locator.registerLazySingleton(() => TodoRemoteDataSourceImpl());

  // Here you register all your viewmodels

  // Here you register your providers
}
