import 'package:djamo_tdd/features/todos/domain/entities/todo.dart';
import 'package:djamo_tdd/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:djamo_tdd/features/todos/presentation/widgets/todo_comment.dart';
import 'package:djamo_tdd/features/todos/presentation/widgets/todo_dialog.dart';
import 'package:djamo_tdd/features/todos/presentation/widgets/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TodoDetailsView extends StatefulWidget {
  const TodoDetailsView({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;
  @override
  State<TodoDetailsView> createState() => _TodoDetailsViewState();
}

class _TodoDetailsViewState extends State<TodoDetailsView> {
  final TodosBloc _todosBloc = TodosBloc();
  _TodoDetailsViewState();
  @override
  void initState() {
    _todosBloc.add(TodoEventFetchTodoComment(
      id: widget.todo.id!,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TodoWidget(todo: widget.todo),
          const Gap(20),
          Expanded(
            child: BlocProvider(
              create: (_) => _todosBloc,
              child: BlocBuilder<TodosBloc, TodosState>(
                builder: (context, state) {
                  if (state is TodosIsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TodoCommentsFetched) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List<TodoCommentWidget>.generate(
                            state.todos.length,
                            (index) {
                              return TodoCommentWidget(
                                comment: state.todos[index],
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: TodoDialog(
                updateMode: true,
                id: widget.todo.id,
              ),
            );
          },
        ),
        tooltip: '',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
