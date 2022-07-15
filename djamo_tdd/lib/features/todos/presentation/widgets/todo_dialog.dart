import 'dart:async';

import 'package:djamo_tdd/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:djamo_tdd/features/todos/presentation/pages/todos_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoDialog extends StatefulWidget {
  const TodoDialog({Key? key, this.updateMode = false, this.id})
      : super(key: key);

  final bool updateMode;
  final int? id;
  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            hintText: "Title",
          ),
        ),
        TextField(
          controller: _bodyController,
          decoration: const InputDecoration(
            hintText: "Body",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // ignore: prefer_function_declarations_over_variables
            final callback = () {
              Timer(Duration(seconds: 2), () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const TodoView()),
                    (route) => false);
              });
            };
            if (widget.updateMode) {
              BlocProvider.of<TodosBloc>(context).add(
                TodoEventUpdateTodo(
                  title: _titleController.text,
                  body: _bodyController.text,
                  id: widget.id!,
                  callback: callback,
                ),
              );
            } else {
              BlocProvider.of<TodosBloc>(context).add(
                TodoEventCreateTodo(
                  title: _titleController.text,
                  body: _bodyController.text,
                  callback: callback,
                ),
              );
            }
          },
          child: Text(widget.updateMode ? 'Update' : 'Create'),
        ),
      ],
    );
  }
}
