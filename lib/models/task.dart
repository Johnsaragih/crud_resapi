
import 'dart:convert';
import 'package:crudapi1/global.dart';
import 'package:http/http.dart' as http;


class Task {
  String id;
  String ssid;

  Task({this.id, this.ssid});

  factory Task.fromjson(Map<String, dynamic>objson) {

    Task newTask = Task(
      id: objson['id'],
      ssid: objson['ssid']
    );
    return newTask;
    }

  factory Task.fromtask(Task anothertask) {
    return Task(
      id: anothertask.id,
      ssid: anothertask.ssid 
      );
  }
}

Future<List<Task>> ambiltask(http.Client client, String todoId) async {
final respon = await client.get('$URL_TASK_BY_TODOID');
if(respon.statusCode == 200) {
  Map<String, dynamic> respondimaping = jsonDecode(respon.body);
  if(respondimaping["messages"]=="sukses") {
    final task = respondimaping["data"].cast<Map<String, dynamic>>();
    return task.map<Task>((json) {
      return Task.fromjson(json);
    }).toList();
  } else 
  {
    return [];
  }
}
else {
  throw Exception('failed load task');
  }
}

//fetch by id

Future<Task> ambiltaskbyId(http.Client client, int id) async {
  final String url ='$URL_TASK_BY_TODOID';
  final respon = await client.get(url);
  if(respon.statusCode==200) {
    Map<String, dynamic> respondimaping=jsonDecode(respon.body);
    if(respondimaping["messages"=="sukses"]) {
      Map<String, dynamic> maptask=respondimaping["data"];
      return Task.fromjson(maptask);
    } else 
    {
      return Task();
    }
  }
  else {
        throw Exception('Failed get detail with id={id}');
  }
}



