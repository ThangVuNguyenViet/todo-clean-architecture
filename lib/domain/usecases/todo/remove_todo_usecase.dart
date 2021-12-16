import 'package:todos/domain/domain.dart';
import 'package:todos/domain/repositories/todos_repository.dart';
import 'package:todos/domain/usecases/abstract_usecase.dart';

class RemoveTodoUsecase extends Usecase<void, Todo> {
  final TodosRepository repository;

  const RemoveTodoUsecase({required this.repository});

  @override
  Future<void> call({required Todo params}) {
    return repository.removeTodo(params);
  }
}
