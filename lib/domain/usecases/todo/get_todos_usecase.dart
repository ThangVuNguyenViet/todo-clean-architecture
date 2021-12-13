import 'package:todos/domain/domain.dart';
import 'package:todos/domain/repositories/todos_repository.dart';
import 'package:todos/domain/usecases/abstract_usecase.dart';

class GetTodosUsecase extends UseCase<List<Todo>, void> {
  final TodosRepository repository;

  const GetTodosUsecase({required this.repository});

  @override
  Future<List<Todo>> call({void params}) {
    return repository.loadTodos();
  }
}
