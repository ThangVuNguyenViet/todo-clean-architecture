import 'package:todos/domain/domain.dart';

class CreateTodoUsecase extends Usecase<Future<Todo>, Todo> {
  final TodosRepository repository;

  const CreateTodoUsecase({required this.repository});

  @override
  Future<Todo> call({required Todo params}) {
    return repository.saveTodo(params);
  }
}
