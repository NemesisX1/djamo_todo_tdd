import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:djamo_tdd/features/todos/data/models/todo_comment_model.dart';
import 'package:djamo_tdd/features/todos/data/models/todo_model.dart';
import 'package:djamo_tdd/features/todos/domain/entities/todo_comment.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();

  Future<TodoModel?> getTodoById(int id);

  Future<List<TodoComment>> getTodoCommentById(int id);

  Future<TodoModel?> createTodo({required String title, required String body});

  Future<TodoModel?> updateTodo({
    required int id,
    String? title,
    String? body,
  });

  Future<TodoModel?> deleteTodo({
    required int id,
  });
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  @override
  Future<TodoModel?> createTodo(
      {required String title, required String body}) async {
    try {
      await dio.post('/posts', data: {
        "title": title,
        "body": body,
      }).then((value) {
        log(value.data.toString());
        return TodoModel.fromJson(value.data);
      });
    } catch (e) {
      log("create error $e");
      return null;
    }
    return null;
  }

  @override
  Future<TodoModel?> getTodoById(int id) async {
    try {
      await dio
          .get(
        '/posts/$id',
      )
          .then((value) {
        return TodoModel.fromJson(value.data);
      });
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    List<TodoModel> todos = [];
    try {
      await dio
          .get(
        '/posts',
      )
          .then((value) {
        for (var element in value.data) {
          todos.add(TodoModel.fromJson(element));
        }
        todos = todos.reversed.toList();
        return todos;
      });
    } catch (e) {
      log(e.toString());
      return todos;
    }
    return todos;
  }

  @override
  Future<TodoModel?> updateTodo({
    required int id,
    String? title,
    String? body,
  }) async {
    try {
      await dio.put('/posts/$id', data: {
        'title': title,
        'body': body,
      }).then((value) {
        return TodoModel.fromJson(value.data);
      });
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  @override
  Future<TodoModel?> deleteTodo({
    required int id,
  }) async {
    try {
      await dio
          .delete(
        '/posts/$id',
      )
          .then((value) {
        log(value.data);
        return TodoModel.fromJson(value.data);
      });
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<List<TodoComment>> getTodoCommentById(int id) async {
    List<TodoComment> comments = [];

    try {
      await dio
          .get(
        '/posts/$id/comments',
      )
          .then((value) {
        for (var element in value.data) {
          comments.add(TodoCommentModel.fromJson(element));
        }
        comments = comments.reversed.toList();
        return comments;
      });
    } catch (e) {
      log(e.toString());
      return comments;
    }
    return comments;
  }
}
