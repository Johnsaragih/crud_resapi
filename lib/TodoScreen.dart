import 'package:crudapi1/TaskScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'models/todo.dart';


class TodoList extends StatelessWidget {
  final List<Todo> todos;
  TodoList({ Key key, this.todos});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: index % 2==0 ? Colors.greenAccent:Colors.cyan,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(todos[index].id,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                new Text(todos[index].ssid,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskScreen(todoId: todos[index].id)));
          },
        );
      },
      itemCount: todos.length,
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch todo from restful"),

      ),
      body: FutureBuilder(
        future: ambildata(http.Client()),
        builder: (context,snapshot) {
          if(snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData ? TodoList(todos: snapshot.data):Center(child: CircularProgressIndicator());
        },
      ),
      
    );
  }
}