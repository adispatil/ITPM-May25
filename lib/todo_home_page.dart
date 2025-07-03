import 'package:flutter/material.dart';

import 'add_todo.dart';
import 'todo_details.dart';
import 'todo_list.dart';
import 'todo_model.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todo> _todos = [];
  int _nextId = 0;

  void _addTodo(String title, String description) {
    setState(() {
      _todos.add(Todo(
        id: _nextId++,
        title: title,
        description: description,
        createdAt: DateTime.now(),
      ));
    });
  }

  void _removeTodo(int id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  void _toggleTodo(int id) {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.isDone = !todo.isDone;
      if (todo.isDone) {
        todo.doneAt = DateTime.now();
      } else {
        todo.doneAt = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Todo App')),
      body: Center(
        child: Column(
          children: [
            TodoList(
              todos: _todos,
              onToggle: _toggleTodo,
              onDelete: _removeTodo,
              onTap: (todo) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoDetails(todo: todo),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.45,
                  ),
                  child: AddTodo(
                    onAdd: (title, desc) {
                      Navigator.of(context).pop();
                      _addTodo(title, desc);
                    },
                  ),
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}