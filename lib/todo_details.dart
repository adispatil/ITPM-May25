import 'package:flutter/material.dart';
import 'todo_model.dart';
import 'package:intl/intl.dart';

class TodoDetails extends StatelessWidget {
  final Todo todo;
  const TodoDetails({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('yyyy-MM-dd – kk:mm').format(todo.createdAt);
    final doneStr = todo.doneAt != null
        ? DateFormat('yyyy-MM-dd – kk:mm').format(todo.doneAt!)
        : null;
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Details')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.blueAccent, size: 20),
                const SizedBox(width: 6),
                Text(
                  'Created: $dateStr',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            if (doneStr != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    'Marked done: $doneStr',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 28),
            Text(
              todo.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
} 