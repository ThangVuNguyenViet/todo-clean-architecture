import 'package:flutter/material.dart';
import 'package:todos/domain/domain.dart';

class DeleteTodoSnackBar extends SnackBar {
  DeleteTodoSnackBar({
    Key? key,
    required Todo todo,
  }) : super(
          key: key,
          content: Text(
            'Deleted ${todo.task})',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
        );
}
