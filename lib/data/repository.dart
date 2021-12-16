import 'dart:async';
import 'dart:core';

import 'package:todos/data/models/todo_model.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/domain/repositories/todos_repository.dart';
import 'package:uuid/uuid.dart';

import 'data_sources/local/local_storage.dart';

class TodosRepositoryImpl implements TodosRepository {
  final TodosLocalStorage localStorage;

  TodosRepositoryImpl({
    required this.localStorage,
  });

  @override
  Future<List<Todo>> loadTodos() async {
    return (await localStorage.loadTodos())
        .map((model) => model.toTodo)
        .toList();
  }

  /// Persists todos to local
  /// take a non-id [todo] to save to the db, return a [Todo] with id
  @override
  Future<Todo> saveTodo(Todo todo) async {
    final todoWithId = todo.id != null ? todo : todo.copyWith(id: Uuid().v4());

    await localStorage.saveTodo(TodoModel.fromTodo(todoWithId));
    return todoWithId;
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    await localStorage.saveTodo(TodoModel.fromTodo(todo));
    return todo;
  }

  @override
  Future<void> removeTodo(Todo todo) {
    return localStorage.removeTodo(TodoModel.fromTodo(todo));
  }
}
