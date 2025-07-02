import 'package:flutter/material.dart';
import 'todo_model.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final void Function(int id) onToggle;
  final void Function(int id) onDelete;
  final void Function(Todo todo)? onTap;
  const TodoList({super.key, required this.todos, required this.onToggle, required this.onDelete, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32.0),
        child: Text('No todos yet!'),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoItem(
            todo: todo,
            onToggle: () => onToggle(todo.id),
            onDelete: () => onDelete(todo.id),
            onTap: onTap != null ? () => onTap!(todo) : null,
          );
        },
      ),
    );
  }
} 