import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task.dart';

final supabase = Supabase.instance.client;

class TaskRepository {
  final Database db;

  TaskRepository(this.db);

  Future<void> insertTask(Task task) async {
    final data = Map<String, Object?>.from(task.toMap());
    data.remove('id');

    await db.insert('tasks', data);
    if (task.connecterSupabase) {
      await supabase.from('task').insert({
        'title': task.title,
        'description': task.description,
        'tags': task.tags.join(','),
        'nbhours': task.nbhours,
        'difficulty': task.difficulty,
      });
    }
  }

  Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<void> updateTask(Task task) async {
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );

    if (task.connecterSupabase) {
      await supabase
          .from('task')
          .update({
            'title': task.title,
            'description': task.description,
            'tags': task.tags.join(','),
            'nbhours': task.nbhours,
            'difficulty': task.difficulty,
          })
          .eq('id', task.id);
    }
  }

  Future<void> deleteTask(int id) async {
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    await supabase.from('task').delete().eq('id', id);
  }
}
