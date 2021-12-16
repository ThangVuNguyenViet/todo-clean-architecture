import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/presenter/blocs/blocs.dart';
import 'package:todos/presenter/screens/screens.dart';
import 'package:todos/presenter/widgets/widgets.dart';

class FilteredTodos extends StatefulWidget {
  FilteredTodos({Key? key}) : super(key: key);

  @override
  _FilteredTodosState createState() => _FilteredTodosState();
}

class _FilteredTodosState extends State<FilteredTodos> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosBloc, TodosState>(
      listener: (context, state) {
        if (state is TodosDeletedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            DeleteTodoSnackBar(
              todo: state.todo,
            ),
          );
        }
      },
      child: BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
        builder: (context, state) {
          if (state is FilteredTodosLoadInProgress) {
            return LoadingIndicator();
          } else if (state is FilteredTodosLoadSuccess) {
            final todos = state.filteredTodos;

            if (todos.isEmpty) {
              return Center(child: Text('There is no Todo task here'));
            }
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = todos[index];
                return TodoItem(
                  todo: todo,
                  onDismissed: (direction) {
                    BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
                  },
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return AddEditScreen(
                        onSave: (task, note) => context
                            .read<TodosBloc>()
                            .add(TodoUpdated(todo.copyWith(
                              task: task,
                              note: note,
                            ))),
                        todo: todo,
                      );
                    }),
                  ),
                  onCheckboxChanged: (complete) {
                    BlocProvider.of<TodosBloc>(context).add(
                      TodoUpdated(todo.copyWith(complete: complete)),
                    );
                  },
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
