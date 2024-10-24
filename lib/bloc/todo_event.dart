import 'package:test_bloc/model/todo_model.dart';

abstract class TodoEvent {}

class FetchTodoList extends TodoEvent {}

class SearchTodoList extends TodoEvent {
  final String? search;

  SearchTodoList(this.search);
}

class TodoAdd extends TodoEvent {
  final TodoModel todo;

  TodoAdd(this.todo);
}

class TodoUpdate extends TodoEvent {
  final TodoModel todo;

  TodoUpdate(this.todo);
}

class TodoDelete extends TodoEvent {
  final int id;

  TodoDelete(this.id);
}
