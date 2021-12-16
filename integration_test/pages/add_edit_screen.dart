import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/presenter/todo_app_core/todos_app_core.dart';

import 'home_screen.dart';

class AddEditScreen {
  final WidgetTester tester;

  AddEditScreen(this.tester);

  Future<HomeScreen> fillTodoAndSubmit(String task, String note) async {
    final taskEditor = find.byKey(TodoAppKeys.taskField);
    final noteEditor = find.byKey(TodoAppKeys.noteField);

    await tester.enterText(taskEditor, task);
    await tester.enterText(noteEditor, note);

    Finder fab = find.byType(FloatingActionButton);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    return HomeScreen(tester);
  }
}
