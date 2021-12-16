import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/domain/usecases/usecase.dart';
import 'package:todos/presenter/blocs/todos/todos.dart';
import 'package:todos/presenter/blocs/todos_signal/todos.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final CreateTodoUsecase createTodoUsecase;
  final GetTodosUsecase getTodosUsecase;
  final UpdateTodoUsecase updateTodoUsecase;
  final RemoveTodoUsecase removeTodoUsecase;
  final TodoSignalBloc? signalBloc;

  TodosBloc(
    this.createTodoUsecase,
    this.getTodosUsecase,
    this.updateTodoUsecase,
    this.removeTodoUsecase, {
    this.signalBloc,
  }) : super(TodosLoadInProgress()) {
    on<TodosLoaded>(_onTodosLoaded);
    on<TodoAdded>(_onTodoAdded);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoDeleted>(_onTodoDeleted);
  }

  Future<void> _onTodosLoaded(
      TodosLoaded event, Emitter<TodosState> emit) async {
    emit(TodosLoadInProgress());
    loadTodos(emit);
  }

  Future<void> _onTodoAdded(TodoAdded event, Emitter<TodosState> emit) async {
    try {
      List<Todo>? oldTodos;
      if (state is TodosLoadSuccess) {
        oldTodos = (state as TodosLoadSuccess).todos;
      }
      final newTodo = await createTodoUsecase(params: event.todo);

      signalBloc?.add(TodoSignalAdded(newTodo));

      if (oldTodos != null) {
        final newTodos = List.of(oldTodos)..add(newTodo);
        emit(TodosLoadSuccess(newTodos));
      } else {
        await loadTodos(emit);
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      emit(TodosLoadFailure());
    }
  }

  Future<void> _onTodoUpdated(
      TodoUpdated event, Emitter<TodosState> emit) async {
    try {
      List<Todo>? oldTodos;
      if (state is TodosLoadSuccess) {
        oldTodos = (state as TodosLoadSuccess).todos;
      }

      await updateTodoUsecase(params: event.todo);

      signalBloc?.add(TodoSignalUpdated(event.todo));

      if (oldTodos != null) {
        final newTodos = List.of(oldTodos)
            .map((todo) => todo.id == event.todo.id ? event.todo : todo)
            .toList();
        emit(TodosLoadSuccess(newTodos));
      } else {
        await loadTodos(emit);
      }
    } catch (_) {
      emit(TodosLoadFailure());
    }
  }

  Future<void> _onTodoDeleted(
      TodoDeleted event, Emitter<TodosState> emit) async {
    try {
      List<Todo>? oldTodos;
      if (state is TodosLoadSuccess) {
        oldTodos = (state as TodosLoadSuccess).todos;
      }
      await removeTodoUsecase(params: event.todo);

      signalBloc?.add(TodoSignalDeleted(event.todo));

      if (oldTodos != null) {
        final newTodos = List.of(oldTodos)
          ..removeWhere((todo) => todo.id == event.todo.id);
        emit(TodosLoadSuccess(newTodos));
      } else {
        await loadTodos(emit);
      }
    } catch (_) {
      emit(TodosLoadFailure());
    }
  }

  Future<void> loadTodos(Emitter<TodosState> emit) async {
    try {
      final todos = await getTodosUsecase();
      emit(TodosLoadSuccess(todos));
    } catch (_) {
      emit(TodosLoadFailure());
    }
  }
}
