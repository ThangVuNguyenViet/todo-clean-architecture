import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/blocs/blocs.dart';
import 'package:todos/todo_app_core/visibility_filter.dart';

import '../filtered_todos.dart';

class CompleteTodosTab extends StatefulWidget {
  const CompleteTodosTab({Key? key}) : super(key: key);

  @override
  _CompleteTodosTabState createState() => _CompleteTodosTabState();
}

class _CompleteTodosTabState extends State<CompleteTodosTab> {
  late final FilteredTodosBloc bloc;
  @override
  void initState() {
    bloc = FilteredTodosBloc(
      todosBloc: context.read<TodosBloc>(),
    )..add(FilterUpdated(VisibilityFilter.completed));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: FilteredTodos(),
    );
  }
}
