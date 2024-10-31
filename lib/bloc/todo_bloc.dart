import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/bloc/todo_event.dart';
import 'package:test_bloc/bloc/todo_state.dart';
import 'package:test_bloc/main.dart';
import 'package:test_bloc/model/todo_model.dart';
import 'package:test_bloc/repository/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  TodoBloc(this._todoRepository) : super(TodoInitial()) {
    on<FetchTodoList>((event, emit) => _fetchTodo(emit));
    on<SearchTodoList>((event, emit) => searchTodo(emit, event.search));
    on<TodoAdd>((event, emit) => addTodo(emit, event.todo));
    on<TodoUpdate>((event, emit) => updateTodo(emit, event.todo));
    on<TodoDelete>((event, emit) => deleteTodo(emit, event.id));
  }

  _fetchTodo(Emitter emit) async {
    try {
      emit(TodoLoading());

      emit(TodoLoaded(todoList: _todoRepository.todoList));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  searchTodo(Emitter emit, String? search) async {
    try {
      emit(TodoLoading());

      final todoList = await _todoRepository.getTodoList(search);

      emit(TodoLoaded(todoList: todoList));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> addTodo(Emitter emit, TodoModel todo) async {
    try {
      emit(TodoLoading());

      await _todoRepository.addTodo(todo);

      await _fetchTodo(emit);

      Navigator.pop(navigatorKey.currentContext!);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  updateTodo(Emitter emit, TodoModel todo) async {
    try {
      await _todoRepository.updateTodo(todo);

      _fetchTodo(emit);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  deleteTodo(Emitter emit, int id) async {
    try {
      emit(TodoLoading());

      await _todoRepository.deleteTodo(id);

      _fetchTodo(emit);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}
