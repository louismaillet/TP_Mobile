import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../models/task.dart';

class DetailScreenTodo extends StatelessWidget {
  const DetailScreenTodo({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.title),
      ),
    );
  }
}

class DetailScreenTask extends StatelessWidget {
  const DetailScreenTask({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(task.description),
      ),
    );
  }
}