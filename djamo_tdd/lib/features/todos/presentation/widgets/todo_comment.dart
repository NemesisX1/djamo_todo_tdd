import 'package:djamo_tdd/features/todos/domain/entities/todo_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class TodoCommentWidget extends StatelessWidget {
  final TodoComment comment;
  const TodoCommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${comment.name}(${comment.email!})",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(5),
          Text(comment.body!),
          const Gap(5),
          const Divider()
        ],
      ),
    );
  }
}
