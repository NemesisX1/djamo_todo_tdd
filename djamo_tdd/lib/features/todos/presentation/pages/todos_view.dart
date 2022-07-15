import 'dart:async';
import 'dart:developer';

import 'package:djamo_tdd/features/todos/data/models/todo_model.dart';
import 'package:djamo_tdd/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:djamo_tdd/features/todos/presentation/pages/todo_details_view.dart';
import 'package:djamo_tdd/features/todos/presentation/widgets/todo_dialog.dart';
import 'package:djamo_tdd/features/todos/presentation/widgets/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TodoView extends StatefulWidget {
  const TodoView({
    Key? key,
  }) : super(key: key);

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final TodosBloc _todosBloc = TodosBloc();

  @override
  void initState() {
    _todosBloc.add(TodoEventFetchTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => _todosBloc,
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TodoFetched) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: List<TodoWidget>.generate(
                      state.todos.length,
                      (index) {
                        return TodoWidget(
                          todo: state.todos[index],
                        );
                      },
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: TodoDialog(),
            );
          },
        ),
        tooltip: '',
        child: const Icon(Icons.add),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
