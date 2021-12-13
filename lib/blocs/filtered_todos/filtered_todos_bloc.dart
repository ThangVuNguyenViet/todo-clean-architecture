import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todos/blocs/blocs.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/todo_app_core/visibility_filter.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  late StreamSubscription todosSubscription;

  FilteredTodosBloc({required this.todosBloc})
      : super(FilteredTodosLoadInProgress()) {
    todosSubscription = todosBloc.stream.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc.state as TodosLoadSuccess).todos));
      }
    });
    print(todosSubscription);

    on<FilterUpdated>(_onFilterUpdatedToState);
    on<TodosUpdated>(_onTodosUpdatedToState);
  }

  Future<void> _onFilterUpdatedToState(
    FilterUpdated event,
    Emitter<FilteredTodosState> emit,
  ) async {
    final todos = todosBloc.state is TodosLoadSuccess
        ? _onTodosToFilteredTodos(
            (todosBloc.state as TodosLoadSuccess).todos,
            event.filter,
          )
        : <Todo>[];
    emit(FilteredTodosLoadSuccess(
      todos,
      event.filter,
    ));
  }

  Future<void> _onTodosUpdatedToState(
    TodosUpdated event,
    Emitter<FilteredTodosState> emit,
  ) async {
    final visibilityFilter = state is FilteredTodosLoadSuccess
        ? (state as FilteredTodosLoadSuccess).activeFilter
        : VisibilityFilter.all;
    emit(FilteredTodosLoadSuccess(
      _onTodosToFilteredTodos(
        (todosBloc.state as TodosLoadSuccess).todos,
        visibilityFilter,
      ),
      visibilityFilter,
    ));
  }

  List<Todo> _onTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
