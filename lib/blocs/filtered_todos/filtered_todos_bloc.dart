import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todos/blocs/blocs.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/domain/usecases/usecase.dart';
import 'package:todos/todo_app_core/visibility_filter.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  final FilterTodosUsecase filterTodosUsecase;

  late StreamSubscription todosSubscription;

  FilteredTodosBloc({
    required this.todosBloc,
    required this.filterTodosUsecase,
  }) : super(FilteredTodosLoadInProgress()) {
    todosSubscription = todosBloc.stream.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc.state as TodosLoadSuccess).todos));
      }
    });

    on<FilterUpdated>(_onFilterUpdatedToState);
    on<TodosUpdated>(_onTodosUpdatedToState);
  }

  Future<void> _onFilterUpdatedToState(
    FilterUpdated event,
    Emitter<FilteredTodosState> emit,
  ) async {
    final todos = todosBloc.state is TodosLoadSuccess
        ? filterTodosUsecase(
            params: FilterTodosUsecaseParams(
            (todosBloc.state as TodosLoadSuccess).todos,
            event.filter,
          ))
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
      filterTodosUsecase(
        params: FilterTodosUsecaseParams(
          (todosBloc.state as TodosLoadSuccess).todos,
          visibilityFilter,
        ),
      ),
      visibilityFilter,
    ));
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
