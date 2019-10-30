
import 'dart:convert';
import 'package:crudapi1/global.dart';
import 'package:http/http.dart' as http;


class Todo {
  String id;
  String ssid;
  
  Todo({this.id, this.ssid});

  factory Todo.fromjson(Map<String, dynamic> objson) {
  return Todo(
      id: objson['id'],
      ssid: objson['ssid']
    );
  }
}

// fetch data from restfull api

Future<List<Todo>> ambildata(http.Client client) async {
  final respon = await client.get(URL_TODOS);
  if(respon.statusCode == 200) {
    Map<String, dynamic> respondimaping = jsonDecode(respon.body);
    if(respondimaping["messages"]=="sukses") {
      final todos = respondimaping['data'].cast<Map<String, dynamic>>();
      final listtodos = await todos.map<Todo>((json) {
        return Todo.fromjson(json);
        }).toList();
        return listtodos;
    } else {
      return [];
    }
    } else {
      throw Exception('Failed load data from api');
    }  
  }
