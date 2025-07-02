import 'package:flutter/material.dart';
import 'todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final void Function() onToggle;
  final void Function() onDelete;
  final void Function()? onTap;
  const TodoItem({super.key, required this.todo, required this.onToggle, required this.onDelete, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 64,
              decoration: BoxDecoration(
                color: todo.isDone ? Colors.green : Colors.blueAccent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                onTap: onTap,
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => onToggle(),
                  activeColor: Colors.blueAccent,
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(
                  todo.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: onDelete,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 