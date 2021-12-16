import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos/data/models/todo_model.dart';
import 'package:todos/domain/domain.dart';

import 'local_storage.dart';

/// Loads and saves a List of Todos using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class TodosHiveLocalStorage implements TodosLocalStorage {
  static const _kTodosHiveBoxName = 'todos';

  const TodosHiveLocalStorage();

  @override
  Future<void> init() async {
    Hive.registerAdapter(TodoModelAdapter());

    await Hive.initFlutter();
    await Hive.openBox(_kTodosHiveBoxName);
  }

  @override
  Future<List<TodoModel>> loadTodos() async {
    final box = Hive.box(_kTodosHiveBoxName);

    final List<TodoModel> todos = box.values.toList().cast();

    return Future.value(todos);
  }

  @override
  Future<Todo> saveTodo(TodoModel todo) async {
    final box = Hive.box(_kTodosHiveBoxName);

    await box.put(todo.id, todo);
    return box.get(todo.id);
  }

  @override
  Future<void> removeTodo(TodoModel todo) {
    final box = Hive.box(_kTodosHiveBoxName);

    return box.delete(todo.id);
  }

  @override
  Future<void> dispose() async {
    Hive.close();
  }
}
