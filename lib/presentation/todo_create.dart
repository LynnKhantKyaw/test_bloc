import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/bloc/todo_bloc.dart';
import 'package:test_bloc/bloc/todo_event.dart';
import 'package:test_bloc/bloc/todo_state.dart';
import 'package:test_bloc/model/todo_model.dart';

class TodoCreate extends StatelessWidget {
  const TodoCreate({super.key});

  static final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      title: const Text('New Todo'),
      content: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Todo',
                ),
                controller: todoController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: state is TodoLoading
                    ? null
                    : () async {
                        final todo = TodoModel(
                          id: DateTime.now().microsecondsSinceEpoch,
                          todo: todoController.text,
                        );

                        context.read<TodoBloc>().add(TodoAdd(todo));
                      },
                child: state is TodoLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Confirm'),
              ),
            ],
          );
        },
      ),
    );
  }
}
