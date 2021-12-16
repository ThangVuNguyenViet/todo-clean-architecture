import 'package:todos/domain/domain.dart';
import 'package:todos/domain/repositories/todos_repository.dart';
import 'package:todos/domain/usecases/abstract_usecase.dart';

class CreateTodoUsecase extends Usecase<Future<Todo>, Todo> {
  final TodosRepository repository;

  const CreateTodoUsecase({required this.repository});

  @override
  Future<Todo> call({required Todo params}) {
    return repository.saveTodo(params);
  }
}
