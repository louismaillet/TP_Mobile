import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_mobile/viewmodel/taskviewmodel.dart';
import '../models/task.dart';
import 'addtask.dart';

class ScreenOne extends StatelessWidget {
  ScreenOne({super.key});

  late List<Task> taches;


  @override
  Widget build(BuildContext context) {
    taches = context.watch<TaskViewModel>().liste;
    return ListView.builder(
        itemCount: taches.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color : Colors.white70,
            elevation: 7,
            margin: EdgeInsets.all(10),
            child : ListTile(
              leading: CircleAvatar(backgroundColor: Colors.lightBlue,child: Text(taches[index].id.toString()),),
              title: Text(taches[index].title),
              subtitle: Text(taches[index].description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTask(task: taches[index]),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<TaskViewModel>().deleteTask(index);
                    },
                  ),
                ],
              ),
            )
          );
        }
    );
  }
}


/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste de Tache')),
      body: taches.isNotEmpty ? ListView.builder(
        itemCount: taches.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item ${index + 1}'),
          );
        },
      )
          : const Center(child: Text('No items')),
    );
  }
}
*/
