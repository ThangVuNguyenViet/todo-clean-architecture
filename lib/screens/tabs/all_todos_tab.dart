import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/blocs/blocs.dart';
import 'package:todos/todo_app_core/visibility_filter.dart';

import '../filtered_todos.dart';

class AllTodosTab extends StatefulWidget {
  const AllTodosTab({Key? key}) : super(key: key);

  @override
  _AllTodosTabState createState() => _AllTodosTabState();
}

class _AllTodosTabState extends State<AllTodosTab> {
  late final FilteredTodosBloc bloc;
  @override
  void initState() {
    bloc = FilteredTodosBloc(
      todosBloc: context.read<TodosBloc>(),
    )..add(FilterUpdated(VisibilityFilter.all));
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
