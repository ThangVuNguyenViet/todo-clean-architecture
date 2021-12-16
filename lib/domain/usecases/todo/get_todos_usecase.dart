import 'package:todos/domain/domain.dart';
import 'package:todos/domain/repositories/todos_repository.dart';
import 'package:todos/domain/usecases/abstract_usecase.dart';

class GetTodosUsecase extends UsecaseNoParam<Future<List<Todo>>> {
  final TodosRepository repository;

  const GetTodosUsecase({required this.repository});

  @override
  Future<List<Todo>> call() {
    return repository.loadTodos();
  }
}
