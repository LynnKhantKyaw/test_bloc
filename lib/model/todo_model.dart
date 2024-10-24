class TodoModel {
  final int id;
  final String todo;
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.todo,
    this.isCompleted = false,
  });
}
