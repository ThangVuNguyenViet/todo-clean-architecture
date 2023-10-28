import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/presenter/blocs/todos_signal/todos.dart';
import 'package:todos/presenter/todo_app_core/todos_app_core.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final OnSaveCallback onSave;
  final Todo? todo;

  AddEditScreen({
    Key? key,
    required this.onSave,
    this.todo,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task = '';
  String _note = '';

  bool get isEditing => widget.todo != null;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Todo' : 'Add Todo',
        ),
      ),
      body: BlocListener<TodoSignalBloc, TodoSignalState>(
        listener: (context, state) {
          if ((isEditing && state is TodoUpdatedSuccess) ||
              (!isEditing && state is TodoCreatedSuccess))
            Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: isEditing ? widget.todo?.task : '',
                  key: TodoAppKeys.taskField,
                  autofocus: !isEditing,
                  style: textTheme.headlineSmall,
                  decoration: InputDecoration(
                    hintText: 'New Todo',
                  ),
                  validator: (val) {
                    return val != null && val.trim().isEmpty
                        ? 'Empty Todo'
                        : null;
                  },
                  onSaved: (value) => _task = value ?? '',
                ),
                TextFormField(
                  initialValue: isEditing ? widget.todo?.note : '',
                  key: TodoAppKeys.noteField,
                  maxLines: 10,
                  style: textTheme.titleMedium,
                  decoration: InputDecoration(
                    hintText: 'Note',
                  ),
                  onSaved: (value) => _note = value ?? '',
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            widget.onSave(_task, _note);
          }
        },
      ),
    );
  }
}
