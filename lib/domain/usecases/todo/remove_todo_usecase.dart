import 'package:todos/domain/domain.dart';
import 'package:todos/domain/repositories/todos_repository.dart';
import 'package:todos/domain/usecases/abstract_usecase.dart';

class RemoveTodoUseCase extends UseCase<void, Todo> {
  final TodosRepository repository;

  const RemoveTodoUseCase({required this.repository});

  @override
  Future<void> call({required Todo params}) {
    return repository.removeTodo(params);
  }
}
