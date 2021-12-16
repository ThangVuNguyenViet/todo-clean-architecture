import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/domain/domain.dart';
import 'package:todos/domain/usecases/usecase.dart';
import 'package:todos/presenter/blocs/blocs.dart';

class MockCreateTodoUsecase extends Mock implements CreateTodoUsecase {}

class MockGetTodosUsecase extends Mock implements GetTodosUsecase {}

class MockUpdateTodoUsecase extends Mock implements UpdateTodoUsecase {}

class MockRemoveTodoUsecase extends Mock implements RemoveTodoUsecase {}

class MockTodo extends Mock implements Todo {}

void main() {
  group('TodosBloc', () {
    late TodosBloc todosBloc;

    setUp(() {
      registerFallbackValue(MockTodo());
      todosBloc = TodosBloc(
        MockCreateTodoUsecase(),
        MockGetTodosUsecase(),
        MockUpdateTodoUsecase(),
        MockRemoveTodoUsecase(),
      );
      when(() => todosBloc.getTodosUsecase())
          .thenAnswer((_) => Future.value([]));
      when(() =>
              todosBloc.createTodoUsecase(params: any<Todo>(named: "params")))
          .thenAnswer(returnTodoFromParam);
      when(() =>
              todosBloc.updateTodoUsecase(params: any<Todo>(named: "params")))
          .thenAnswer(returnTodoFromParam);
      when(() =>
              todosBloc.removeTodoUsecase(params: any<Todo>(named: "params")))
          .thenAnswer(returnTodoFromParam);
    });

    blocTest<TodosBloc, TodosState>(
      'should return empty list of todos in response to a TodosLoaded event',
      build: () => todosBloc,
      act: (TodosBloc bloc) async => bloc.add(TodosLoaded()),
      expect: () => <TodosState>[
        TodosLoadInProgress(),
        TodosLoadSuccess([]),
      ],
    );

    blocTest<TodosBloc, TodosState>(
      'should add a todo to the list in response to an TodoAdded Event',
      build: () => todosBloc,
      act: (TodosBloc bloc) async =>
          bloc..add(TodosLoaded())..add(TodoAdded(Todo(task: 'Hallo'))),
      expect: () => <TodosState>[
        TodosLoadInProgress(),
        TodosLoadSuccess([]),
        TodosLoadSuccess([Todo(task: 'Hallo')]),
      ],
    );

    blocTest<TodosBloc, TodosState>(
      'should update the todo in response to an TodoUpdated Event',
      build: () {
        when(() => todosBloc.getTodosUsecase()).thenAnswer(
          (_) => Future.value([Todo(task: 'Hallo', id: '1')]),
        );
        return todosBloc;
      },
      act: (TodosBloc bloc) async => bloc
        ..add(TodosLoaded())
        ..add(TodoUpdated(
          Todo(task: 'Hello', id: '1', complete: true),
        )),
      expect: () => <TodosState>[
        TodosLoadInProgress(),
        TodosLoadSuccess([Todo(task: 'Hallo', id: '1')]),
        TodosLoadSuccess([Todo(task: 'Hello', id: '1', complete: true)]),
      ],
    );
    blocTest<TodosBloc, TodosState>(
      'should delete the todo in response to an TodoDeleted Event',
      build: () {
        when(() => todosBloc.getTodosUsecase()).thenAnswer(
          (_) => Future.value([Todo(task: 'Hallo', id: '1')]),
        );
        return todosBloc;
      },
      act: (TodosBloc bloc) async => bloc
        ..add(TodosLoaded())
        ..add(TodoDeleted(
          Todo(task: 'Hallo', id: '1'),
        )),
      expect: () => <TodosState>[
        TodosLoadInProgress(),
        TodosLoadSuccess([Todo(task: 'Hallo', id: '1')]),
        TodosLoadSuccess([]),
      ],
    );

    // blocTest<TodosBloc, TodosEvent, TodosState>(
    //   'should remove from the list in response to a DeleteTodo Event',
    //   build: () {
    //     when(todosRepository.loadTodos()).thenAnswer((_) => Future.value([]));
    //     return todosBloc;
    //   },
    //   act: (TodosBloc bloc) async {
    //     final todo = Todo('Hallo', id: '0');
    //     bloc..add(LoadTodos())..add(AddTodo(todo))..add(DeleteTodo(todo));
    //   },
    //   expect: <TodosState>[
    //     TodosLoading(),
    //     TodosLoaded([]),
    //     TodosLoaded([Todo('Hallo', id: '0')]),
    //     TodosLoaded([]),
    //   ],
    // );

    // blocTest<TodosBloc, TodosEvent, TodosState>(
    //   'should update a todo in response to an UpdateTodoAction',
    //   build: () => todosBloc,
    //   act: (TodosBloc bloc) async {
    //     final todo = Todo('Hallo', id: '0');
    //     bloc
    //       ..add(LoadTodos())
    //       ..add(AddTodo(todo))
    //       ..add(UpdateTodo(todo.copyWith(task: 'Tschüss')));
    //   },
    //   expect: <TodosState>[
    //     TodosLoading(),
    //     TodosLoaded([]),
    //     TodosLoaded([Todo('Hallo', id: '0')]),
    //     TodosLoaded([Todo('Tschüss', id: '0')]),
    //   ],
    // );
  });
}

Future<Todo> returnTodoFromParam(invocation) {
  final todo = invocation.namedArguments[Symbol("params")] as Todo;
  return Future.value(todo);
}
