import 'package:flutter/material.dart';
import '../api/myApi.dart';
import '../models/task.dart';
import '../ui/detail.dart';
  
class ScreenTwo extends StatelessWidget{
  ScreenTwo({super.key});

  final MyAPI myApi = MyAPI();



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myApi.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length??0,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      color : Colors.white70,
                      elevation: 7,
                      margin: EdgeInsets.all(10),
                      child : ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.lightBlue,child: Text(snapshot.data?[index].id.toString()??""),),
                        title: Text(snapshot.data?[index].title??""),
                        subtitle: Text(snapshot.data?[index].description??""),
                        trailing: Icon(Icons.favorite_rounded),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => DetailScreenTask(task: Task(id: snapshot.data![index].id, title: snapshot.data![index].title, tags: snapshot.data![index].tags, nbhours: snapshot.data![index].nbhours, difficulty: snapshot.data![index].difficulty, description: snapshot.data![index].description)),
                            ),
                          );
                        },
                      )
                  );
                }
            );
          }
          return Container();
        }
    );
  }
}
