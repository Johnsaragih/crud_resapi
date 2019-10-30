import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/task.dart';

class TaskScreen extends StatefulWidget {
  final String todoId;
  TaskScreen({this.todoId}) : super();

  @override
  // _TaskScreenState createState() => _TaskScreenState();

  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List data"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //button ke detail task
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: ambiltask(http.Client(), widget.todoId),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? TaskList(tasks: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  TaskList({Key key, this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: index % 2 == 0 ? Colors.deepOrange : Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.tasks[index].ssid,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  Text('Finishied : ${tasks[index].finished==true?"Yes":"No"}',style: TextStyle(fontSize: 16.0),)
              ],
            ),
          ),
          onTap: () {
           // String selectedId = tasks.id;
          },
        );
      },
    );
  }
}
