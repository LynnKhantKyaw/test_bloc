import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/bloc/todo_bloc.dart';
import 'package:test_bloc/bloc/todo_event.dart';
import 'package:test_bloc/bloc/todo_state.dart';
import 'package:test_bloc/model/todo_model.dart';
import 'package:test_bloc/presentation/todo_create.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Search...',
                suffixIcon: InkWell(
                  onTap: () {
                    search();
                  },
                  child: const Icon(Icons.search),
                ),
              ),
              onChanged: (value) {
                search();
              },
              onSubmitted: (value) {
                search();
              },
              controller: searchController,
            ),
            const SizedBox(height: 20),
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoInitial) {
                  return const Text('Waiting...');
                } else if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoError) {
                  return Text(state.message);
                } else if (state is TodoLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, _) => const SizedBox(height: 10),
                      itemCount: state.todoList.length,
                      itemBuilder: (context, index) {
                        final todo = state.todoList[index];

                        return Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 3,
                          child: ListTile(
                            leading: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (value) {
                                update(todo);
                              },
                            ),
                            title: Text(todo.todo),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () => delete(todo.id),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text('Something went wrong!');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => create(context),
      ),
    );
  }

  search() {
    context.read<TodoBloc>().add(SearchTodoList(searchController.text));
  }

  create(BuildContext ctx) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: ctx.read<TodoBloc>(),
        child: const TodoCreate(),
      ),
    );
  }

  update(TodoModel todo) {
    context.read<TodoBloc>().add(TodoUpdate(todo));
  }

  delete(int id) {
    context.read<TodoBloc>().add(TodoDelete(id));
  }
}
