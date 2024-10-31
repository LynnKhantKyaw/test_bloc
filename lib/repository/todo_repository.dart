import 'package:test_bloc/model/todo_model.dart';

class TodoRepository {
  List<TodoModel> todoList = [];

  Future<List<TodoModel>> getTodoList(String? search) async {
    int statusCode = 200;

    await Future.delayed(const Duration(seconds: 2));

    if (statusCode == 200) {
      if (search == null) {
        return todoList;
      }

      return todoList.where((e) => e.todo.toLowerCase().contains(search.toLowerCase())).toList();
    } else if (statusCode == 500) {
      throw 'Server error';
    } else {
      throw 'e sar';
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    return todoList.add(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    todo.isCompleted = !todo.isCompleted;
  }

  Future<void> deleteTodo(int id) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    return todoList.removeWhere((e) => e.id == id);
  }
}
