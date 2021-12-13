import 'package:todos/data/models/todo_model.dart';

abstract class TodosLocalStorage {
  Future<void> init();
  Future<void> dispose();

  Future<List<TodoModel>> loadTodos();
  Future<void> saveTodo(TodoModel todo);
  Future<void> removeTodo(TodoModel todoModel);
}
