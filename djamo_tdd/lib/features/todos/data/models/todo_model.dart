import 'package:djamo_tdd/features/todos/domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required userId,
    required id,
    required title,
    required body,
  }) : super(
          userId: userId,
          id: id,
          title: title,
          body: body,
        );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
