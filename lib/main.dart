import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/presenter/blocs/blocs.dart';
import 'package:todos/presenter/blocs/todos_signal/todos.dart';
import 'package:todos/presenter/screens/screens.dart';
import 'package:todos/presenter/todo_app_core/injector.dart' as di;

import 'presenter/todo_app_core/todos_app_core.dart';

Future<void> main() async {
  // We can set a Bloc's observer to an instance of `SimpleBlocObserver`.
  // This will allow us to handle all transitions and errors in SimpleBlocObserver.
  await di.init();

  BlocOverrides.runZoned(() => {}, blocObserver: SimpleBlocObserver());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoSignalBloc()),
        BlocProvider(
          create: (context) {
            return TodosBloc(
              di.inject(),
              di.inject(),
              di.inject(),
              di.inject(),
              signalBloc: context.read(),
            )..add(TodosLoaded());
          },
          lazy: false,
        ),
      ],
      child: TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      theme: TodoAppTheme.theme,
      routes: {
        TodoAppRoutes.home: (context) {
          return HomeScreen();
        },
        TodoAppRoutes.addTodo: (context) {
          return AddEditScreen(
            onSave: (task, note) {
              BlocProvider.of<TodosBloc>(context).add(
                TodoAdded(Todo(task: task, note: note)),
              );
            },
          );
        },
      },
    );
  }
}
