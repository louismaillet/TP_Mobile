import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';
import '../repository/taskrepository.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> liste = [];
  late TaskRepository _repository;

  TaskViewModel(Database db) {
    _repository = TaskRepository(db);
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    liste = await _repository.getTasks();
    notifyListeners();
  }

  void addTask(Task task) async {
    await _repository.insertTask(task);
    await _loadTasks();
  }

  void deleteTask(int index) async {
    if (index >= 0 && index < liste.length) {
      Task task = liste[index];
      await _repository.deleteTask(task.id);
      await _loadTasks();
    }
  }

  void updateTask(Task oldTask, Task newTask) async {
    await _repository.updateTask(newTask);
    await _loadTasks();
  }
}