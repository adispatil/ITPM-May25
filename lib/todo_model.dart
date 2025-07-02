class Todo {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  DateTime? doneAt;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.doneAt,
    this.isDone = false,
  });
} 