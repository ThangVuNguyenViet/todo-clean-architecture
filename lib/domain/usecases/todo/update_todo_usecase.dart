import 'package:todos/domain/domain.dart';

class UpdateTodoUsecase extends Usecase<void, Todo> {
  final TodosRepository repository;

  const UpdateTodoUsecase({required this.repository});

  @override
  Future<void> call({required Todo params}) {
    return repository.updateTodo(params);
  }
}
