import 'dart:async';

import 'package:djamo_tdd/features/todos/domain/entities/todo.dart';
import 'package:djamo_tdd/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:djamo_tdd/features/todos/presentation/pages/todo_details_view.dart';
import 'package:djamo_tdd/features/todos/presentation/pages/todos_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => TodoDetailsView(todo: todo))),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<TodosBloc>(context).add(
                        TodoEventDeleteTodo(
                          id: todo.id!,
                          callback: () {
                            Timer(
                              Duration(seconds: 1),
                              () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => const TodoView()),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    todo.title.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    todo.body.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
