import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:djamo_tdd/features/todos/data/datasources/todo_remote_datasources.dart';
import 'package:djamo_tdd/features/todos/domain/entities/todo.dart';
import 'package:djamo_tdd/features/todos/domain/entities/todo_comment.dart';
import 'package:djamo_tdd/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitial()) {
    final remoteData = locator<TodoRemoteDataSourceImpl>();

    on<TodoEventFetchTodos>((event, emit) async {
      try {
        emit(TodosIsLoading());
        final todos = await remoteData.getTodos();
        emit(TodoFetched(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
        log(e.toString());
      }
    });

    on<TodoEventCreateTodo>((event, emit) async {
      log("Create event called");
      try {
        emit(TodosIsLoading());

        await remoteData
            .createTodo(
          title: event.title,
          body: event.body,
        )
            .then((value) {
          log("Created");
        });
        emit(TodoLoaded());
        if (event.callback != null) {
          event.callback!.call();
        }
      } catch (e) {
        emit(TodoError(e.toString()));
        log("create " + e.toString());
      }
    });

    on<TodoEventUpdateTodo>((event, emit) async {
      log(event.title);
      log("update is called");
      try {
        emit(TodosIsLoading());
        await remoteData
            .updateTodo(
          id: event.id,
          title: event.title,
          body: event.body,
        )
            .then(
          (value) {
            log("Updated");
          },
        );
        emit(TodoLoaded());
        if (event.callback != null) {
          event.callback!.call();
        }
      } catch (e) {
        emit(TodoError(e.toString()));
        log("update " + e.toString());
      }
    });

    on<TodoEventFetchTodoComment>((event, emit) async {
      try {
        emit(TodosIsLoading());
        final todos = await remoteData.getTodoCommentById(event.id);

        emit(TodoCommentsFetched(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
        log(e.toString());
      }
    });

    on<TodoEventDeleteTodo>((event, emit) async {
      try {
        emit(TodosIsLoading());
        final todos = await remoteData.deleteTodo(id: event.id);

        emit(TodoLoaded());
      } catch (e) {
        emit(TodoError(e.toString()));
        log(e.toString());
      }
    });
  }
}
