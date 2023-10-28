import 'package:todos/domain/domain.dart';

class GetTodosUsecase extends UsecaseNoParam<Future<List<Todo>>> {
  final TodosRepository repository;

  const GetTodosUsecase({required this.repository});

  @override
  Future<List<Todo>> call() {
    return repository.loadTodos();
  }
}
