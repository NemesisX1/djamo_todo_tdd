part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodosState {}

class TodosIsLoading extends TodosState {}

class TodoLoaded extends TodosState {}

class TodoError extends TodosState {
  final String errorMessage;

  const TodoError(this.errorMessage);
}

class TodoFetched extends TodosState {
  final List<Todo> todos;
  const TodoFetched(this.todos);
}

class TodoCommentsFetched extends TodosState {
  final List<TodoComment> todos;
  const TodoCommentsFetched(this.todos);
}
