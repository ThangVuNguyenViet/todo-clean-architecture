import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/presenter/todo_app_core/todos_app_core.dart';
import 'package:todos/presenter/widgets/widgets.dart';

import 'add_edit_screen.dart';

class HomeScreen {
  final WidgetTester tester;

  HomeScreen(this.tester);

  Future<AddEditScreen> goToCreateTodoScreen() async {
    final fab = find.byType(FloatingActionButton);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    return AddEditScreen(tester);
  }

  Future<AddEditScreen> goToUpdateTodoScreen(Todo todo) async {
    final todoItem = find.byKey(TodoAppKeys.todoItem(todo.id!));
    await tester.tap(todoItem);
    await tester.pumpAndSettle();

    return AddEditScreen(tester);
  }

  Future<void> updateStatusTodo(Todo todo) async {
    final todoCheckboxFinder =
        find.byKey(TodoAppKeys.todoItemCheckbox(todo.id!));
    await tester.tap(todoCheckboxFinder);
    await tester.pumpAndSettle();

    final todoItemCheckbox = tester.firstWidget(todoCheckboxFinder) as Checkbox;

    expect(todoItemCheckbox.value, equals(!todo.complete));
  }

  Todo findTodoByTask(String task) {
    final todoItemFinder = find.byWidgetPredicate(
        (widget) => widget is TodoItem && widget.todo.task == task);
    final todoItem = tester.firstWidget(todoItemFinder) as TodoItem;

    return todoItem.todo;
  }

  Future<void> deleteTodo(Todo todo) async {
    final todoItem = find.byKey(TodoAppKeys.todoItem(todo.id!));

    await tester.drag(todoItem, const Offset(500.0, 0.0));
    await tester.pumpAndSettle();
  }

  // verify length of displayed items and the status
  void verifyAllItemsStatus(int length, bool complete) {
    final todoItems =
        tester.widgetList(find.byType(TodoItem)).toList().cast<TodoItem>();

    expect(todoItems.length, equals(length));
    expect(todoItems.every((item) => item.todo.complete == complete), true);
  }

  void verifItems(int length, bool Function(Todo) predicate) {
    try {
      final todoItems =
          tester.widgetList(find.byType(TodoItem)).toList().cast<TodoItem>();

      expect(todoItems.where((todoItem) => predicate(todoItem.todo)).length,
          equals(length));
    } catch (e) {
      return expect(length, 0);
    }
  }

  Future<void> switchTap(int index) async {
    final tabFinder = find.byKey(TodoAppKeys.tab(index));

    await tester.tap(tabFinder);
    await tester.pumpAndSettle();
  }
}
