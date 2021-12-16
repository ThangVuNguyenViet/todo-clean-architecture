import 'package:equatable/equatable.dart';
import 'package:todos/domain/domain.dart';

abstract class TodoSignalState extends Equatable {
  const TodoSignalState();

  @override
  List<Object> get props => [];
}

class TodoSignalInitial extends TodoSignalState {}

class TodoExecuting extends TodoSignalState {}

class TodoCreatedSuccess extends TodoSignalState {
  final Todo todo;

  const TodoCreatedSuccess(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodoUpdatedSuccess extends TodoSignalState {
  final Todo todo;

  const TodoUpdatedSuccess(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodoDeletedSuccess extends TodoSignalState {
  final Todo todo;

  const TodoDeletedSuccess(this.todo);
  @override
  List<Object> get props => [todo];
}
