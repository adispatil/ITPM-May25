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

  // Convert a Todo object into a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Unique id
      'title': title, // Todo title
      'description': description, // Todo description
      'createdAt': createdAt.toIso8601String(), // Creation date as ISO string
      'doneAt': doneAt?.toIso8601String(), // Done date as ISO string or null
      'isDone': isDone ? 1 : 0, // Store bool as int (1 or 0)
    };
  }

  // Create a Todo object from a Map (from database)
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int, // Unique id
      title: map['title'] as String, // Todo title
      description: map['description'] as String, // Todo description
      createdAt: DateTime.parse(map['createdAt'] as String), // Parse creation date
      doneAt: map['doneAt'] != null ? DateTime.tryParse(map['doneAt']) : null, // Parse done date if present
      isDone: (map['isDone'] as int) == 1, // Convert int to bool
    );
  }
} 