import 'package:test_bloc/model/todo_model.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todoList;

  TodoLoaded({required this.todoList});
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}
