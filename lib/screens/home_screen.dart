import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/blocs/blocs.dart';
import 'package:todos/screens/filtered_todos.dart';
import 'package:todos/todo_app_core/injector.dart';
import 'package:todos/todo_app_core/todos_app_core.dart';
import 'package:todos/todo_app_core/visibility_filter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  late final List<FilteredTodosBloc> _filterTodosBlocs;

  @override
  void initState() {
    _filterTodosBlocs = [
      FilteredTodosBloc(
        todosBloc: context.read<TodosBloc>(),
        filterTodosUsecase: inject(),
      )..add(FilterUpdated(VisibilityFilter.all)),
      FilteredTodosBloc(
        todosBloc: context.read<TodosBloc>(),
        filterTodosUsecase: inject(),
      )..add(FilterUpdated(VisibilityFilter.active)),
      FilteredTodosBloc(
        todosBloc: context.read<TodosBloc>(),
        filterTodosUsecase: inject(),
      )..add(FilterUpdated(VisibilityFilter.completed)),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _filterTodosBlocs.forEach((bloc) => bloc.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppTitle(_selectedTab)),
      ),
      body: BlocProvider.value(
        // add key so the framework knows to replace the widget, not retain it
        key: ValueKey(_selectedTab),
        value: _filterTodosBlocs[_selectedTab],
        child: FilteredTodos(),
      ),
      floatingActionButton: FloatingActionButton(
        key: TodoAppKeys.addTodoFab,
        onPressed: () {
          Navigator.pushNamed(context, TodoAppRoutes.addTodo);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => setState(() => _selectedTab = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.view_list), label: 'All'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: 'Cancel'),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist), label: 'Completed'),
        ],
      ),
    );
  }

  String _getAppTitle(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return 'All';
      case 1:
        return 'Incomplete';
      case 2:
        return 'Complete';
      default:
        return '';
    }
  }
}
