import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class TaskRepository {
  final Database db;

  TaskRepository(this.db);

  Future<void> insertTask(Task task) async {
    final data = Map<String, Object?>.from(task.toMap());
    data.remove('id');
    await db.insert('task', data);
  }

  Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await db.query('task');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<void> updateTask(Task task) async {
    await db.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    await db.delete(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
