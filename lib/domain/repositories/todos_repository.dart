import 'dart:core';

import 'package:todos/domain/domain.dart';

abstract class TodosRepository {
  Future<List<Todo>> loadTodos();
  Future<Todo> saveTodo(Todo todo);
  Future<Todo> updateTodo(Todo todo);
  Future<void> removeTodo(Todo todo);
}
