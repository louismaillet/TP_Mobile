import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/task.dart';
import '../models/todo.dart';
import 'package:http/http.dart' as http;

class MyAPI{
  Future<List<Task>> getTasks() async{
    await Future.delayed(Duration(seconds: 1));
    //final dataString = await _loadAsset('assets/data/tasks.json');
    final dataString= await _loadAsset('');
    final Map<String,dynamic> json = jsonDecode(dataString);
    if (json['tasks']!=null){
      final tasks = <Task>[];
      json['tasks'].forEach((element){
        tasks.add(Task.fromJson(element));
      });
      return tasks;
    }else{
      return [];
    }
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }

  Future<List<Todo>> getTodos() async {
    final response = await http.get(
      //Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      Uri.parse(''),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List<dynamic> json = jsonDecode(response.body);
      final todos = <Todo>[];
      for (var element in json) {
        todos.add(Todo.fromJson(element));
      }
      return todos;
    }
    else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}