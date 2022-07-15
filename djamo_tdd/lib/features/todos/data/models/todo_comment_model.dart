import 'package:djamo_tdd/features/todos/domain/entities/todo_comment.dart';
import 'package:djamo_tdd/features/todos/presentation/widgets/todo_comment.dart';

class TodoCommentModel extends TodoComment {
  const TodoCommentModel({
    required postId,
    required id,
    required name,
    required email,
    required body,
  }) : super(
          postId: postId,
          id: id,
          name: name,
          email: email,
          body: body,
        );

  factory TodoCommentModel.fromJson(Map<String, dynamic> json) {
    return TodoCommentModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }
}
