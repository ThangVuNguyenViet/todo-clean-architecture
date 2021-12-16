import 'package:flutter/material.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/presenter/todo_app_core/todos_app_core.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool?> onCheckboxChanged;
  final Todo todo;

  TodoItem({
    Key? key,
    required this.onDismissed,
    required this.onTap,
    required this.onCheckboxChanged,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todo.id == null) throw (Exception('Todo has not been created'));

    final todoId = todo.id!;

    return Dismissible(
      key: TodoAppKeys.todoItem(todoId),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: TodoAppKeys.todoItemCheckbox(todoId),
          value: todo.complete,
          onChanged: onCheckboxChanged,
        ),
        title: Hero(
          tag: '${todoId}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.task,
              key: TodoAppKeys.todoItemTask(todoId),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: todo.note.isNotEmpty
            ? Text(
                todo.note,
                key: TodoAppKeys.todoItemNote(todoId),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
