import 'dart:async';
import 'dart:developer';

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
  String _title = "";
  String _body = "";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              _title = value;
            });
          },
          decoration: const InputDecoration(
            hintText: "Title",
          ),
        ),
        TextField(
          onChanged: (value) {
            setState(() {
              _body = value;
            });
          },
          decoration: const InputDecoration(
            hintText: "Body",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // ignore: prefer_function_declarations_over_variables
            final callback = () {
              Timer(Duration(seconds: 1), () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const TodoView()),
                    (route) => false);
              });
            };
            if (widget.updateMode) {
              BlocProvider.of<TodosBloc>(context).add(
                TodoEventUpdateTodo(
                  title: _title,
                  body: _body,
                  id: widget.id!,
                  callback: callback,
                ),
              );
            } else {
              BlocProvider.of<TodosBloc>(context).add(
                TodoEventCreateTodo(
                  title: _title,
                  body: _body,
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
