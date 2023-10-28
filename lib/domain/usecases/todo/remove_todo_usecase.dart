import 'package:todos/domain/domain.dart';

class RemoveTodoUsecase extends Usecase<void, Todo> {
  final TodosRepository repository;

  const RemoveTodoUsecase({required this.repository});

  @override
  Future<void> call({required Todo params}) {
    return repository.removeTodo(params);
  }
}
