part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodoEventFetchTodo extends TodosEvent {}

class TodoEventFetchTodoComment extends TodosEvent {
  final int id;

  const TodoEventFetchTodoComment({
    required this.id,
  });
}

class TodoEventDeleteTodo extends TodosEvent {
  final int id;

  final Function()? callback;
  const TodoEventDeleteTodo({
    required this.id,
    this.callback,
  });
}

class TodoEventFetchTodos extends TodosEvent {}

class TodoEventUpdateTodo extends TodosEvent {
  final int id;
  final String title;
  final String body;
  final Function()? callback;

  const TodoEventUpdateTodo({
    required this.body,
    required this.id,
    required this.title,
    this.callback,
  });
}

class TodoEventCreateTodo extends TodosEvent {
  final String title;
  final String body;
  final Function()? callback;

  const TodoEventCreateTodo({
    required this.title,
    required this.body,
    this.callback,
  });
}
