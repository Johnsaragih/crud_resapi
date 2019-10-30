import 'package:crudapi1/models/task.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class DetailTaskScreen extends StatefulWidget {
final String id;

DetailTaskScreen({this.id}):super();

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),

      ),
      body: FutureBuilder(
        future: ambiltaskbyId(http.Client(), widget.id),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData) {
            return DetailTask(task: snapshot.data);
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DetailTask extends StatefulWidget {
  final Task task;
  DetailTask({Key key, this.task}) : super();

  @override
  _DetailTaskState createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  Task task =new Task();
  bool isLoadedTask = false ;

  @override
  Widget build(BuildContext context) {
    if(isLoadedTask==false) {
      setState(() {
        this.task=Task.fromtask(widget.task); //fromtask dari model task dart coy
        this.isLoadedTask=true;
      });
    }

  final TextField _txtTaskName = new TextField(
    decoration: InputDecoration(
      hintText: "Enter name",
      contentPadding: EdgeInsets.all(10.0),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
    ),
    autocorrect: false,
    controller: TextEditingController(text: this.task.ssid),
    textAlign: TextAlign.left,
    onChanged: (text) {
      setState(() {
        this.task.ssid= text;
      });
    },
  );

  final Text _txtFinished = Text("Finished:", style: TextStyle(fontSize: 16.0));
  
  final Checkbox _cbFinished = Checkbox(
      value: this.task.ssid= value,
      onChanged: (bool value) {
        setState(() {
          this.task.ssid = value;
        });
      },

  );


    return Container(
      
    );
  }
}