import 'package:get_it/get_it.dart';
import 'package:todos/data/data.dart';
import 'package:todos/data/data_sources/local/local_storage.dart';
import 'package:todos/domain/repositories/todos_repository.dart';
import 'package:todos/domain/usecases/usecase.dart';

final inject = GetIt.instance;

Future<void> init() async {
  inject.registerSingletonAsync<TodosLocalStorage>(
    () async {
      final storage = TodosHiveLocalStorage();
      await storage.init();
      return storage;
    },
    dispose: (storage) => storage.dispose(),
  );

  await inject.allReady();
  inject.registerLazySingleton<TodosRepository>(
      () => TodosRepositoryImpl(localStorage: inject()));

  inject.registerFactory(() => CreateTodoUsecase(repository: inject()));
  inject.registerFactory(() => GetTodosUsecase(repository: inject()));
  inject.registerFactory(() => UpdateTodoUsecase(repository: inject()));
  inject.registerFactory(() => RemoveTodoUsecase(repository: inject()));
  inject.registerFactory(() => FilterTodosUsecase());
}
