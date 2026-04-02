import 'package:flutter/material.dart';
import '../api/myApi.dart';
import '../models/todo.dart';
import '../ui/detail.dart';

class ScreenThree extends StatelessWidget{
  ScreenThree({super.key});

  final MyAPI myApi = MyAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myApi.getTodos(),
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
                        subtitle: Checkbox(value: snapshot.data?[index].completed, onChanged: (bool? value) {  },),
                        trailing: Icon(Icons.favorite_rounded),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => DetailScreenTodo(todo: Todo(snapshot.data![index].id, snapshot.data![index].title, snapshot.data![index].completed)),
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