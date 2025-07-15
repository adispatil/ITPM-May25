import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'todo_model.dart';

class TodoDatabase {
  // Private constructor for singleton
  TodoDatabase._privateConstructor();
  // The single instance of the class
  static final TodoDatabase instance = TodoDatabase._privateConstructor();

  // The database instance
  static Database? _database;

  // Getter for the database, initializes if null
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    // Get the path to the documents directory
    final dbPath = await getDatabasesPath();
    // Set the path for the todo database file
    final path = join(dbPath, 'todo.db');
    // Open the database, creating the table if it doesn't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the todos table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        doneAt TEXT,
        isDone INTEGER NOT NULL
      )
    ''');
  }

  // Insert a new todo into the database
  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    // Insert the todo and return the new id
    return await db.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch all todos from the database
  Future<List<Todo>> getTodos() async {
    final db = await database;
    // Query all rows in the todos table
    final maps = await db.query('todos', orderBy: 'createdAt DESC');
    // Convert the List<Map<String, dynamic>> to List<Todo>
    return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
  }

  // Update an existing todo
  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    // Update the todo with the given id
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Delete a todo by id
  Future<int> deleteTodo(int id) async {
    final db = await database;
    // Delete the row with the given id
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
} 