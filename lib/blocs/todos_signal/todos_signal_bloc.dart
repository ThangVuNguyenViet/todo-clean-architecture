import 'package:bloc/bloc.dart';

import 'todos_signal_event.dart';
import 'todos_signal_state.dart';

class TodoSignalBloc extends Bloc<TodoSignalEvent, TodoSignalState> {
  TodoSignalBloc() : super(TodoSignalInitial()) {
    on<TodoSignalAdded>((event, emit) => TodoCreatedSuccess(event.todo));
    on<TodoSignalUpdated>((event, emit) => TodoUpdatedSuccess(event.todo));
    on<TodoSignalDeleted>((event, emit) => TodoDeletedSuccess(event.todo));
  }
}
