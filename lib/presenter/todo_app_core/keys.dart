import 'package:flutter/widgets.dart';

class TodoAppKeys {
  // Home Screens
  static final tab = (int index) => Key('Tab__$index');

  // Todos
  static const todoList = Key('__todoList__');
  static const todosLoading = Key('__todosLoading__');
  static final todoItem = (String id) => Key('TodoItem__$id');
  static final todoItemCheckbox =
      (String id) => Key('TodoItem__${id}__Checkbox');
  static final todoItemTask = (String id) => Key('TodoItem__${id}__Task');
  static final todoItemNote = (String id) => Key('TodoItem__${id}__Note');

  // Add Screen
  static const taskField = Key('__taskField__');
  static const noteField = Key('__noteField__');
}
