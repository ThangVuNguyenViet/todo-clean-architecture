import 'package:todos/domain/domain.dart';
import 'package:todos/domain/usecases/abstract_usecase.dart';
import 'package:todos/todo_app_core/visibility_filter.dart';

class FilterTodosUsecase extends UseCase<List<Todo>, FilterTodosUsecaseParams> {
  const FilterTodosUsecase();

  @override
  List<Todo> call({required FilterTodosUsecaseParams params}) {
    return params.todos.where((todo) {
      if (params.filter == VisibilityFilter.all) {
        return true;
      } else if (params.filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }
}

class FilterTodosUsecaseParams {
  final VisibilityFilter filter;
  final List<Todo> todos;

  FilterTodosUsecaseParams(this.todos, this.filter);
}
